require 'ferret'
require 'net/http'
require 'sanitize'
require 'thread'

class BookmarksIndex

  include Ferret

  def initialize
    @index = Index::Index.new( :path => "./bookmarks.idx" )
    @mutex = Mutex.new
  end

  def << (item)
    Thread.new (item) do |new_item|
      response = Net::HTTP.get_response(URI.parse(new_item[:url]))

      if response.code == "200"
        bookmark = {:title => new_item[:title], :url => new_item[:url]}
        bookmark[:content] = Sanitize.clean(utf8_encode(response.body)).gsub(/\s+/," ")
        @mutex.synchronize { @index << bookmark }
      end
    end
  end

  def search (query, limit = 10 )
    results = []
    @index.search_each("*:#{query}", { :num_docs => limit }) do |id, score|
      results << {:title => utf8_encode(@index[id][:title]), 
        :url => utf8_encode(@index[id][:url]), 
        :content => utf8_encode(@index[id][:content][0...1000]) } 
    end
    results
  end


  private 
  def utf8_encode (text)
    text.encode("UTF-8", :invalid => :replace, :undef =>:replace, :replace => "")
  end

end

