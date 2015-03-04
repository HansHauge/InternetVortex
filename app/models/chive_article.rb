class ChiveArticle < ActiveRecord::Base
  validates_presence_of :title, :summary, :source, :guid, :image
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
          :summary    => entry.summary,
          :source     => 'thechive.com',
          :guid       => entry.url,
          :thumbnail  => entry.media_thumbnail_url.first,
          :categories => entry.categories,
          :image      => entry.image
        )
      end
    end
  end
end
