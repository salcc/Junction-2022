# Junction 2022

### What have we built?
We have built a data-driven platform that allows users to:
 * Express and track their mental status
 * Anonymously connect and empathize with other users based on likelihood of improvement through a chat channel.

### Solution contents:
 * [Flutter working demo app](salcc/Junction-2022/app/) with the basic features of our platform.
 * [Matchmaking model](salcc/Junction-2022/matching_model/) based on a large pretrained embedding transformer mapping documents to latent space representations gathering similarities and user profile extracted features. The model is re-trained through a metric lerning approach based on a custom adaptation of a contrastive loss which considers user feedback and status tracking data.
 * [Chat assistant bot](salcc/Junction-2022/chat_bot/) modeled as an agent in a chat enironment where conversation score-based rewards and penalizations are extracted to apply reinforcement learning.
 * [Sample Dataset](salcc/Junction-2022/sample_dataset/) containing a definition and some rows of a lightweight pseudo-datawharehouse.


### Key aspect, automated improvement of the solution based on the usage gathered data unlocking:
 * Re-training our matching model based on user feedback and improvement results
 * Conversation data defining an environment for a virtual chat assistant dealing with ice-breakers, destructive conversations,etc. aiming to maximize connection quality.

The more usage the app has the better performance the AI could bring.

### Video Demo:
We are preparing a video demo (coming soon)

### Authors:
[Jordi Baroja](https://www.linkedin.com/in/jordi-baroja-209b99225/)  
[Marçal Comajoan](https://www.linkedin.com/in/marcal-comajoan/)  
[Mauro Filomeno](https://www.linkedin.com/in/maurofilomeno/)  
[Marc Franquesa](https://www.linkedin.com/in/marc-franquesa-mon%C3%A9s-0015661b2/)  
[Pol Puigdemont](https://www.linkedin.com/in/polpuigdemont/)
