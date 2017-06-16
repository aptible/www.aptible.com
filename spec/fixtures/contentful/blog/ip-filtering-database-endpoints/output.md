---
title: Introducing Database Endpoints
excerpt: Database endpoints support IP filtering, so you can ensure only trusted third
  parties have access to your database.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-05-16
section: Blog
posts: true
---

We’re proud to announce that you can now create and manage external database endpoints via the Enclave dashboard. External endpoints are useful to grant third parties access to data stored in Enclave databases for purposes such as analytics and ETL (without an endpoint, your database is firewalled off and inaccessible from the public internet).
To set up a new endpoint for one of your databases, simply navigate to the Endpoints tab for this database and follow the instructions. Like their app counterparts, database endpoints support IP filtering, so you can ensure only trusted third parties have access to your database:

![IP Filtering with database endpoints](//images.contentful.com/8djp5jlzqrnc/6uQAlhJ4LSGesgyggwEO26/d62e3fe433d4951b19b8fb2e9627149c/image1.png)


Note that we’ve historically supported database endpoints via support requests before introducing this feature. If you had been using a database endpoint before we introduced this feature, it was automatically migrated and you’ll be able to manage it via the Dashboard going forward!
