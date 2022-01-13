Redis.current = Redis.new(url:   ENV.fetch("REDIS_URL", "redis://redis") ,
    port: 6379,
    db:   0)
