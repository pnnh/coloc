class Interaction < ActiveRecord::Base
    belongs_to :user
    belongs_to :entity, polymorphic: true
    belongs_to :channel
end
