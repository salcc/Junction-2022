import numpy as np
import seaborn as sns

from random import random, randint


class Chat():
    def __init__(self):
        # Define states
        # A state can be seen as a tuple of four components, each one have a finite number of values. Also we need the initial state, where
        # we start a conversation, this tuple will be [0,0,0,0]
        # 1-4, 5-9, 10-14, 15-19, 20-24, 25+
        self.MESSAGE_LENGHTS = 6
        # We put a maximum at 15
        self.EXPRESSIVITY = 15
        # Binary variable
        self.BAD_LANGUAGE = 2
        # <1min, 1-2min, 3-5min, 5-30min, 30-2h, 2-8h, 8h-2d, 2-5d, +5d
        self.TIME_RANGES = 9

        # Number of states
        self.N_STATES = self.MESSAGE_LENGHTS * self.TIME_RANGES * self.EXPRESSIVITY * self.BAD_LANGUAGE + 1

        # Define parameters
        self.GAMMA = 1
        self.ALPHA = 0.5
        self.EPSILON = 0.1
        self.N_EPISODES = 10

        # For the actions, we need to save the two type of messages our data_bot can send
        self.TOPICS = self._read_lines_from_txt("Topics.txt")
        self.REGULATIONS = self._read_lines_from_txt("Regulations.txt")
        self.BAD_EXPR = self._read_lines_from_txt("BadLanguage.txt")


        self.TOPICS_ACTIONS = len(self.TOPICS)
        self.REGULATIONS_ACTIONS = len(self.REGULATIONS)
        self.N_ACTIONS = self.TOPICS_ACTIONS + self.REGULATIONS_ACTIONS + 1

        # Define inital
        self.INI_STATE = 0

        # Define action-value function
        self.Q_FUN = np.zeros((self.N_STATES, self.N_ACTIONS))
        # Define state-value function only for plotting purposes
        self.V_FUN = np.zeros(self.N_STATES)

    def _read_lines_from_txt(self, path):
        file = open(path, 'r')
        return np.array([line[:-1] for line in file.readlines()])

    ''' Convert tuple to scalar state '''
    ''' A tuple contains integers in the range 1 to maximum of every component'''
    def get_state(self, tupleT):
        if (tupleT == np.array([0,0,0,0])).all():
            return 0

        state = 0
        for index, hyperparameter in enumerate([self.EXPRESSIVITY, self.BAD_LANGUAGE, self.TIME_RANGES, 1]):
            state += (tupleT[index]-1)
            state *= hyperparameter

        return state + 1

    ''' Convert state s from scalar to tuple'''
    def get_tuple(self, state):
        if state == 0:
            return np.array([0,0,0,0])
        else:
            tupleT = [0,0,0,0]
            ss = state - 1
            tupleT[0] = ss // (self.TIME_RANGES*self.BAD_LANGUAGE*self.EXPRESSIVITY)
            aux = ss % self.TIME_RANGES*self.BAD_LANGUAGE*self.EXPRESSIVITY
            tupleT[1] = aux // (self.TIME_RANGES*self.BAD_LANGUAGE)
            aux2 = aux % self.TIME_RANGES*self.BAD_LANGUAGE
            tupleT[2] = aux2 // self.TIME_RANGES
            aux3 = aux2 % self.TIME_RANGES
            tupleT[3] = aux3
            return np.array(tupleT)+1

    '''
    Computes next state and reward

    Params:
        - int: state in {0,..., N_STATES-1}
    Returns:
        - int: next_state in {0,..., N_STATES-1}
        - int: reward
    '''
    '''An encoder for the time'''
    def encode_time(self, time):
        # <1min, 1-2min, 3-5min, 5-30min, 30-2h, 2-8h, 8h-2d, 2-5d, +5d
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
        if time < 2*24*60 + 1:
            return 7
        if time < 5*24*60 + 1:
            return 8
        return 9

    '''We first need a function that encodes a given message'''
    def encode_message(self, message):
        Message = message.split()
        count = len(Message)
        count2 = message.count('?') + message.count('!')
        
        for expr in self.BAD_EXPR:
            if message.find(expr) != -1:
                return np.array([min(((count-1)//5)+1, 6), min(count2+1, 15), 2, self.encode_time(int(Message[len(Message)-1]))])
        return np.array([min(((count-1)//5)+1, 6), min(count2+1, 15), 1, self.encode_time(int(Message[len(Message)-1]))])

    '''And now the metric for the reward'''
    def reward(self, message):
        return message[0]**2 + 0.3*message[1] -10*message[2] - 0.5*message[3]**2

    ''' We need to read the following message'''
    def next_position(self, message):
        return self.get_state(self.encode_message(message)), self.reward(self.encode_message(message))

    '''
    Performs greedy policy. With prob epsilon pick action
    belonging to maximum action-value. With prob 1-epsilon
    pick a random action.

    Params:
        - int: state in {0,..., N_STATES-1}
    Returns:
        - int: action in {0,..., N_ACTIONS-1}
    '''
    def greedy_policy(self, state):

        if self.get_tuple(state)[2] == 1 or state == 0:
            action = np.argmax(self.Q_FUN[state][:self.TOPICS_ACTIONS+1])
            if random() < self.EPSILON:
                action = randint(0, self.TOPICS_ACTIONS + 1)
            if action < self.TOPICS_ACTIONS:
                print(self.TOPICS[action])
        else:
            action = self.TOPICS_ACTIONS+1+np.argmax(self.Q_FUN[state][self.TOPICS_ACTIONS+1:])
            if random() < self.EPSILON:
                action = randint(self.TOPICS_ACTIONS + 1, self.N_ACTIONS)
            print(self.REGULATIONS[action - self.TOPICS_ACTIONS-1])

        return action

    '''
    Compute state-value function

    Returns:
        - list: V_FUN
    '''
    def compute_v_fun(self):
        for i, action_values in enumerate(self.Q_FUN):
            self.V_FUN[i] = np.max(self.Q_FUN[i])
        return self.V_FUN

    '''
    Compute actions taken in each state.

    Params:
        - boolean: double, indicates whether we are using double q-learning or not
    Returns:
        - list: actions, one for each state
    '''
    def compute_actions(self):
        actions = []
        for s in range(self.N_STATES):
            actions.append(np.argmax(self.Q_FUN[s]))

        return np.array(actions)

    '''
    The following functions are the different algorithms we will try.
    Basically we do two things:
        1. Compute next_state and next_action
        2. Update action-values (Q_FUN)

    Params:
        - int: state in {0,..., N_STATES-1}
        - int: action in {0,..., N_ACTIONS-1}

    Returns:
        - int: next_state in {0,..., N_STATES-1}
        - int: next_action in {0,..., N_ACTIONS-1}
    '''
    def q_learning(self, state, action):
        print("Introdueix un missatge acabat en un numero que representa els minuts d'espera que has trigat a contestar: ")
        message = str(input())
        next_state, reward = self.next_position(message)

        if self.get_tuple(next_state)[2] == 2:
            off_policy_action = self.TOPICS_ACTIONS+1+np.argmax(self.Q_FUN[next_state][self.TOPICS_ACTIONS+1:])
        else:
            off_policy_action = np.argmax(self.Q_FUN[next_state][:self.TOPICS_ACTIONS+1])
        self.Q_FUN[state, action] += self.ALPHA*(reward + self.GAMMA*self.Q_FUN[next_state, off_policy_action] - self.Q_FUN[state, action])

        next_action = self.greedy_policy(next_state)
        return next_state, next_action



chat = Chat()
for i in range(chat.N_EPISODES):
    state = chat.INI_STATE
    action = chat.greedy_policy(state)
    n_count = 0

    while n_count < 3:
        next_state, next_action = chat.q_learning(state, action)

        action = next_action
        state = next_state

        n_count += 1
    if i==0:
        np.savetxt('CurrentQ_FUN.txt',chat.Q_FUN,fmt='%.4f')
        np.savetxt('CurrentV_FUN.txt',chat.V_FUN,fmt='%.4f')
        np.savetxt('CurrentPolicy.txt',chat.compute_actions(),fmt='%.4f')
