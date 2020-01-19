module Ruboty
  module Kpt
    module Actions
      class Summary < Ruboty::Actions::Base
        def call
          message.reply(response)
        end

        private

        [:keep, :problem, :try].map do |type|
          define_method("#{type}_data") do
            data["#{type}"] || nil
          end

          define_method("#{type}_text") do
            return "" unless send("#{type}_data")

            build_text(send("#{type}_data"))
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
      end
    end
  end
end
