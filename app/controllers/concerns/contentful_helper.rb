require 'contentful/management'

module ContentfulHelper
  def self.unpublish_entry(request_body)
    ContentfulHelper.set_up(request_body)
    entry = @client.entries.find(@space_id, @entry_id) if @space_id && @entry_id
    entry.unpublish if entry
  end

  private

  def self.set_up(request_body)
    @client = Contentful::Management::Client.new(ENV['CONTENTFUL_ACCESS_TOKEN'])
    @space_id = ContentfulHelper.space_id(request_body)
    @entry_id = ContentfulHelper.entry_id(request_body)
  end

  def self.entry_id(request_body)
    request_body.dig('sys', 'id')
  end

  def self.space_id(request_body)
    request_body.dig('sys', 'space', 'sys', 'id')
  end
end
