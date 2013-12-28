require 'net/http'
module Tool
  def send_sms(opts)
    default_opts = {
      action: 'send',
      userID: Settings.sms_userid,
      account: Settings.sms_account,
      password: Settings.sms_password
    }
    url = 'http://www.qf106.com/sms.aspx'
    post_data(url, default_opts.merge(opts))
  end

  def post_data(url, pas)
    uri = URI.parse(URI.encode(url))
    http = Net::HTTP.new(uri.host, uri.port) 
    http.use_ssl = true if uri.scheme == 'https'
    req = Net::HTTP::Post.new(uri.path) 
    req.set_form_data(pas)
    res = http.request(req) 
    res.body  
  end
  
  def super_admin
    User.where(role_id: nil).first
  end

  module Percent
    def to_percent(n, total)
      (n/total.to_f * 100).round(2).to_s + "%"
    end
  end

end
