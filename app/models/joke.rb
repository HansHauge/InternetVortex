class Joke < ActiveRecord::Base
  validates_presence_of :title, :content, :source, :guid

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  private

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :title   => entry.title,
          :content => entry.summary,
          :source  => entry.url,
          :guid    => entry.id
        )
      end
    end
  end
end
