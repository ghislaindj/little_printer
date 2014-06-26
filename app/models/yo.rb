class Yo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username,              type: String
  field :printed_at,            type: Time

  def html
    "html=<html><head><meta charset='utf-8'></head><body><h1>Yo!</h1><p>From #{self.username}</p></body></html>"
  end

  def can_print?
    last_yo = Yo.where(username: self.username).order("printed_at DESC").first

    if last_yo && last_yo.printed_at > 10.minute.ago
      return false
    end

    return true
  end

  def print
    if self.can_print?
      #response = Net::HTTP.post_form(URI("#{Settings.printer.url}#{Settings.printer.code}"), {'html' => self.html})
      #raise Error if response.code != "200"

      self.update_attribute(:printed_at, DateTime.now)
      logger.info "############# Yo! printed from #{self.username}"
    else
      logger.info "Too many print"
    end
  end

  def printed
    self.printed_at.present?
  end
end