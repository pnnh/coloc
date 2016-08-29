class Channel < ActiveRecord::Base
  belongs_to :channel
  validates :channel_id, presence: true

  has_many :channels
end
