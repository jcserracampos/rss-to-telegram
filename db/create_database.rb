# frozen_string_literal: true

require 'sqlite3'

db = SQLite3::Database.new 'posts.db'

db.execute <<-SQL
  create table last_post (
    pub_date datetime
  );
SQL
