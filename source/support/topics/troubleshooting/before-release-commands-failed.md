If any of the `before_release` commands in your `.aptible.yml` file fails (i.e., exits with a non-zero status code), the entire deploy will fail.

If this happens, the build log will contain the output of the `before_release` command that failed. This should aid in debugging the root cause of the problem. If you have questions please [contact support](http://contact.aptible.com).
