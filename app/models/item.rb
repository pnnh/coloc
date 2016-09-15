class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s.gsub("-", "_")
  end

  has_many :parents, class_name:"Content", as: :child
  has_many :belong_channels, through: :parents, source: :parent, source_type: "Channel"
end
