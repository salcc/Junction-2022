## Matching model
Meta-model containing:

 * Large pretrained embedding transformer mapping documents to latent space representations based on similarities

 * User profile information

The model is re-trained through a metric lerning approach based on a custom adaptation of a contrastive loss which considers user feedback and status tracking data.

The loss function is an adaptation of a contrastive loss for metric learning to the data we are able to extract through user application usage. It is defined mathematically as follows (expression + decomposition):


<img src="loss_def.png" alt="sdef" height="25" width="1500"/>
<br />
* Inputs: $x_a$, $x_b$, $u_a$, $u_b$ are the descriptions and profile parameters for current user and reciever repectively $c$ is the categorization of a non-Later feedback in {0,1} for Exit and Success status respectively and  
<img src="s_def.png" alt="sdef" height="50"/>  
with $x_j$ being the time instance j and $h(x_{j})$ the reported status value which is a weighted decay averge of the discrete derivative of the time series.

* Functions:
 $f$ is the large language model, $g$ is a static embedder for user profile data, $\sigma$ is the sigmoid function.

* Parameters: $\alpha$ wheights the contribution of the feedback categorization, $\beta$ weights the contribution of the reporting scores, $\tau$ is the switcher thresohld which tells the part of the loss to evaluate, $m$ is the margin for the max function in pseudo-negative case and $\theta$ are the model weights.
