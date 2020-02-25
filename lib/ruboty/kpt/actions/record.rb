require 'date'

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
          result = add_to_brain
          message.reply(type + 'を記録しました >> ' + result.to_s)
        end

        attr_reader :type

        private

        def add_to_brain
          brain.data[type] ||= []
          brain.data[type].append(data)
          data
        end

        def brain
          message.robot.brain
        end

        def data
          {
            post: message[:retrospective],
            inserted_at: DateTime.now.to_s,
            from: message.from_name,
          }
        end
      end
    end
  end
end
