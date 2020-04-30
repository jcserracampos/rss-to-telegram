# frozen_string_literal: true

require 'rss'
require 'sqlite3'
require 'open-uri'
require 'telegram/bot'

url = ''
token = ''
channel_id = ''

db = SQLite3::Database.new 'posts.db'

def safe_markdown(text)
  text.gsub(%r{[-!$%^&*()_+|~=`.{}\[\]:";'<>?,\/#…]}) { |s| '\\' + s }
end

URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  db.execute "insert into last_post values (?)", feed.items.first.pubDate
    # message = "[#{safe_markdown(feed.items.first.title)}](#{feed.items.first.link})\n #{safe_markdown(feed.items.first.description)}"

  # Telegram::Bot::Client.run(token) do |bot|
  #   bot.api.send_message(
  #     chat_id: channel_id,
  #     text: message,
  #     parse_mode: 'MarkdownV2'
  #   )
  # end
end
