class Joke < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :content, :source, :guid
  validates_uniqueness_of :guid

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  def thumbnail
    '//www.redditstatic.com/about/assets/reddit-alien.png'
  end

  private

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title   => entry.title,
          :content => entry.summary,
          :source  => 'reddit.com/r/jokes',
          :guid    => entry.id
        )
      end
    end
  end
end
