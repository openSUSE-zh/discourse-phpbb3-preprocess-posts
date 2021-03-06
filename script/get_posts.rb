require 'mysql2'

module PHPBB3_BB2MD
  # extract posts from database
  class Parser
    def initialize(conf)
      # {'source'=>ostruct, 'dest'=>ostruct}
      @conf = PHPBB3_BB2MD::Config.new(conf).hash
      @source_ostruct = @conf['source']
      @mysql = Mysql2::Client.new(:host => @source_ostruct.host,
				   :port => @source_ostruct.port,
				   :database => @source_ostruct.schema,
				   :username => @source_ostruct.username,
				   :password => @source_ostruct.password)
    end

    def get
      get_data_from_posts_table
    end

    def put

    end

    private

    def get_data_from_posts_table
      posts_data = @mysql.query("SELECT bbcode_uid,post_text FROM #{@source_ostruct.table_prefix}posts")
      open('posts.txt','w:UTF-8') do |f|
        posts_data.each do |row|
          arr = [row['bbcode_uid'],row['post_text']]
          f.write "#{arr}\n"
        end
      end
    end
  end
end
require './config.rb'
PHPBB3_BB2MD::Parser.new('config').get
