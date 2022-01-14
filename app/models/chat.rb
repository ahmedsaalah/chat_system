class Chat < ApplicationRecord
    belongs_to :application, counter_cache: true
    has_many :messages
    after_create :add_to_redis_message_number

    def add_to_redis_message_number
        Redis.current.set("#{self.token}-#{self.number}", 0)
    end
end
