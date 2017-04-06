class Article < ActiveRecord::Base
    belongs_to :user
    belongs_to :channel

    validates :title, :presence => true
end
