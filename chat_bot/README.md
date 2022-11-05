We present a reinforcement learning algorithm to produce a good chat assistant. What do we mean by that?
A conversation will be a sequence of topics that will be discussed by two participants (maybe more, if we alloe group chats).
The topics will be formulated as a short question which aims to engage the active participation among all participants. The quality
of conversation is what we pretend to optimize with this algorithm.

That said, how do we define our paramters?

States of a conversation: The state of a conversation will be a set of measures in which we measure a message and the time between
that message and the previous message. Another state must be defined for the case we don't get an answer by the other user (after an explicit amount
of time has passed, for example).

Actions: Depending on that state, a (provided, not generated) set of messages can be send by the assistant. There will be two type of messages, the topic type
and the regulating type.
-Topic type: a question to develop in a conversation. Ex: How did you feel by that? Do you like your job?
-Regulating type: when bad language is detected. Ex: Calm down please, we need to respect each other. I think is better to change the topic.
Another action is simply don't send any message, which it would be common as the conversation should be leaded in all moment
by the users itself.

Rewards: We need to define a measure of reward that we want to obtimize. A reasonable idea is just to minimize the time of getting an answer and
maximize the lenght of that message, so we'll leave it at that as a first tactic.

Note that after a state, an action is chosen, and that gives us an answer (or not), and that produces a reward. That defines a typical reinforcement
learning problem (where no probability distributions are known, of course), that can be optimized using temporal difference (TD) algorithms like
SARSA, expected SARSA, Q-learning or double Q-learning.

What are the metrics for a state?
-Lenght (L)(not necessarily in words, but maybe in groups of 5 words or something like that which allow us to reduce the sample space).
-Time between this and the previous message (T), also in some measure that reduces our sample space (maybe number of hours, or first in number
of minutes, then every 5, 10, 30 minutes, then every hour, 2, 5, 1 day, 2, 5 and we stop after 7 days, for example).
-Number of the punctuation symbols '?' and '!' (P): that is a measure of intensity and expressivity of a message, we will try to maximize this.
-Bad expressions detector (BE): if there is some bad language detected automatically warning messages will appear. This is a binary variable.
-Number of emojis (E): same as variable P.
Note that this produces a finite (and quite small) number of states.

What is the reward function?
Some weighted norm of this components, or a function of them should work. For example:
L**2 + 0.5T**4 + 0.3P + 0.3E

What are the actions?
If bad language is detected, a dictionary of bad language and an answer message is built and the action is deterministic.
Otherwise, the action is chosen from a set of topics that are provided.

Set of possible topics:
https://parade.com/969981/parade/conversation-starters/

Sources for bad expressions:
https://dictionary.cambridge.org/grammar/british-grammar/swearing-and-taboo-expressions
https://www.businessinsider.com/offensive-phrases-that-people-still-use-2013-11?r=US&IR=T#1-the-itis-1
https://www.macmillandictionary.com/thesaurus-category/british/impolite-and-offensive-expressions-used-when-annoyed-or-angry
