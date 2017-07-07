If you'd like to automate pre-deployment steps such as database migrations or
internal notifications, you can do so on Aptible by adding a file named
`.aptible.yml` file in the root of your app's git repository.

This file should be a valid YAML file containing a key named `before_release`.

## `before_release`

`before_release` should be set to a list, e.g.:

```
before_release:
  - command1
  - command2
```

The commands listed under `before_release` will run when you deploy your app,
either via a `git push` or using `aptible deploy`.

These commands will *not*  run when you run `aptible config:set`, `aptible
restart`, etc.

For usage examples, see [How do I automate database migrations for my
app?][database-migrations].

  [database-migrations]: /support/topics/enclave/how-to-automate-database-migrations/
