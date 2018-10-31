class Article < ActiveRecord::Base
    validates :title, presence: true
    validates :description, presence: true

    class << self
        def markdown
          Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        end
    end

end