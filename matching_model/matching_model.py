from typing import List
import torch
import torch.nn as nn
from torch import Tensor
from tqdm import tqdm

from matching_data import get_evolution_exponential_weighted_decay, get_tokenization, profiles_feature_extraction


def embeddings_distance(embeddings1: Tensor, embeddings2: Tensor):
  cos_sim = nn.CosineSimilarity(dim=1, eps=1e-6)
  return cos_sim(embeddings1, embeddings2)


class MatchingLoss(nn.Module):
  def __init__(self, margin: float, alpha: float, beta: float, tau: float = 0.5):
    super(MatchingLoss, self).__init__()
    self.margin = Tensor([margin])
    self.alpha = Tensor([alpha])
    self.beta = Tensor([beta])
    self.tau = Tensor([tau])
    self.sigmoid = nn.Sigmoid()

  def forward(self, user_embeddings: Tensor, reciever_embeddings: Tensor, feedback: int, evolution: float, user_profile_features: Tensor, reciever_profile_features: Tensor) -> float:
    feedback = Tensor([feedback])
    evolution = Tensor([evolution])

    flattened_user_embeddings = user_embeddings.view(1, -1)
    flattened_reciever_embeddings = reciever_embeddings.view(1, -1)

    complete_user_embeddings = torch.cat((flattened_user_embeddings, user_profile_features), 1)
    complete_reciever_embeddings = torch.cat((flattened_reciever_embeddings, reciever_profile_features), 1)

    switch = torch.floor(self.tau + self.sigmoid(self.alpha * feedback + self.beta * evolution))
    return switch * embeddings_distance(complete_user_embeddings, complete_reciever_embeddings)**2 \
          + switch * max(0, self.margin - embeddings_distance(complete_user_embeddings, complete_reciever_embeddings))**2


def retrain(user_id: int, group_peers_ids: List[int], user_feedback: int, tokenizer, optimizer, model, matching_loss, device):
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
