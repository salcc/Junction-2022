# The Chat Bot
We have created an assistant for the conversations, a bot that helps users to have a connection among each other, that
helps to make a fluent and engaging chat which allows the participants to open themselves and get to know each other. Moreover,
we wanted to build a safe space, where disrespect is noticed and not welcome. What we have built is a chat bot that provides interesting topics
of any kind to talk about and choses a fit moment to propose them, but also displays warnings when the words become violent.
In order to achieve that, we have developed an algorithm based on Reinforcement Learning, an area of Artificial Intelligence,
that does all this job automatically, learning from real interactions by a system of rewards. But technically, what do we mean by that?

## Description of the algorithm
A conversation will be a sequence of topics that will be discussed by two participants (maybe more, if we alloe group chats).
The topics will be formulated as a short question which aims to engage the active participation among all participants. The quality
of conversation is what we pretend to optimize with this algorithm.

### Reinforcement Learning Approach
The mathematical scenario were RL takes place is the following: there is a finite set of states, a finite set of actions and rewards. We jump from one state to another by picking an action, that is, if we are on a state $$s_t$$ at time $$t$$ and we pick an action $$a_t$$ we end up at state $$s_{t+1}$$. This is not deterministic, that is, we don't know what the state is going to be after we chose an action, this is a random variable. Once this is done,
a reward $$r_t$$ is produced, also as a random variable, and we start again. The goal is to maximize the expected reward by obtaining a policy that choses an action given a state.

That said, how do we define our space to make them fit for our problem?

### Mathematical space of the problem

#### States of a conversation:
The state of a conversation will be a set of measures in which we measure a message and the time between
that message and the previous message. Another state must be defined for the case we don't get an answer by the other user (after an explicit amount
of time has passed, for example). What are the metrics chosen for a state?
-Lenght in words of a message. If it has less than 5 words it is set to 1, if it has less than 10 and 5 or more it is set to 2 and so on,
until a maximum of 25 words or more, in that case it is set to 6.
-Expressivity: number of '?' and '!' present in the message, until a maximum of 15: that is a measure of intensity and expressivity of a message, we will try to maximize this.
-Bad expressions detector (BE): if there is some bad language detected automatically warning messages will appear. This is a binary variable.
-Time between this and the previous message, also in a measure that reduces our sample space (<1min, 1-2min, 3-5min, 5-30min, 30-2h, 2-8h, 8h-2d, 2-5d, +5d).
Note that this produces a finite (and quite small) number of states.
A state is a tuple of for elements, each one with a number of possibilities (6, 15, 2 and 9). The initial state (without previous message) will be represented by [0,0,0,0].


#### Actions:
Depending on that state, a (provided, not generated) set of messages can be send by the assistant. There will be two type of messages, the topic type
and the regulating type.
-Topic type: a question to develop in a conversation. Ex: How did you feel by that? Do you like your job?
-Regulating type: when bad language is detected. Ex: Calm down please, we need to respect each other. I think is better to change the topic.
Another action is simply don't send any message, which it would be common as the conversation should be leaded in all moment
by the users itself.


#### Rewards:
We need to define a measure of reward that we want to obtimize. A reasonable idea is to minimize the time of getting an answer and
maximize the lenght of that message, in order to obtain a goof fluidity of the conversation.

What is the reward function?
Some weighted norm of this components, or a function of them should work. For example:
L\^2 + 0.5T\4 + 0.3P + 0.3E

Note that after a state, an action is chosen, and that gives us an answer (or not), and that produces a reward. That defines a typical reinforcement
learning problem (where no probability distributions are known, of course), that can be optimized using temporal difference (TD) algorithms like
SARSA, expected SARSA, Q-learning or double Q-learning.

#### Hyperparameters of the model
A set of parameters are introduced in the model, $$\gamma,\quad\alpha,\quad\epsilon$$ and n_episodes. Don't worry about them, they are choices in terms of how the optimization is done, the choice is just the usual one.

#### Metrics of the model
Three metrics will be saved of the model: Q_FUN, V_FUN and Policy. This saves what is the policy, that is, the set of actions, obtained every time we use the algorithm. Once a conversation is produced, we will use this policy, and as it is happening, it will be optimized, then it will be saved for the next use. This will hapen every time is used, for ever (or until an optimum one is obtained) and therefore the algorithm will keep getting better and better.

#### Links of interest
- [Topics](https://parade.com/969981/parade/conversation-starters/)
- Bad expressions
    - [Cambridge](https://dictionary.cambridge.org/grammar/british-grammar/swearing-and-taboo-expressions)
    - [Business Insider](https://www.businessinsider.com/offensive-phrases-that-people-still-use-2013-11?r=US&IR=T#1-the-itis-1)
    - [Macmillan](https://www.macmillandictionary.com/thesaurus-category/british/impolite-and-offensive-expressions-used-when-annoyed-or-angry)
