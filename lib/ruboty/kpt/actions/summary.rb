require 'date'

module Ruboty
  module Kpt
    module Actions
      class Summary < Ruboty::Actions::Base
        def call
          message.reply(response, reply_options)
        end

        private

        [:keep, :problem, :try].map do |type|
          define_method("#{type}_data") do
            data["#{type}"] || nil
          end

          define_method("#{type}_text") do
            return "" unless send("#{type}_data")

            target = send("#{type}_data")

            filtered = filter_by_date(target)
            build_text(filtered)
          end
        end

        def response
          return "" unless (keep_text.present? || problem_text.present? || try_text.present?)

          [
            "# Keep",
            keep_text,
            "",
            "# Problem",
            problem_text,
            "",
            "# Try",
            try_text,
          ].join("\n")
        end

        def filter_by_date(target)
          date_range = Range.new(
            DateTime.parse(message[:start_date]).new_offset,
            DateTime.parse(message[:end_date]).new_offset + 1,
          )

          target.find_all do |elm|
            date_range.cover?(
              DateTime.parse(elm[:inserted_at]).new_offset
            )
          end
        end

        def build_text(posts)
          return "" unless posts.length > 0

          posts.map do |post|
            [
              '- ',
              post[:post],
              ' by ',
              post[:from],
            ].join('')
          end
        end

        def data
          brain.data
        end

        def brain
          message.robot.brain
        end

        def reply_options
          {
            thread_ts: message[:thread_ts]
          }
        end
      end
    end
  end
end
