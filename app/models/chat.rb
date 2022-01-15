class Chat < ApplicationRecord
    belongs_to :application, counter_cache: true
    has_many :messages
    after_create :add_to_redis_message_number

    def add_to_redis_message_number
        Redis.current.set("#{self.application_id}-#{self.number}", 0)
    end

    def as_json(options = {})
        {
            number: number,
            messages_count: messages_count,
            created_at: created_at,
            updated_at: updated_at

        }
    end
end
