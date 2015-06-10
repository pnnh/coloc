class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true

  extend FriendlyId
  friendly_id :title, :use => [:slugged, :finders]
  
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s.gsub("-", "_")
  end
  
  def should_generate_new_friendly_id?
    new_record?
  end
end
