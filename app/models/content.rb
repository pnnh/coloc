class Content < ActiveRecord::Base
  has_many :children, class_name: 'Content', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Content', foreign_key: 'parent_id'

  belongs_to :entity, polymorphic: true
  belongs_to :user

  has_many :channels, through: :children, source: :entity, source_type: 'Channel'
  has_many :articles, through: :children, source: :entity, source_type: 'Article'
end
