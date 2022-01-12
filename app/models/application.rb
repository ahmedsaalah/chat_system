class Application < ApplicationRecord
    before_create :set_token 
    after_create :add_to_redis
    has_many :chats
    
    def add_to_redis
        Redis.current.set(self.token, 1)
    end

    def set_token
        self.token = SecureRandom.urlsafe_base64(15)
    end
    def as_json(options = {})
        {
            name: name,
            token: token,
            chat_count: chat_count
        }
    end
end
