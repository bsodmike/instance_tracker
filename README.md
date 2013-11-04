# InstanceTracker

A Simple Ruby DSL for Instance Tracking.

## Installation

Add this line to your application's Gemfile:

    gem 'instance_tracker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install instance_tracker

## API Summary

Start by including `InstanceTracker::Trackable` within classes in which
you want to track an instance variable.  This should occur after the
call to `initialize`.

```ruby
  class Foo
    def initialize(wrapper)
      @wrapper = wrapper
    end

    include InstanceTracker::Trackable
    track :wrapper
  end
```

This provides the class a `track` class method which allows you to define which
instance variable to track.


You are now able to access the `wrapper` by simply calling
`trackable_instance` from any instance of your class.

The included class can also override `after_initialize` (implemented as
a simple interface within `InstanceTracker::Trackable`) which will be
called as soon as the included class is instantiated.

```ruby
  class Foo
    def initialize(wrapper)
      @wrapper = wrapper
    end

    def after_initialize
      trackable_instance.meaning_of_life = "42"
    end

    include InstanceTracker::Trackable
    track :wrapper
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This project rocks and uses MIT-LICENSE.
