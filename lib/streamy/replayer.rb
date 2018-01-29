module Streamy
  class Replayer
    def initialize(from: nil, to: Time.current, topics:)
      @from = from
      @to = to
      @topics = topics
    end

    def run
      # TODO: This is tied to redshift currently as we are forced to use `buffered`
      entries.buffered do |row|
        replay(row)
      end
    end

    private

      attr_reader :from, :to, :topics

      def entries
        Streamy.
          event_store.
          entries.
          select(:key, :topic, :type, :body, :event_time).
          where(topic: topics).
          where("event_time >= ?", from).
          where("event_time <= ?", to).
          order(event_time: :asc)
      end

      def replay(row)
        Streamy.logger.info "importing #{row}"
        message = Message.new_from_redshift(*row)
        Streamy.message_processor.process(message)
      end
  end
end