# ![](http://aptible-media-assets-manual.s3.amazonaws.com/web-horizontal-350.png)  
## aptible-blog   
A collection .md and .hbs pages used to drive www.aptible.com.

See [aptible/www.aptible.com](https://github.com/aptible/www.aptible.com) for instructions on how to assemble these pages into a static site.

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

#### Using media in your posts

Use the `{{blog_asset_path}}` helper to build a relative URL to the media in the assets folder. The following will generate a path to `assets/aptible.png`.

````
{{ blog_asset_path 'aptible.png' }}
````

You may also store assets in sub folders

````
{{ blog_asset_path 'logos/aptible.png' }}
````

Copyright &copy; 2014 Aptible
