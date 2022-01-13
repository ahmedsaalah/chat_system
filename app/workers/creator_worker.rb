class CreatorWorker
  include Sidekiq::Worker

  def perform(type,data)
        Creator.for(type).create(data)
  end
end


class Creator
  def self.for(type)
    case type
    when 'chat'
      ChatCreator.new
    when 'message'
      MessageCreator.new
    else
      raise 'Unsupported type of creation'
    end
  end
end

class ChatCreator
  def create(data)
    Chat.new(data).save!
  end
end

class MessageCreator
  def create(data)
    Message.new(data).save!
  end
end

