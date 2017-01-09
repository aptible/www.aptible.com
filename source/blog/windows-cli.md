---
title: "Aptible CLI for Windows"
excerpt: "Run the Aptible CLI on your Windows box"
author_name: Thomas Orozco
author_email: thomas@aptible.com
author_id: thomas
posted: 2017-01-09
section: Blog
posts: true
---
We’re proud to announce that the Aptible CLI is now supported on Windows!

## More than a CLI: a Toolbelt!

We distribute the Aptible CLI as a package called the "Aptible Toolbelt." The Toolbelt is available for several platforms, including macOS, Ubuntu, Debian, and CentOS. On Windows, it is available as an MSI installer. 

On all platforms, the toolbelt includes:
  
  * The Aptible CLI itself, in the form of [the aptible-cli Ruby gem][0]; and

  * System dependencies the CLI needs to function properly. This includes Ruby (which the CLI is written in) and dependencies like OpenSSH (which the CLI uses for functionality like database tunnels).

The toolbelt integrates with your system to ensure that the `aptible` command lands on your `PATH`, so that when you type `aptible` in your command prompt, _things just work_. On Windows, this is done by modifying your `PATH`, and on OSX and Linux this is done by placing a symlink in `/usr/local/bin`.

## Supported Platforms

The Windows package targets Windows 8.1 and up on the PC side, and Windows Server 2012r2 and up on the server side. In other words, it targets [Windows NT 6.3][1] and up, which is why you’ll see that number in the installer name.

## Download and Installation

To get the Aptible CLI on Windows, [download it directly from the Aptible website][2], then run the installer.

You might receive a SmartScreen prompt indicating that the publisher (that’s us!) isn’t known. Because this is the first time we've shipped software for Windows, [we don’t have a reputation with Microsoft yet][3]. The installer is properly signed, so to proceed, click through "More Info" and **verify that the reported publisher is Aptible, Inc.**

<p class="text-center">
  <img class="img-responsive" src="/images/blog/windows-cli/windows-installer.png">
</p>

Enjoy! Since this is still early days for the Windows version of the CLI, make sure to let us know if you hit any snags!

  [0]: https://github.com/aptible/aptible-cli
  [1]: https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
  [2]: https://www.aptible.com/support/toolbelt/#download-windows
  [3]: https://blogs.msdn.microsoft.com/ie/2011/03/22/smartscreen-application-reputation-building-reputation/
