# Glide [![Build Status](https://secure.travis-ci.org/vpacher/glide.png?branch=master)](http://travis-ci.org/vpacher/glide) [![Dependency Status](https://gemnasium.com/vpacher/glide.png)](https://gemnasium.com/vpacher/glide)
=====

The glide gem is a simple wrapper around the [Glide UK][glide] api to retrieve quotes for the individual services you require in one go and sum up the totals.

[glide]: http://www.glide.uk.com/

# Installation

## with bundler:

    gem 'glide'

## without bundler:

    sudo gem install 'glide'

# Usage

## Set your API access key:

    Glide::api_key = "YourKeyGoesHere"

## Do a query:

	quotes = Glide.get_quote(["elec", "water", "gas"], {"water" => "SW1 0AA"}, 6, 1)

where the paramaters are as follows:

	Glide.get_quote(service, extra, period, tenants)

service: Can be one or any combination of elec, water, gas, telephone, broadband and tv_license    
extra: required additional information for certain services:
* for elec 'green', 'nogas' or 'green,nogas' is optional
* for water postcode is required
* for broadband llu24s for standard broadband or llu24p for premium broadband is required

# Submitting an Issue
We use the [GitHub issue tracker][issues] to track bugs and features. Before
submitting a bug report or feature request, check to make sure it hasn't
already been submitted. When submitting a bug report, please include a [Gist][]
that includes a stack trace and any details that may be necessary to reproduce
the bug, including your gem version, Ruby version, and operating system.
Ideally, a bug report should include a pull request with failing specs.

[issues]: https://github.com/vpacher/glide/issues
[gist]: https://gist.github.com/

# Submitting a Pull Request
1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Add specs for your unimplemented feature or bug fix.
4. Run `bundle exec rake spec`. If your specs pass, return to step 3.
5. Implement your feature or bug fix.
6. Run `bundle exec rake spec`. If your specs fail, return to step 5.
7. Run `open coverage/index.html`. If your changes are not completely covered
   by your tests, return to step 3.
8. Add documentation for your feature or bug fix.
9. Run `bundle exec rake yard`. If your changes are not 100% documented, go
   back to step 8.
10. Add, commit, and push your changes.
11. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## Copyright
Copyright (c) 2012 Volker Pacher
See [LICENSE][] for details.

[license]: https://github.com/vpacher/glide/blob/master/LICENSE.md
