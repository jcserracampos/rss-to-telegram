require 'rss'
require 'sqlite3'
require 'open-uri'
require 'telegram/bot'

url = ''
token = ''
channel_id = ''

# db = SQlite3::Database.new 'posts.db'

def safe_markdown(text)
  text.gsub(%r[/[-!$%^&*()_+|~=`{}\[\]:";'<>?,.\/#…]/]) { |symbol| '\\\1' }
end

URI.open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  message = "[#{safe_markdown(feed.items.first.link)}](#{safe_markdown(feed.items.first.title)})\n #{safe_markdown(feed.items.first.description)}"
  Telegram::Bot::Client.run(token) do |bot|
    bot.api.send_message(
      chat_id: channel_id,
      text: message,
      parse_mode: 'MarkdownV2'
    )
  end
end
