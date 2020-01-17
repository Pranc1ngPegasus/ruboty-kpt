module Ruboty
  module Kpt
    module Actions
      class Record
        def initialize(message, type = nil)
          return unless message
          return unless type

          @message = message
          @type = type
        end

        def call
          message.reply(type + 'を記録しました >> ' + message[:retrospective])
        end

        attr_reader :message, :type
      end
    end
  end
end
