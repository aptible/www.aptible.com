# ![](https://raw.github.com/aptible/straptible/master/lib/straptible/rails/templates/public.api/icon-60px.png) Aptible::Tumblr

Our Tumblr theme and posts. See it in action at http://blog.aptible.com.

## Installation
1. Log into Tumblr
2. Click into the Aptible blog at the top of the Dashboard or under the list icon at the top.
3. Click “Customize appearance” on the right column.
4. Click “Edit HTML” below the theme thumbnail on the left.
5. Paste the contents of `index.html` into the field and save.
6. Back at the "Customize" page, at the bottom, click "Advanced options."
7. Add the contents of the `custom.css` file.

## Code Blocks and Syntax Highlighting
In a post, to include a code block, turn on HTML editing and use:  

```html
<pre class="prettyprint"><code>
[preformatted goes here]
</code></pre>
```
You can add `.prettyprint` to either the `<pre>` or `<code>` elements. Add `.linenums` for line numbers, but be warned it's not copy/paste friendly. 

See the [Prettify readme](http://google-code-prettify.googlecode.com/svn/trunk/README.html) for more information, such as:

> How do I specify the language of my code?
> You don't need to specify the language since prettyprint() will guess. You can specify a language by specifying the language extension along with the prettyprint class like so:
```
<pre class="prettyprint lang-html">
  The lang-* class specifies the language file extensions.
  File extensions supported by default include
    "bsh", "c", "cc", "cpp", "cs", "csh", "cyc", "cv", "htm", "html",
    "java", "js", "m", "mxml", "perl", "pl", "pm", "py", "rb", "sh",
    "xhtml", "xml", "xsl".
</pre>
```
>You may also use the HTML 5 convention of embedding a code element inside the PRE and using language-java style classes. E.g.
```
<pre class="prettyprint"><code class="language-java">...</code></pre>
```

