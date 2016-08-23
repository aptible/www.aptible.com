Your app may fail to build with an error message including:

    error: Could not read COMMIT_HASH

    fatal: revision walk setup failed

    fatal: reference is not a tree: COMMIT_HASH


(Where `COMMIT_HASH` is a long hexadecimal number)

This error is caused by pushing from [a shallow clone][0]. Those are typically used by
CI and CD platforms in order to optimize build times.

To solve this problem, update your build script to run this command before pushing
to Aptible:

    git fetch --unshallow || true

Note that if your CI platform uses an old version of git, `--unshallow` may not be
available.  In that case, you can try fetching a number of commits large enough
to fetch all commits through to the repository root, thus unshallowing your repository:

    git fetch --depth=1000000

  [0]: https://www.perforce.com/blog/141218/git-beyond-basics-using-shallow-clones
