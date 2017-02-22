class Article < ActiveRecord::Base
  belongs_to :user

  has_one :content, as: :entity
  validates :title, presence: true
end
