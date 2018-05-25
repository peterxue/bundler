# frozen_string_literal: true

module Bundler
  module Plugin
    module Events
      def self.define(const, event)
        if const_defined?(const.to_sym) && const_get(const.to_sym) != event
          raise ArgumentError, "Attempting to reassign #{const} to a different value"
        end
        const_set(const.to_sym, event) unless const_defined?(const.to_sym)
        @events ||= {}
        @events[event] = const
      end
      private_class_method :define

      # Check if an event has been defined
      # @param event [String] An event to check
      # @return [Boolean] A boolean indicating if the event has been defined
      def self.defined_event?(event)
        @events ||= {}
        @events.key?(event)
      end

      # @!parse
      #   # A hook called before any gems install
      #   GEM_BEFORE_INSTALL_ALL = "before-install-all"
      define :GEM_BEFORE_INSTALL_ALL, "before-install-all"
    end
  end
end
