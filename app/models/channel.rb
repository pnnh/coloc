class Channel < ActiveRecord::Base
    belongs_to :user
    has_many :articles

    validates :title, presence: true, uniqueness: true
end