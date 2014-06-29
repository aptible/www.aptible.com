# ![](http://aptible-media-assets-manual.s3.amazonaws.com/web-horizontal-350.png)  
## www.aptible.com  
This is a static site generator that pulls in content pages from the [aptible-pages](https://github.com/aptible/aptible-pages), [aptible-blog](https://github.com/aptible/aptible-blog) and [aptible-legal](https://github.com/aptible/aptible-legal) repos.

#### Setting up

This will install bower, npm, and content dependencies.

````
npm install
grunt setup
````

#### Local Development

`grunt setup` clones the aptible-pages, aptible-legal, and aptible-blog repos into the `content` folder. You can add your own fork as a remote and submit PRs for those repos directly. Run `grunt setup` again to overwrite `content`.

Run `grunt server` to see your changes on localhost.

#### Creating a release
This will create a production release of www.aptible.com in the `dist` folder. 

````
npm install
grunt release
````

Copyright &copy; 2014 Aptible
