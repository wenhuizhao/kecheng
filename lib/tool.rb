require 'net/http'
module Tool
  def send_sms(opts)
    default_opts = {
      action: 'send',
      account: '',
      password: ''
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

  def send_request_grades(desc, header_teacher = super_admin)
    Message.create(sender_id: current_user.id, 
                   receiver_id: header_teacher.id,
                   type_name: 'apply_grades',
                   desc: desc)
  end
end
