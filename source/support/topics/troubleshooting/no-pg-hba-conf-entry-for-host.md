This error usually means that your PostgreSQL client library is configured to connect to databases with SSL disabled. This won't work with an Aptible PostgreSQL database since we require SSL for all PostgreSQL database connections.

Many PostgreSQL client libraries allow enforcing SSL by appending `?ssl=true` to the default database connection URL provided by Aptible. For other libraries, it may be necessary to set this in the library configuration code.

If you have questions about enabling SSL for your app's PostgreSQL library, please [contact support](http://contact.aptible.com).
