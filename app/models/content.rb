class Content < ActiveRecord::Base
  belongs_to :parent, polymorphic: true
  belongs_to :child, polymorphic: true
end
