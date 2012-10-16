require 'couchbase/model'

class Wordpacks < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attribute :packName
  attribute :packCoin
  attribute :wordIds
  attribute :imageName
  attribute :created_at, :default => lambda{ Time.zone.now }
  
  def save
    super
  end 
  
  
  
  
  ###
  # Method: createPack
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.createPack(packName, packCoin, imageName)
      a = Wordpacks.new
      
      # Insert new WordPack
      a.id = "wordpack_" + Digest::MD5.hexdigest(packName + Time.now.to_s)
      a.packName = packName
      a.packCoin = packCoin
      a.wordIds = []
      a.imageName = imageName
      a.save
      
      # Add to wordpackage_indexing
      Sbdbindexing.addToIndex("wordpackage_indexing", a.id)
  end
  
end
