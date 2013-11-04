# encoding: utf-8

module InstanceTracker

  module Trackable
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
      def trackable
        @trackable ||= begin
          entity = instance_variable_get(:"@#{singleton_class.trackable_instance}")
          raise NotImplementedError unless entity
          Class.new(CleanRoom).new(entity)
        end
      end

      def trackable_instance
        trackable.instance
      end

    end

    module ClassMethods
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
