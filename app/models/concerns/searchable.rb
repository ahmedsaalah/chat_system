module Searchable
    extend ActiveSupport::Concern
  
    included do
      include Elasticsearch::Model
  

      settings index: { number_of_shards: 1 } do
        mappings dynamic: false do
          indexes :text, type: :text, analyzer: :english
        end
      end
  
      def self.search(query, chat_id)
        __elasticsearch__.search(
          {
            query: {
              wildcard: {
                text: {
                  value: "*#{query}*",
                }
              }
            }
          }, {index: chat_id }
        )
      end
      private
      def as_indexed_json(options = nil)
        self.as_json( only: [:number, :text, :chat_id ] )
      end
      def index_message
        __elasticsearch__.index_document({index: chat_id})
      end
      
    end
end  