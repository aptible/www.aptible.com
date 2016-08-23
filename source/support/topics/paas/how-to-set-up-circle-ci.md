To deploy from Circle CI on Aptible, we recommend the following approach:

1. Create a "Robots" role in your Aptible organization, and grant it "Read" and "Manage" permissions on your production account.
2. Invite a new deploy user to this Robots role. It needs to have a real email address, but can be something like deploy@yourdomain.com.
3. Generate an SSH key pair for the deploy user (you can do this via: `ssh-keygen -f deploy.pem`). Don't set a password for the key, since that won't work well on Circle CI.
4. Accept the invitation for deploy@yourdomain.com, activate the account, and upload the public key from Step 3 on your [Aptible User Settings page](https://dashboard.aptible.com/settings/ssh).
5. Upload the private key to your project by visiting the **Project Settings > SSH keys** page on Circle CI.
6. Add a custom deploy step, following [Circle's instructions](https://circleci.com/docs/configuration#deployment). It should look something like:

```
deployment:
    production:
      branch: production
      commands:
        - git push git@beta.aptible.com:$ENVIRONMENT_HANDLE/$APP_HANDLE.git $CIRCLE_SHA1:master
```
