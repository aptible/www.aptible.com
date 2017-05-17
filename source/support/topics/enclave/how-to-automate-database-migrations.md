Many app frameworks provide libraries for managing database migrations between different revisions of an app. For example, Rails' ActiveRecord library allows users to define migration files and then run `rake db:migrate` to execute them.

To automatically run migrations on each deploy, you can use the `.aptible.yml` file. This file should be placed at the top level of your app repo, and should be YAML-formatted, with a single key — `before_release` — which may take an array of commands to run before each release.

For example, to automate Rails migrations, you might have the following `.aptible.yml` file:

```yaml
before_release:
  - bundle exec rake db:migrate
```

If you want to deploy the same repo to different environments that require different rake tasks, we suggest referencing a Bash script:

```
#!/bin/sh
# This file lives at script/before_release.sh
# chmod 0755 script/before_release.sh

if [ "$RAILS_ENV" == "staging" ]; then
  bundle exec rake db:[TASK]
else
  bundle exec rake db:[OTHER_TASK]
fi
```

Your new .aptible.yml would read:

```
before_release:
  - script/before_release.sh
```
