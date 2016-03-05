<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/noamross/juicer.svg?branch=master)](https://travis-ci.org/noamross/juicer)

**juicer** is a small wrapper around the **[juice](https://github.com/Automattic/juice)** javascript library for in-lining styles in HTML. It is intended as a building block for applications such as generating stylized HTML reports from R Markdown that can be sent via e-mail or uploaded to Google Docs with styles intact.

Installation
============

To install from github:

    devtools::install_github('noamross/juicer')

Note that since this package uses V8, is has a system dependency of `libv8`. To quote from **V8**'s README:

> This package depends on libv8 around 3.14 or 3.16, which is the version included with most package managers:
>
> -   Debian: [libv8-3.14-dev](https://packages.debian.org/sid/libv8-3.14-dev)
> -   Fedora/EPEL: [v8-devel](https://apps.fedoraproject.org/packages/v8-devel)
> -   Arch: [v8-3.14](https://aur.archlinux.org/packages/v8-3.14/)
> -   OSX: [v8-315](https://github.com/Homebrew/homebrew-versions/blob/master/v8-315.rb) (`brew tap homebrew/versions; brew install v8-315`)
>
> Unfortunately the developers of libv8 do not care about backward compatibility and therefore recent branches of V8 (such as 3.22 or 4.xx) will not work. For this reason most distributions are unlikely to upgrade any time soon because it would break everything downstream (node, mongodb, etc).
>
> The only distribution I am aware of that does not include a compatible version of v8 is OpenSUSE. So on this system you'll have to pull an older version from [rpmfind](http://www.rpmfind.net/linux/rpm2html/search.php?query=v8&system=opensuse) or [ruby gem](https://rubygems.org/gems/libv8/versions/3.16.14.7) or something.

Usage
=====

The package has one function, `juice()`, which inlines the styles of HTML passed to it as a string, file, or URL:

``` r
library(juicer)
some_html = "<style>a {font-size:30;}</style><a href='http://www.ropensci.org'>ROpenSci</a>"
juice(some_html)
#> [1] "<a href=\"http://www.ropensci.org\" style=\"font-size: 30;\">ROpenSci</a>"
```

See `?juice` and the [javascript documentation](https://github.com/Automattic/juice) for more options.

Code of Conduct
===============

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
