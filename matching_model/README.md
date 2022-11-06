## Matching model
Usage implementation based on a [Large pretrained embedding transformer](https://arxiv.org/abs/2004.05150) mapping documents to latent space representations [based on similarities](https://d4mucfpksywv.cloudfront.net/better-language-models/language_models_are_unsupervised_multitask_learners.pdf)

The key aspect is the fact that the model is re-trained with a metric lerning approach taking into consideration the feedback and status data that the application gathers from user's usage. 

The loss function is an adaptation of a contrastive loss considering the gathered data from the application. It is defined mathematically as follows (expression + decomposition):


<img src="loss_def.png" alt="sdef" height="25" width="1500"/>
<br />
* Inputs: $x_a$, $x_b$, $u_a$, $u_b$ are the descriptions and profile parameters for current user and reciever repectively $c$ is the categorization of a non-Later feedback in {0,1} for Exit and Success status respectively and  
<img src="s_def.png" alt="sdef" height="50"/>  
with $x_j$ being the time instance j and $h(x_{j})$ the reported status value which is a weighted decay averge of the discrete derivative of the time series.

* Functions:
 $f$ is the large language model, $g$ is a static embedder for user profile data, $\sigma$ is the sigmoid function.

* Parameters: $\alpha$ wheights the contribution of the feedback categorization, $\beta$ weights the contribution of the reporting scores, $\tau$ is the switcher thresohld which tells the part of the loss to evaluate, $m$ is the margin for the max function in pseudo-negative case and $\theta$ are the model weights.

This function allows us to categorize whether a pair of embeddings should be closer or further based on the extracted features representing connection quality and to penalize the model accordingly. The more active user we have and the larger amounts of data we can gather from their connections the better should our model be.
