# encoding: utf-8
require 'spec_helper'

module InstanceTracker
  describe Trackable do

    class SpecHarness

      def initialize
        @context = "Foo"
      end

      include InstanceTracker::Trackable
      track :context
    end

    let(:subject) { SpecHarness.new }

    it "should respond to `#trackable_instance`" do
      expect(subject.respond_to? :trackable_instance).to be
      expect(subject.trackable_instance).to eq("Foo")
    end

    it "should already implement `#after_initialize` to return nil" do
      expect(subject.after_initialize).to be_nil
    end

    context "when `#after_initialize` is overriden" do

      it "should call the overriden implementation of `#after_initialize`" do
        SpecHarness.class_eval do
          def after_initialize
            true
          end
        end

        expect(subject.after_initialize).to be
      end

    end

  end
end
