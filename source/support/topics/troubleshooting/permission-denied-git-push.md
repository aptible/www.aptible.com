You may have a misconfigured SSH key if you try to push to an Aptible Git endpoint and receive an error like this:

```
Pushing to git@beta.aptible.com:[environment]/[app].git 
Permission denied (publickey). 
fatal: Could not read from remote repository.

Please make sure you have the correct access rights 
and the repository exists. 
```

To confirm, try running:

```
ssh -T git@beta.aptible.com
```

The output of this command will indicate whether you're being correctly recognized by our Git server. You should see something like the following:

```
Hi [email]! Welcome to Aptible. Please use `git push` to connect.
```

If you do not see that message, either you have not registered a key with Aptible, or are not using the key you registered.

Note that during a Git push, SSH will use your default key unless you specify otherwise. If you are using a non-default key on Aptible, you can configure a different key automatically for a specific server  with your `~/.ssh/config` file. For Aptible, you could have something like the following in your `~/.ssh/config` file:

```
Host beta.aptible.com
 IdentityFile /path/to/private/key
```
