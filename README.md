# Guard-Tilt [![Build Status](https://secure.travis-ci.org/boof/guard-tilt.png?branch=master)](http://travis-ci.org/boof/guard-tilt) [![Maintenance Status](http://stillmaintained.com/boof/guard-tilt.png?branch=master)](http://stillmaintained.com/boof/guard-tilt) [![Dependency Status](https://gemnasium.com/boof/guard-tilt.png?branch=master)](http://gemnasium.com/boof/guard-tilt)

Guard to render templates.

## Configuration

    :context
    # Class instantiated with path for template being rendered
    :locals
    # Hash returning instances of Hash for path, may respond to reload

    # mangle the output path
    Guard::Tilt.output_path = Guard::Tilt::OutputPath
    # change root directory, useful for tests
    Guard::Tilt.root = Dir.getwd

For details see the Guardfile template.

## Installation

    $ git clone git://github.com/boof/guard-tilt.git
    $ cd guard-tilt
    $ rake install

## Setup

    $ guard init tilt

## Contributing to guard-tilt
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Florian Aßmann. See LICENSE.txt for further details.
