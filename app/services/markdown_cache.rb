class MarkdownCache
  EXPIRE = 7.days

  def initialize
  end

  def rendered_markdown(markdown)
    key = key(Digest::SHA1.hexdigest(markdown))
    from_cache(key) do
      yield(markdown)
    end
  end

  private

  def from_cache(key, &block)
    if (value = redis.get(key)).nil?
      value = yield(self)
      redis.set(key, Marshal.dump(value))
      redis.expire(key, EXPIRE)
      value
    else
      Marshal.load(value)
    end
  end

  def key(sha)
    "markdown:#{sha}"
  end

  def redis
    $redis
  end
end