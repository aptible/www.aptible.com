# ![](https://raw.github.com/aptible/straptible/master/lib/straptible/rails/templates/public.api/icon-60px.png) Aptible::Blog

## A collection blog posts used to drive aptible.com/bog

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