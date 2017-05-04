require 'rubygems'
require 'open-uri'
require 'digest/sha1'
require 'securerandom'
require 'timeout'
require 'json'

module WechatKit

  TokenUrl = "https://api.weixin.qq.com/cgi-bin/token"
  TicketUrl =  "https://api.weixin.qq.com/cgi-bin/ticket/getticket"

  extend self

  attr_reader :app_id, :app_secret, :access_token, :access_token_expired_at, :jsapi_ticket, :jsapi_ticket_expired_at
  attr_accessor :logger

  def setup(app_id, app_secret)
    @app_id = app_id
    @app_secret = app_secret
  end

  def signature(url, jsApiList=[], debug=false)
    jsapi_ticket =  get_js_api_ticket
    timestamp = Time.now.to_i.to_s
    nonce = SecureRandom.hex 16
    # 这里参数的顺序要按照 key 值 ASCII 码升序排序
    string = "jsapi_ticket=#{jsapi_ticket}&noncestr=#{nonce}&timestamp=#{timestamp}&url=#{url}"
    signature = Digest::SHA1.hexdigest(string)

    info("string: #{string}, signature: #{signature}")

    sign_package = {
      "debug"     => debug,
      "appId"     => @app_id,
      "nonceStr"  => nonce,
      "timestamp" => timestamp,
      "url"       => url,
      "signature" => signature,
      "jsApiList" => jsApiList
     }
    return sign_package.to_json
  end

  def get_access_token
    if @access_token_expired_at and @access_token_expired_at > Time.now
      @access_token
    else
      url = "#{TokenUrl}?grant_type=client_credential&appid=#{@app_id}&secret=#{@app_secret}"
      response = response_from_url(url)
      @access_token = response["access_token"]
      @access_token_expired_at = Time.now + 7000
      @access_token
    end
  end

  def get_js_api_ticket
    if @jsapi_ticket_expired_at and @jsapi_ticket_expired_at > Time.now
      @jsapi_ticket
    else
      url = "#{TicketUrl}?type=jsapi&access_token=#{get_access_token}"
      response = response_from_url(url)
      @jsapi_ticket = response["ticket"]
      @jsapi_ticket_expired_at = Time.now + 7000
    end
    @jsapi_ticket
  end

  def response_from_url(url)
    response = {}
    Timeout::timeout(3) do
      open(url) {|f|
        response = JSON.parse f.read
      }  rescue {}
    end
    response
  end

  def info(msg)
    logger.info(msg) if logger && logger.respond_to?(:info)
  end
end