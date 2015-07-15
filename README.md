# Open Pivotal

A sinatra based public facing board for Pivotal.

## Setup

Set two environment variables: `pivotal_api_key` and `pivotal_project` for the application. If it's deployed on heroku

```
heroku config:set pivotal_api_key=123...abc pivotal_project=1234..56
```

Visiting root URL will list all cards for the project that are tagged with 'public'.
