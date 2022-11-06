from typing import List
from datetime import datetime
import json
import csv
from torch import Tensor, LongTensor

data_folder = "../sample_dataset"

def get_evolution_exponential_weighted_decay(user_id: int, rho: float = 0.5) -> float:
  serie = []
  with open(f"{data_folder}/series.csv") as csvfile:
    data = csv.reader(csvfile, delimiter=';')
    data.__next__()
    serie = [(int(row[2]), datetime.strptime(row[1], "%d-%m-%Y")) for row in data if int(row[0]) == user_id]
  n = len(serie)
  if n == 0:
    print("Id not found")
    return 0
  coeff = (1 - rho) / (1 - rho**n)
  discrete_derivatives = [(serie[i + 1][0] - serie[i][0]) /
                          (abs(serie[i + 1][1] - serie[i][1]).days)
                          for i in range(0, n - 1)]
  return (coeff * sum(rho**(n - i - 1) * discrete_derivatives[i] for i in range(0, n - 1)))


def get_tokenization(user_id: int, tokenizer) -> List[int]:
  user_id = str(user_id)
  with open(f"{data_folder}/profiles.json", "r") as profiles_file:
    profiles = json.load(profiles_file)
    if profiles[user_id]["tokenization"] == "null":  # Note that tokenizations do not need to be recomputed each time as they do not change
      profiles[user_id]["tokenization"] = tokenizer.encode(
          profiles[user_id]["description"], padding="max_length", return_tensors="pt").tolist()[0]
      with open(f"{data_folder}/profiles.json", "w") as profiles_file:
        json.dump(profiles, profiles_file, indent=2, ensure_ascii=False)
  unshaped_tokenization = LongTensor(profiles[user_id]["tokenization"])
  return unshaped_tokenization.view(1, -1)


def get_complete_feedback():
  """Gets explicit feedback"""
  with open(f"{data_folder}/feedback.csv") as csvfile:
    data = csv.reader(csvfile, delimiter=';')
    data.__next__()
    action_mappings = {
        "Helpful": 1,
        "Exit": 0
    }
    feedback = [
        (int(row[0]),
         list(map(int, row[1].split(","))),
         action_mappings[row[3]])
        for row in data if row[3] != "Later"]
  return feedback


def profiles_feature_extraction(ids: list):
  profile_feature_map = {}
  for user_id in ids:
    user_id = str(user_id)
    gender_mapping = {
        "Female": [1, 0, 0],
        "Male": [0, 1, 0],
        "Other": [0, 0, 1]
    }
    occupation_mapping = {
        "Student & Employed": [1, 0, 0, 0],
        "Student": [0, 1, 0, 0],
        "Employed": [0, 0, 1, 0],
        "Unemployed": [0, 0, 0, 1]
    }
    with open(f"{data_folder}/profiles.json", "r") as profiles_file:
      profiles = json.load(profiles_file)
      user_profile = profiles[user_id]
      profile_feature_map[user_id] = Tensor([user_profile["age"],
                                             *gender_mapping[user_profile["gender"]],
                                             *occupation_mapping[user_profile["occupation"]]]).view(1, -1)
  return profile_feature_map


def get_all_user_ids() -> List[int]:
  with open(f"{data_folder}/profiles.json", "r") as profiles_file:
    profiles = json.load(profiles_file)
    return list(map(int, profiles.keys()))
