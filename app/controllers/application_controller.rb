class ApplicationController < ActionController::API
 before_action :throttle_token
 before_action :authenticate_request

  protected

  def throttle_ip
  	puts "=========CHECK TOO MANY REQUEST=============="
    client_ip = request.env["REMOTE_ADDR"]
    key = "count:#{client_ip}"
    count = REDIS.get(key)

    unless count
      REDIS.set(key, 0)
      REDIS.expire(key, THROTTLE_TIME_WINDOW)
      return true
    end

    if count.to_i >= THROTTLE_MAX_REQUESTS
      render :json => {:message => "You have fired too many requests. Please wait for some time."}, :status => 429
      return
    end
    REDIS.incr(key)
    true
  end

  def throttle_token
    if @token.present?
      key = "count:#{@token}"
      count = REDIS.get(key)

      unless count
        REDIS.set(key, 0)
        REDIS.expire(key, THROTTLE_TIME_WINDOW)
        return true
      end

      if count.to_i >= THROTTLE_MAX_REQUESTS
        render :json => {:message => "You have fired too many requests. Please wait for some time."}, :status => 429
        return
      end
      REDIS.incr(key)
      true
    else
      false
    end
  end

  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end