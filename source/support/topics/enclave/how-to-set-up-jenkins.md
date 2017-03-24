To deploy from Jenkins on Aptible, we recommend the following approach. We assume that you have already installed and set up the Jenkins [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin) on your Jenkins server.

1. Create a "Robots" role in your Aptible organization and grant it "Read" and "Manage" permissions on your production account.
2. Invite a new deploy user to this Robots role. It needs to have a real email address, but can be something like deploy@yourdomain.com.
3. Log out of your Aptible account.
4. Generate an SSH key pair for the deploy user (you can do this via: `ssh-keygen -f deploy.pem`). Don't set a password for the key, since that won't work well on Travis.
5. Accept the invitation for deploy@yourdomain.com, activate the account, and upload the **public key** from Step 4 on your [Aptible User Settings page](https://dashboard.aptible.com/settings/ssh).
6. In Jenkins, add your source repository URL, as described in [this blog post](http://thediscoblog.com/blog/2014/01/24/continuous-delivery-for-heroku-with-jenkins/). Then, add a second repository, with the git remote URL `git@beta.aptible.com:<environment>/<app>.git`. Upload the **private** key from Step 4 using the "Add Key" icon, and set the remote name to "aptible" under "Advanced..."

    Note: You can confirm the correct Git remote URL at the top of your app's page in the Aptible Dashboard.

7. Add a post-build "Git Publisher" trigger, to deploy to the "master" branch of the new "aptible" remote.
