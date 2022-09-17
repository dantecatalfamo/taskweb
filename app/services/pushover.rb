require 'net/https'

class Pushover < ApplicationService
  def initialize(heading)
    @heading = heading
  end

  def call
    user_key = @heading.user.pushover_user_key
    return unless user_key

    url = URI.parse('https://api.pushover.net/1/messages.json')
    req = Net::HTTP::Post.new(url.path)
    message = HeadingsController.helpers.deadline_scheduled_line(@heading)
    message << "\n"
    message << @heading.body
    data = {
      token: Rails.application.credentials.pushover_token,
      user: user_key,
      title: @heading.title,
      message: message
    }
    req.set_form_data(data)
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res.start { |http| http.request(req) }
  end
end
