module Ruboty
  module Kpt
    module Actions
      class Record < Ruboty::Actions::Base
        def initialize(message, type = nil)
          super(message)

          return unless type
          @type = type
        end

        def call
          message.reply(type + 'を記録しました >> ' + message[:retrospective])
        end

        attr_reader :type
      end
    end
  end
end
