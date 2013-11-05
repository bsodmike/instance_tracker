# encoding: utf-8

module InstanceTracker

  module Trackable

    # The instance of {CleanRoom} is used to store our instance.

    class CleanRoom
      attr_reader :instance

      def initialize(instance)
        @instance = instance
      end

    end

    class << self

      def included _klass
        _klass.class_eval do
          include InstanceMethods
          extend ClassMethods
        end
      end

    end

    module InstanceMethods

      # @api private
      #
      # The instance of {CleanRoom} is memoised and returned
      # accordingly.
      #
      # @return [CleanRoom]
      # @raise [NotImplementedError] if the instance variable tracked has not been defined within the included _klass.

      def trackable
        @trackable ||= begin
          entity = instance_variable_get(:"@#{singleton_class.trackable_instance}")
          raise NotImplementedError unless entity
          Class.new(CleanRoom).new(entity)
        end
      end

      # Returns the instance tracked by {CleanRoom}

      def trackable_instance
        trackable.instance
      end

    end

    module ClassMethods

      # Sets the instance variable to be tracked.
      #
      # @param name [String] the instance variable to track

      def track(name)
        singleton_class.class_eval do
          define_method :trackable_instance do
            name
          end
        end
      end
    end

  end

end
