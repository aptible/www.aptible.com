Aptible currently supports the following databases:

* PostgreSQL
* Redis
* MongoDB
* MySQL
* CouchDB
* Elasticsearch
* RabbitMQ

Databases can be provisioned either from the Dashboard or Aptible CLI.  To provision a database the Dashboard, navigate to your desired environment, select "Databases", then "Create Database.""

To provision a database using Aptible CLI, use the `aptible db:create` command:

```
aptible db:create --type <DATABASE_TYPE> --size <SIZE_IN_GB> <DATABASE_HANDLE>
```

If you would like to run a type of database not listed, please [contact support](http://contact.aptible.com).
