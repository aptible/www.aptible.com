# ![](http://aptible-media-assets-manual.s3.amazonaws.com/web-horizontal-350.png)

[![Build Status](https://travis-ci.org/aptible/www.aptible.com.png?branch=master)](https://travis-ci.org/aptible/www.aptible.com)

## www.aptible.com
This is a static site generator that pulls in content pages from the [aptible-pages](https://github.com/aptible/aptible-pages), [aptible-blog](https://github.com/aptible/aptible-blog) and [aptible-legal](https://github.com/aptible/aptible-legal) repos.

#### Setting up

````
grunt setup
````

#### Local Development

`grunt setup` clones the aptible-pages, aptible-legal, and aptible-blog repos into the `content` folder. You can add your own fork as a remote and submit PRs for those repos directly. Run `grunt update` to pull the latest revisions of all dependent content repos.

`grunt setup`, `grunt server`, and the deploy tasks all ensure dependencies are
installed locally by running `bundle install`, `npm install`, and
`bower install`.

Run `grunt server` to see your changes on localhost.

The site is built with [Assemble](http://assemble.io/). Many of the files make use of Assemble's [handlebars-helpers](http://assemble.io/helpers/) library.


#### Deploying
This will release the site to an S3 bucket where it will be immediately accessible at [www.aptible.com](https://www.aptible.com). The `release` commands depend on the [AWS command line tool](http://aws.amazon.com/cli/), which should be set up according to [Aptible's best practices](https://github.com/aptible/aptible-tech-guide/blob/master/doc/SystemsAdministration.md#command-line-access).

````
grunt release:production
````

To release to our staging site ([www.aptible-staging.com](https://www.aptible-staging.com)):

````
grunt release:staging
````

Note: these tasks also run `bundle install`, `npm install`, and `bower install`
to ensure all dependencies are included in deploys.

#### Continuous Deployment

Note that deployment to staging happens automatically on every successful merge to master. This requires the encrypted AWS credentials for an authorized user to be stored in the .travis.yml configuration file.

To update these credentials at any time, run:

    travis encrypt -r aptible/www.aptible.com --add env AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=...

#### Creating a Blog Post

Blog posts consist of combination of [YAML front matter](http://jekyllrb.com/docs/frontmatter/) and [markdown](https://daringfireball.net/projects/markdown/basics).  In order to ensure your post functions properly, you'll need to provide the appropriate YAML front matter at the top of your .md file.

````
---
title: Post Title
excerpt: "When I say the terms \"IT Operations\" and \"Software Development\" together, what decade do you think of? Probably the 90s or at least early 2000s."
author_name: Chas Ballew
author_email: chas@aptible.com
author_id: chas
posted: 2014-06-01
section: Blog
---
````

#### Using media in your blog posts

Use the `{{blog_asset_path}}` helper to build a relative URL to the media in the assets folder. The following will generate a path to `assets/aptible.png`. Note that you will still have to use Markdown or HTML syntax to generate the element.

For example:
```
![]( {{ blog_asset_path 'aptible.png' }} )
```
or
```
<img src="{{ blog_asset_path 'aptible.png' }}" />
```

You may also store assets in sub folders

````
![]( {{ blog_asset_path 'logos/aptible.png' }} )
````

Copyright &copy; 2016 Aptible

[<img src="https://secure.gravatar.com/avatar/566f0093e212d9b808c0cece8a32480e?s=60" style="border-radius: 50%;" alt="@gib" />](https://github.com/gib)
