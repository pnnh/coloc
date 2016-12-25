class Content < ActiveRecord::Base
  has_many :contents
  belongs_to :content

  belongs_to :entity, polymorphic: true

  has_many :channels, through: :contents, source: :entity, source_type: "Channel"
  has_many :articles, through: :contents, source: :entity, source_type: "Article"
end
