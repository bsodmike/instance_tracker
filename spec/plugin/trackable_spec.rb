# encoding: utf-8
require 'spec_helper'

module InstanceTracker
  describe Trackable do

    class SpecHarness
      include InstanceTracker::Trackable
      track :context

      def initialize
        @context = "Foo"
      end
    end

    let(:subject) { SpecHarness.new }

    it "should respond to `#trackable_instance`" do
      expect(subject.respond_to? :trackable_instance).to be
      expect(subject.trackable_instance).to eq("Foo")
    end

  end
end
