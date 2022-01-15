class Application < ApplicationRecord
    before_create :set_token 
    after_create :add_to_redis_chat_number
    has_many :chats
    
    def add_to_redis_chat_number
        Redis.current.set(self.token, 0)
    end

    def set_token
        self.token = SecureRandom.urlsafe_base64(15)
    end
    def as_json(options = {})
        {
            name: name,
            token: token,
            chats_count: chats_count
        }
    end
end
