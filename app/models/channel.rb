class Channel < ActiveRecord::Base
    belongs_to :user
    has_many :articles

    validates :title, presence: true, uniqueness: true

    def contents_path
        '/channels/' + id.to_s + '/' + ctype.pluralize.downcase
    end
end