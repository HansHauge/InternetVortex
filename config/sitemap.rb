# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.internetvortex.com"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
# inform the map cross-linking where to find the other maps
SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do

  BreakVideo.find_each do |video|
    add video_path(video), :lastmod => video.updated_at
  end

  FailblogArticle.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end

  Joke.find_each do |joke|
    add joke_path(joke), :lastmod => joke.updated_at
  end

  MemebaseArticle.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end

  RedditFunnyPicture.find_each do |picture|
    add picture_path(picture), :lastmod => picture.updated_at
  end

  XkcdComic.find_each do |comic|
    add comic_path(comic), :lastmod => comic.updated_at
  end

  MemesPicture.find_each do |picture|
    add picture_path(picture), :lastmod => picture.updated_at
  end

  RedditAdviceAnimalsPicture.find_each do |picture|
    add picture_path(picture), :lastmod => picture.updated_at
  end

  add about_path

  Date.parse(ENV['INCEPTION_DATE_STRING']).upto(Date.current).each do |date|
    add front_page_archive_path(date: date.strftime('%B-%d-%Y')), :priority => 0.7, :lastmod => date
  end

end
