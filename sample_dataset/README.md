# Sample dataset

Includes complete definition of a sample dataset for the application. It works with a file-based lightweight approach to get functionalities rolling.  
The dataset definition has the following contents:
* _profiles.json_: Contains the profile data for a user with the following structure

```json
    {
        "<user_id>" : {
            "age" : "<integer>",
            "gender" : "<Female | Male | Other>" ,
            "occupation_status" : "<Student & Employed | Student | Employed | Unemployed>",
            "description" : "<string>",
            "tokenization" : "<null or list of integers>"
        }
    }
```

* _series.csv_: Contains the time series of data for the app initialization evals provided by the users.

| **user_id**   | **date**                         | perception            |
|-----------|------------------------------|-----------------------|
| <user_id> | <str in "dd-mm-YYYY" format> | <1 \| 2 \| 3 \| 4 \| 5>

* _feedback.csv_: Contains the gathered feedback from a user in relationship with a connection specified by it's own _user_id_ and the _reciever_ids_

| **user_id** | **group_peers_ids**    | **date**                 | feedback_action |
|-------------|---------------------|---------------------------------|--|
| <user_id>   | <list of <user_id>> | <str in "dd-mm-YYYY" format> | <Helpful \| Exit \| Later> |
