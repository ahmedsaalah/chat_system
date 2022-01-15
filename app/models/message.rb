class Message < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    belongs_to :chat , counter_cache: true
    include Searchable
    after_commit :index_message 

    def as_json(options = {})
        {
            number: number,
            text: text,
            chat_id: chat_id,
            created_at: created_at,
            updated_at: updated_at

        }
    end
end
