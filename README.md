Learn by Testing
================

A repository for learning through testing

You can easily chat with me via  [![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.png)](https://gitter.im/aavalam/learnrubybytesting)

Setup
-----

If you want to use Ruby 2.0.0 you will need to ensure that bundler 1.3.0 at a
minimum is installed.

I did this by cloning Bundler and doing a checkout of the appropriate tagged
version, and then doing:

        gem build bundle.gemspec

and then doing

        gem install ./bundler-<version>.gem

with the built file.

I use RVM, so I changed to my `@global` gemset so that I have the version
available on all gemsets for 2.0.0-p0 version of Ruby

Custom Reporters
----------------

There is a file called `test/spec_config_sample.rb` that you may want to read.  It will direct you to copy it to spec_config.rb and uncomment the reporting style that you would like to use for the tests.

Uncomment one, and run rake to see how it displays, then recomment it and uncomment the next one.  The first three are likely the ones you want.  The next four are specialized for IDE's except for Guard.  That one is specific to Guard which is the continuous testing tool that is set up for this repository.

For running `rake test` from the command line, you are able to set the report type by doing this:

```
#!shell
REPORT='Default'
export REPORT
```

Now, when you run `rake` you will get a report as appropriate from the following choices:

* "Default",
* "Spec",
* "Progress",
* "Guard",
* "RubyMine",
* "RubyMate",
* "JUnit",


[![Build Status](https://semaphoreci.com/api/v1/projects/8f67108e-bcb5-43da-92f7-19a533ec3eac/451704/badge.svg)](https://semaphoreci.com/keeperotphones/learnrubybytesting)
