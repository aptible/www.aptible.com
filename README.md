# ![](https://raw.github.com/aptible/straptible/master/lib/straptible/rails/templates/public.api/icon-60px.png) www.aptible.com generator

Assemble-www is a static site generator that pulls in content pages from [aptible/www.aptible.com](https://github.com/aptible/www.aptible.com), [aptible/blog.aptible.com](https://github.com/aptible/blog.aptible.com) and [aptible/legal](https://github.com/aptible/legal).

#### Setting up

This will install bower, npm, and content dependencies.

````
npm install
grunt setup
````


#### Creating a release
This will create a production release of www.aptible.com in the `dist` folder. 

````
npm install
grunt release
````
