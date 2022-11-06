from os.path import exists
from random import randint, random
from typing import List, Sequence, Tuple

import numpy as np
import seaborn as sns


class ChatBotModel:
    def __init__(self):
        self.MESSAGE_LENGHTS = 6
        self.EXPRESSIVITY = 15
        self.BAD_LANGUAGE = 2
        self.TIME_RANGES = 9

        self.N_STATES = (
            self.MESSAGE_LENGHTS
            * self.TIME_RANGES
            * self.EXPRESSIVITY
            * self.BAD_LANGUAGE
            + 1
        )

        self.GAMMA = 1
        self.ALPHA = 0.5
        self.EPSILON = 0.1
        self.N_EPISODES = 10

        self.TOPICS = self._read_lines_from_txt("Topics.txt")
        self.REGULATIONS = self._read_lines_from_txt("Regulations.txt")
        self.BAD_EXPR = self._read_lines_from_txt("BadLanguage.txt")

        self.TOPICS_ACTIONS = len(self.TOPICS)
        self.REGULATIONS_ACTIONS = len(self.REGULATIONS)
        self.N_ACTIONS = self.TOPICS_ACTIONS + self.REGULATIONS_ACTIONS + 1

        self.INI_STATE = 0

        if exists("CurrentQ_FUN.txt"):
            self.Q_FUN = np.loadtxt("CurrentQ_FUN.txt", delimiter=",")
        else:
            self.Q_FUN = np.zeros((self.N_STATES, self.N_ACTIONS))

        # For plotting purposes
        if exists("CurrentV_FUN.txt"):
            self.V_FUN = [float(line[:-1]) for line in open("CurrentV_FUN.txt", "r")]
        else:
            self.V_FUN = np.zeros(self.N_STATES)


    def _read_lines_from_txt(self, path: str) -> np.array:
        file = open(path, "r")
        return np.array([line[:-1] for line in file.readlines()])


    def to_scalar(self, tupleT: np.array) -> int:
        if (tupleT == np.array([0, 0, 0, 0])).all():
            return 0

        state = 0
        for index, hyperparameter in enumerate(
            [self.EXPRESSIVITY, self.BAD_LANGUAGE, self.TIME_RANGES, 1]
        ):
            state += tupleT[index] - 1
            state *= hyperparameter

        return state + 1


    def to_array(self, state: int) -> np.array:
        if state == 0:
            return np.array([0, 0, 0, 0])
        else:
            tupleT = [0, 0, 0, 0]
            ss = state - 1
            tupleT[0] = ss // (self.TIME_RANGES * self.BAD_LANGUAGE * self.EXPRESSIVITY)
            aux = ss % (self.TIME_RANGES * self.BAD_LANGUAGE * self.EXPRESSIVITY)
            tupleT[1] = aux // (self.TIME_RANGES * self.BAD_LANGUAGE)
            aux2 = aux % (self.TIME_RANGES * self.BAD_LANGUAGE)
            tupleT[2] = aux2 // self.TIME_RANGES
            aux3 = aux2 % self.TIME_RANGES
            tupleT[3] = aux3
            return np.array(tupleT) + 1


    def encode_time(self, time: int) -> int:
        """ Time input is in minutes """
        if time == 0:
            return 1
        if time < 3:
            return 2
        if time < 6:
            return 3
        if time < 31:
            return 4
        if time < 121:
            return 5
        if time < 481:
            return 6
        if time < 2 * 24 * 60 + 1:
            return 7
        if time < 5 * 24 * 60 + 1:
            return 8
        return 9


    def encode_message(self, message: str) -> np.array:
        Message = message.split()
        count = len(Message)
        count2 = message.count("?") + message.count("!")

        for expr in self.BAD_EXPR:
            if message.find(expr) != -1:
                return np.array(
                    [
                        min(((count - 1) // 5) + 1, 6),
                        min(count2 + 1, 15),
                        2,
                        self.encode_time(int(Message[len(Message) - 1])),
                    ]
                )
        return np.array(
            [
                min(((count - 1) // 5) + 1, 6),
                min(count2 + 1, 15),
                1,
                self.encode_time(int(Message[len(Message) - 1])),
            ]
        )


    def reward(self, message: str) -> float:
        return (
            message[0] ** 2 + 2 * message[1] ** 2 - 10 * message[2] ** 2 - 0.5 * message[3]
        )


    def next_position(self, message: str) -> Tuple[float]:
        return (
            self.to_scalar(self.encode_message(message)),
            self.reward(self.encode_message(message)),
        )


    def pick_action(self, state: int) -> int:
        if self.to_array(state)[2] == 1 or state == 0:
            action = np.argmax(self.Q_FUN[state][: self.TOPICS_ACTIONS + 1])
            if random() < self.EPSILON:
                action = randint(0, self.TOPICS_ACTIONS + 1)
            if action < self.TOPICS_ACTIONS:
                print(self.TOPICS[action])
        else:
            action = (
                self.TOPICS_ACTIONS
                + 1
                + np.argmax(self.Q_FUN[state][self.TOPICS_ACTIONS + 1 :])
            )
            if random() < self.EPSILON:
                action = randint(self.TOPICS_ACTIONS + 1, self.N_ACTIONS)
            print(self.REGULATIONS[action - self.TOPICS_ACTIONS - 1])

        return action


    def compute_v_fun(self) -> List[float]:
        for i, action_values in enumerate(self.Q_FUN):
            self.V_FUN[i] = np.max(self.Q_FUN[i])
        return self.V_FUN


    def compute_actions(self) -> np.array:
        actions = []
        for s in range(self.N_STATES):
            actions.append(np.argmax(self.Q_FUN[s]))

        return np.array(actions)


    def q_learning(self, state: int, action: int) -> Sequence[int]:
        """
        The following functions are the different algorithms we will try.
        Two options:
            1. Compute next_state and next_action
            2. Update action-values (Q_FUN)
        """

        print("Insert a message followed by the time it took to answer: ")
        message = str(input())
        next_state, reward = self.next_position(message)

        if self.to_array(next_state)[2] == 2:
            off_policy_action = (
                self.TOPICS_ACTIONS
                + 1
                + np.argmax(self.Q_FUN[next_state][self.TOPICS_ACTIONS + 1 :])
            )
        else:
            off_policy_action = np.argmax(
                self.Q_FUN[next_state][: self.TOPICS_ACTIONS + 1]
            )
        self.Q_FUN[state, action] += self.ALPHA * (
            reward
            + self.GAMMA * self.Q_FUN[next_state, off_policy_action]
            - self.Q_FUN[state, action]
        )

        next_action = self.pick_action(next_state)

        return next_state, next_action



if __name__ == "__main__":
    # Testing
    chat = ChatBotModel()

    for i in range(chat.N_EPISODES):
        state = chat.INI_STATE
        action = chat.pick_action(state)
        n_count = 0

        while n_count < 300:
            next_state, next_action = chat.q_learning(state, action)

            action = next_action
            state = next_state

            n_count += 1
        if i == 0:
            np.savetxt("CurrentQ_FUN.txt", chat.Q_FUN, delimiter=",", fmt="%.4f")
            np.savetxt("CurrentV_FUN.txt", chat.compute_v_fun(), fmt="%.4f")
            np.savetxt("CurrentPolicy.txt", chat.compute_actions(), fmt="%.4f")
