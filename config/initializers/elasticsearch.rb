config = {
    transport_options: { request: { timeout: 5 } }
  }
  if File.exist?('config/elasticsearch.yml')
    template = ERB.new(File.new('config/elasticsearch.yml').read)
    processed = YAML.safe_load(template.result(binding))
    config.merge!(processed[Rails.env].symbolize_keys)
  end
  Kaminari::Hooks.init if defined?(Kaminari::Hooks)
  Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari
  Elasticsearch::Model.client = Elasticsearch::Client.new(config)
