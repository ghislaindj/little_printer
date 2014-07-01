class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username,              type: String
  field :title,                 type: String
  field :text,                  type: String
  field :printed_at,            type: Time

  def html
    "<html><head><meta charset='utf-8'></head><body><h1>Yo!</h1><p>From #{self.username}</p></body></html>"
  end

  def print(html = self.html)
    if self.can_print?
      response = Net::HTTP.post_form(URI("#{Settings.printer.url}#{Settings.printer.code}"), {'html' => html})
      raise Error if response.code != "200"

      self.update_attribute(:printed_at, DateTime.now)
      logger.info "############# Message printed from #{self.username}"
    else
      logger.info "Too many print"
    end
  end

  def printed
    self.printed_at.present?
  end

  def avatar
    "http://robohash.org/#{self.username}+#{self.created_at.to_i}.png"
  end
end