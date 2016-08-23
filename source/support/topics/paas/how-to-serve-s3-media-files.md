This article covers _storing_ and _serving_ media files from S3 in a HIPAA-compliant manner.

For storing PHI on Amazon S3, you'll need to get a separate BAA with Amazon Web Services. This BAA will require that you encrypt all data stored on S3. You have three options for implementing encryption, ranked from best to worst (based on the combination of ease of implementation and security):

1. Server-side encryption with customer-provided keys (SSE-C, documented [here](http://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html)): You specify the key when uploading and downloading objects to/from S3. You need to remember the encryption key, but you don't have to choose or maintain an encryption library.
2. Client-side encryption (CSE, documented [here](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingClientSideEncryption.html)): This is the most challenging approach, but also gives you full control. You pick an encryption library, and implement the encryption/decryption logic.
3. Server-side encryption with Amazon-provided keys (SSE, documented [here](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html)): This is the easiest approach, but the least secure. You need only specify that encryption should occur on PUT, and you never need to keep track of encryption keys. The downside is that if any of your privileged AWS accounts (or access keys) are compromised, all of your S3 data may be compromised and unprotected by a secondary key.


There are two ways to serve S3 media files:

1. Generate a pre-signed URL so that the client can access them directly from S3.
2. Route all media requests through your app, fetch the S3 file within your app code, then re-serve it to the client.

The first of these options is superior from a performance perspective.

However, if these are PHI-sensitive media files we recommend the second approach due to the control it gives you with regard to audit logging as you will be able to more easily connect specific S3 file access to individual users in your system.

