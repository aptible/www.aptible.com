## Aptible Toolbelt
The preferred method of installing the Aptible CLI is via [Aptible Toolbelt](/support/toolbelt/). The Toolbelt pins dependencies. In most cases, compared to using the gem, the Toolbelt will be faster (because dependencies will not have to be resolved upon each invocation), and more reliable (because the Toolbelt's Ruby version stays separate from your other versions).

If you are migrating from the gem to the Toolbelt, please read below.

## Ruby Gem
The Aptible CLI is also packaged as a Ruby gem that you can use directly. To install it, you'll first need to make sure you have Ruby installed locally (version 1.9.2 or greater). If you don't already have a Ruby install, we strongly suggest just using the Toolbelt. If you still wish to proceed, refer to [the Ruby installation guide](https://www.ruby-lang.org/en/documentation/installation/).

Then, just install the gem:

    gem install aptible-cli

## Migrating from the Gem to the Toolbelt
If you have previously installed the Ruby gem `aptible-cli`, you may need to either uninstall it (`gem uninstall aptible-cli --all`) or update your PATH to ensure that `/usr/local/bin/aptible` is the binary that is found.

In most cases, uninstalling the gem will be easier. If you would prefer not  to, you can add the the following to your `.bashrc` (or _.whateverrc_ if you are using a different shell):

```
aptible () {
    "/usr/local/bin/aptible" "$@"
}
```

## Using the CLI
Either installation method will introduce a new command line application, `aptible`. To start using the tool, log in to your Aptible account with your email and password by running:

    aptible login

Then, to see what's possible with the CLI, just run:

    aptible help

If you have questions about the CLI, please [contact support](http://contact.aptible.com).
