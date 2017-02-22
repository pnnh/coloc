class Channel < ActiveRecord::Base
    belongs_to :user
    has_many :contents
    has_one :interaction
end