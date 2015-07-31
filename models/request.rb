class Request
  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def uri
    URI.parse(url)
  end

  def get
    Net::HTTP.get(uri)
  end
end
