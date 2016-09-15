class Channel < ActiveRecord::Base
  has_many :children, class_name:"Content", as: :parent
  has_many :parents, class_name:"Content", as: :child

  has_many :tags, through: :children, source: :child, source_type: "Tag"
  has_many :channels, through: :children, source: :child, source_type: "Channel"
  has_many :items, through: :children, source: :child, source_type: "Item"
  has_many :belong_channels, through: :parents, source: :parent, source_type: "Channel"
end