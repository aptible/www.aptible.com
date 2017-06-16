---
title: Database Encryption now defaults to AES-256
excerpt: Aptible databases (and their backups) now default to AES-256 disk encryption.
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-02-14
section: Blog
posts: true
---

Until recently, Aptible has used AES-192 for disk encryption, but as of last week, Aptible databases (and their backups) now default to AES-256 instead.

While there is no security concern whatsoever regarding AES-192 as an encryption standard, it has become increasingly common for Aptible customers to have their own partners request 256-bit encryption everywhere from a compliance perspective, which is why we’re making this change.

If you’re curious to know which encryption algorithm is used for a given database, you can find that information on the Dashboard page for the database in question (along with the disk size and database credentials).