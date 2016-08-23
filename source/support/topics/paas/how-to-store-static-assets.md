Broadly speaking, there are two ways to serve static assets from an Aptible web app:

* Store the assets in the Aptible container, and serve them from Aptible.
* Store the assets in a third-party object store (like AWS Simple Storage Service, a.k.a S3).

The latter approach has a performance advantage: serving static assets from S3 (or AWS CloudFront) is much faster than serving them from Elastic Compute Cloud (EC2) where your Aptible app runs.

To precompile your assets and upload them to S3 before each new release of your app, you may wish to use the `.aptible.yml` file. This file should be placed at the top level of your app repo, and should be YAML-formatted, with a single key — `before_release` — which may take an array of commands to run before each release.

For example, if you're running a Rails app and using [the Asset Sync gem](https://github.com/rumblelabs/asset_sync) to automatically sync your assets to S3 at the end of the Rails assets pipeline, you might use the following `.aptible.yml` file:

```yaml
before_release:
  bundle exec rake assets:precompile
```
