# Sample dataset

Includes complete definition of a sample dataset for the application. It works with a file-based lightweight approach to get functionalities rolling.  
The dataset definition has the following contents:
* _profiles.json_: Contains the profile data for a user with the following structure

```json
    {
        "<user_id>" : {
            "age" : <some integer>,
            "gender" : <str in (Female, Male, Other)>: ,
            "occupation_status" : <str in (Student & Employed, Student, Worker Employed, Worker Unemployed)>,
            "description" : free str
        }
    }
```

* _series.csv_: Contains the time series of data for the app initialization evals provided by the users.

| **user_id**   | **date**                         | perception            |
|-----------|------------------------------|-----------------------|
| <user_id> | <str in "dd:mm:YYYY" format> | <int in [1, 2,3,4,5]> |

* _feedback.csv_: Contains the gathered feedback from a user in relationship with a connection specified by it's own _user_id_ and the _reciever_ids_

| **user_id** | **reciever_ids**    | feedback_action                 |
|-------------|---------------------|---------------------------------|
| <user_id>   | <list of <user_id>> | <str in (Helpful, Exit, Later)> |

* A set of _<conversation_id>.csv_ files with time labeled messages for each conversation where the id is defined by the concatenation of the user ids separated by a delimiter ';' where the values are sorted ascendingly:

| **sender_id** | **date**                       | message_contents     |
|---------------|--------------------------------|----------------------|
| <user_id>     | <str in "dd:mm:YYYY hh:mm:ss"> | free str             |