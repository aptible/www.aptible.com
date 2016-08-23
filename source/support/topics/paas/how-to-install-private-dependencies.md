Often, an app may have private dependencies (e.g., Ruby gems or Node packages) that must be downloaded and installed at runtime. We recommend hosting these private dependencies on GitHub and downloading them via GitHub "personal access tokens."

To create a personal access token, first log in to GitHub as a user with access to the repo(s) hosting the private dependencies your app requires. (Ideally, this should be a "robot user" with privileges restricted to read-only access, and only for the required repos.) Then, navigate to the [Personal Access Tokens](https://github.com/settings/tokens) page, and create a token with `repo` scope. Now, let's say that your newly-generated token is

    988881adc9fc3655077dc2d4d757d480b5ea0e11

To reference a Ruby gem dependency using this token, you'd add an entry like the following to your Gemfile. For the example, we've assumed that the gem is named "mygem", and hosted on GitHub as myorg/mygem:

    gem 'mygem', git: 'https://988881adc9fc3655077dc2d4d757d480b5ea0e11@github.com/myorg/mygem.git'

To reference a Node (NPM) package using this token, you'd an entry like the following to your package.json. For the example, we've assumed that the package is named "mypkg", and hosted on GitHub as myorg/mypkg:

    "mypkg": "git+https://988881adc9fc3655077dc2d4d757d480b5ea0e11:x-oauth-basic@github.com/myorg/mypkg.git"
