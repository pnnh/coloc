class UserChannel < ActiveRecord::Base
    belongs_to :user
    belongs_to :channel
    def self.bespoke_query(id)
        query = sanitize_sql(['select * from users where id = ?', id])
        connection.execute(query)
    end
end
