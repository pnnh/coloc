class Tag < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  has_many :parents, class_name:"Content", as: :child
  has_many :belong_channels, through: :parents, source: :parent, source_type: "Channel"
end
