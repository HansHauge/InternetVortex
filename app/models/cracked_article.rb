class CrackedArticle < ActiveRecord::Base
  validates_presence_of :title, :source, :guid
  validates_uniqueness_of :guid

  def self.update_from_feed(entries)
    add_entries(entries)
  end

  private

  def self.add_entries(entries)
    return unless entries.present?
    entries.each do |entry|
      unless exists? :guid => entry.id
        create(
          :title      => entry.title,
          :source     => 'cracked.com',
          :thumbnail  => find_or_create_thumbnail(entry),
          :guid       => entry.entry_id
        )
      end
    end
  end

  def self.find_or_create_thumbnail(entry)
    finder = ThumbnailSetter.new(entry: entry, default_image: default_image, summary_or_content: entry.summary)
    finder.find_or_create_thumbnail
  end

  def self.default_image
    '//i.crackedcdn.com/ui/shared/images/global/layout/logo-yellow.png'
  end
end
