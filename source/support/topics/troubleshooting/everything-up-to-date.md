This message means that the local branch you're pushing to Aptible is already at exactly the same revision as is currently deployed on Aptible. Here are a couple tips that may help in this case:

* If you've already pushed your code to Aptible and simply want to restart the app, you can do so by running `aptible restart` using [the Aptible CLI](/support/topics/cli/how-to-install-cli). If you want to trigger a new build from the same code you've already pushed, you can run `aptible rebuild`.
* If you're pushing a branch other than `master`, you must still push to the remote branch named `master` in order to trigger a build. Assuming you've got a Git remote named "aptible," you can do this with a command like the following:

        git push aptible local-branch:master
