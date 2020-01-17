module Ruboty
  module Handlers
    class Kpt < Base
      on(
        %r{K (?<retrospective>.+)},
        name: 'keep',
        description: 'Post the good things that happened or that you want to keep.',
        all: true
      )

      on(
        %r{P (?<retrospective>.+)},
        name: 'problem',
        description: 'Post the bad things that happened or that you want to improve.',
        all: true
      )

      on(
        %r{T (?<retrospective>.+)},
        name: 'try',
        description: 'Post the actions that you want to challenge.',
        all: true
      )

      def keep(message)
        message.reply(unexpected_empty_message) unless message[:retrospective]

        Ruboty::Kpt::Actions::Record.new(message, 'keep').call
      end

      def problem(message)
        message.reply(unexpected_empty_message) unless message[:retrospective]

        Ruboty::Kpt::Actions::Record.new(message, 'problem').call
      end

      def try(message)
        message.reply(unexpected_empty_message) unless message[:retrospective]

        Ruboty::Kpt::Actions::Record.new(message, 'try').call
      end

      private

      def unexpected_empty_message
        'Unexpected empty message given.'
      end
    end
  end
end
