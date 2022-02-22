module DynamicLinks
  class RequestTrackerService
    private_attr_accessor :request

    def initialize(request)
      @request = request
    end

    def self.call(request)
      self.new(request).process
    end

    private

    def process
      tracker = DynamicLinks::Tracker.new
      tracker.remote_ip = request.remote_ip
      tracker.ip = request.ip
      tracker.user_agent = request.headers['User-Agent']
      tracker.http_origin = request.headers['HTTP_ORIGIN']
      if tracker.save
        return true
      else
        Rails.logger.error("Not a valid request")
      end
      false
    end
  end
end
