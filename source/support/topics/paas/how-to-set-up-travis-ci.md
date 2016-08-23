Deploying from Travis CI is easy on Aptible! We recommend the following approach:

1. Create a "Robots" role in your Aptible organization, and grant it "Read" and "Manage" permissions on your production account.
2. Invite a new deploy user to this Robots role. It needs to have a real email address, but can be something like deploy@yourdomain.com.
3. Generate an SSH key pair for the deploy user (you can do this via: `ssh-keygen -f deploy.pem`). Don't set a password for the key, since that won't work well on Travis.
4. Accept the invitation for deploy@yourdomain.com, activate the account, and upload the public key from Step 3 on your [Aptible User Settings page](https://dashboard.aptible.com/settings/ssh).
5. Encrypt the private key and store it in the repo, using [Travis' instructions](http://docs.travis-ci.com/user/encrypting-files/). We recommend the "Automated Encryption" method, using the Travis CI command line tool.
6. Add a custom deploy step, following [Travis' instructions](http://docs.travis-ci.com/user/deployment/custom/). It should look something like:

```
after_success:
  - chmod 600 .travis/deploy.pem
  - ssh-add .travis/deploy.pem
  - git remote add aptible git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git
  - git push aptible master
```
