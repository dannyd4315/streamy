require "streamy/version"
require "streamy/event"
require "streamy/exporter"
require "streamy/profiler"
require "streamy/simple_logger"
require "streamy/uploader"


# Message Buses
require "streamy/message_buses/test_message_bus"
require "streamy/message_buses/file_message_bus"
require "streamy/message_buses/fluent_message_bus"

# Event stores
require "streamy/event_stores/copy_buffered_redshift_event_store"

# Junk
require "redshift_connector"
require "streamy/event_stores/redshift/connection"


module Streamy
  class << self
    attr_accessor :message_bus, :event_store
    attr_reader :logger
    @logger = SimpleLogger.new
  end
end
