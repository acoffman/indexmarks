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
      uri = URI.parse(new_item[:url]) 
      opts = uri.scheme == "https" ? {:use_ssl => true} : {} 
      response = Net::HTTP.start(uri.host, uri.port, opt = opts) { |http| http.get uri.request_uri }

      if response.code == "200"
        bookmark = {:title => new_item[:title], :url => new_item[:url], :id => new_item[:id]}
        bookmark[:content] = Sanitize.clean(utf8_encode(response.body)).gsub(/\s+/," ")
        @mutex.synchronize { @index << bookmark }
      end
    end
  end

  def remove (id)
    Thread.new (id) do |delete_id|
      @index.search_each("id:#{delete_id}") do |fid, score|
        @mutex.synchronize { @index.delete(fid) }
      end
    end
  end

  def search (query, limit = 10 )
    results = []
    query = "*:#{query}*"
    @index.search_each(query , { :num_docs => limit }) do |id, score|
      results << {
        :title => utf8_encode(@index[id][:title]), 
        :url => utf8_encode(@index[id][:url]), 
        :content => utf8_encode(@index.highlight(query, id, :field => :content , :pre_tag => "", :post_tag => "").join)
     } 
    end
    results
  end

  private 
  def utf8_encode (text)
    text.encode("UTF-8", :invalid => :replace, :undef =>:replace, :replace => "")
  end

end

