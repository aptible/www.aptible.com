# ![](http://aptible-media-assets-manual.s3.amazonaws.com/web-horizontal-350.png)
## www.aptible.com
This is a static site generator that pulls in content pages from the [aptible-pages](https://github.com/aptible/aptible-pages), [aptible-blog](https://github.com/aptible/aptible-blog) and [aptible-legal](https://github.com/aptible/aptible-legal) repos.

#### Setting up

This will install bower, npm, gem dependencies and content dependencies.

````
npm install
bundle install
grunt setup
````

#### Local Development

`grunt setup` clones the aptible-pages, aptible-legal, and aptible-blog repos into the `content` folder. You can add your own fork as a remote and submit PRs for those repos directly. Run `grunt update` to pull the latest revisions of all dependent content repos.

Run `grunt server` to see your changes on localhost.

The site is built with [Assemble](http://assemble.io/). Many of the files make use of Assemble's [handlebars-helpers](http://assemble.io/helpers/) library.


#### Deploying
This will release the site to an S3 bucket where it will be immediately accessible at [www.aptible.com](https://www.aptible.com). The `release` commands depend on the [AWS command line tool](http://aws.amazon.com/cli/), which should be set up according to [Aptible's best practices](https://github.com/aptible/aptible-tech-guide/blob/master/doc/SystemsAdministration.md#command-line-access).

````
npm install
grunt release:production
````

To release to our staging site ([www.aptible-staging.com](https://www.aptible-staging.com)):

````
npm install
grunt release:staging
````

Copyright &copy; 2014 Aptible

[<img src="https://s.gravatar.com/avatar/9b58236204e844e3181e43e05ddb0809?s=60" style="border-radius: 50%;" alt="@sandersonet" />](https://github.com/sandersonet)
