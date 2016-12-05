To deploy from Codeship on Aptible, we recommend the following approach:

1. Create a “Robots” role in your Aptible organization and grant it “Read” and “Manage” permissions on your production account.

2. Invite a new deploy user to this Robots role. It needs to have a real email address, but can be something like deploy@yourdomain.com.

3. Log out of your Aptible account.

4. Accept the invitation for deploy@yourdomain.com and activate the new account by clicking on the link in your invitation email.

5. Add an SSH key to your user account by navigating to the "SSH Keys" page for the new deployment account. Name the key something like "codeship", copy the public key from your Codeship projects General settings page, and paste it into the "Public SSH Key" area.

6. Finally, add a Custom Script deployment with the following command, replacing `[ENVIRONMENT_HANDLE]` and `[APP_HANDLE]` with your actual environment and app handles:

```sh
git push git@beta.aptible.com:[ENVIRONMENT_HANDLE]/[APP_HANDLE].git $CI_COMMIT_ID:master
```

Note: You can confirm the correct git remote URL at the top of the app details page in the Aptible Dashboard.

If you have any  issues with the setup, please [contact support](http://contact.aptible.com).
