from typing import List
import torch
import torch.nn as nn
from torch import Tensor
from tqdm import tqdm

from matching_data import get_evolution_exponential_weighted_decay, get_tokenization, profiles_feature_extraction, get_all_user_ids


def embeddings_distance(flattened_embeddings1: Tensor, flattened_embeddings2: Tensor):
  """Computes the cosine similarity between two embeddings"""
  cos_sim = nn.CosineSimilarity(dim=1, eps=1e-6)
  return cos_sim(flattened_embeddings1, flattened_embeddings2)


class MatchingLoss(nn.Module):
  def __init__(self, margin: float, alpha: float, beta: float, tau: float = 0.5):
    """Initializes the loss function with the given hyperparameters"""
    super(MatchingLoss, self).__init__()
    self.margin = Tensor([margin])
    self.alpha = Tensor([alpha])
    self.beta = Tensor([beta])
    self.tau = Tensor([tau])
    self.sigmoid = nn.Sigmoid()

  def forward(self, user_embeddings: Tensor, peer_embeddings: Tensor, feedback: int, evolution: float, user_profile_features: Tensor, peer_profile_features: Tensor) -> float:
    """Computes the constrastive loss for a given pair of embeddings and additional user information"""
    feedback = Tensor([feedback])
    evolution = Tensor([evolution])

    flattened_user_embeddings = user_embeddings.view(1, -1)
    flattened_peer_embeddings = peer_embeddings.view(1, -1)

    complete_user_embeddings = torch.cat((flattened_user_embeddings, user_profile_features), 1)
    complete_peer_embeddings = torch.cat((flattened_peer_embeddings, peer_profile_features), 1)

    switch = torch.floor(self.tau + self.sigmoid(self.alpha * feedback + self.beta * evolution))
    distance = embeddings_distance(complete_user_embeddings, complete_peer_embeddings)
    return switch * distance**2 + switch * max(0, self.margin - distance)**2


def retrain(user_id: int, group_peers_ids: List[int], user_feedback: int, tokenizer, optimizer, model, matching_loss, device):
  """Retrains the model for a given user and a given group of peers. Should be used each time a user gives feedback"""
  model.train()
  user_evolution = get_evolution_exponential_weighted_decay(user_id)
  profile_features = profiles_feature_extraction(group_peers_ids)
  for peer_id in tqdm(group_peers_ids):
    # the last hidden-state is the first element of the output tuple
    user_embeddings = model(get_tokenization(user_id, tokenizer).to(device))[0]
    peer_embeddings = model(get_tokenization(peer_id, tokenizer).to(device))[0]
    loss = matching_loss(user_embeddings, peer_embeddings, user_feedback, user_evolution,
                         profile_features[str(user_id)], profile_features[str(peer_id)])

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()


def k_closest_embeddings(user_id: int, k: int, model, tokenizer):
  """Returns the k closest embeddings to the given user to be used for the group making"""
  flattened_user_embeddings = model(get_tokenization(user_id, tokenizer))[0].view(1, -1)
  all_user_ids = get_all_user_ids()
  all_user_ids.remove(user_id)
  distances = []
  for other_user_id in all_user_ids:
    other_tokenization = get_tokenization(other_user_id, tokenizer)
    distances.append((other_user_id, embeddings_distance(flattened_user_embeddings, model(other_tokenization)[0].view(1, -1))))
  return sorted(distances, key=lambda x: x[1])[:k]
