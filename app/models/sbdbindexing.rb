require 'couchbase/model'

class Sbdbindexing < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :arrayvalue
  attribute :created_at, :default => lambda{ Time.zone.now }
  
  def save
    super
  end
  
  
  ###
  # Method: newIndex
  # 
  # Input: key
  #
  # Return: true
  ###
  def self.newIndex(index)
    index = index.to_s
    begin
      Sbdbindexing.find(index)
    rescue Exception => e
      a = Sbdbindexing.new
      a.id = index
      a.arrayvalue = []
      a.save
    end
  end
    
  
  
  
  ###
  # Method: addToIndex
  # self.
  # Input: index, value
  #
  # Return: true
  ###
  def self.addToIndex(index, value)
    index = index.to_s
    begin
      Sbdbindexing.find(index)
    rescue Exception => e
      sbdb = Sbdbindexing.new
      sbdb.id = index
      sbdb.arrayvalue = []
      sbdb.save
    end
    b = Sbdbindexing.find(index)
    b.arrayvalue = b.arrayvalue << value
    b.save
  end
  
  
  
  
  ###
  # Method: findTopIndex
  # self.
  # Input: indexType, socialType
  #
  # Return: this
  ###
  def self.findTopIndex(indexType, socialType)
    # There are 3 types of indexType: player, video, word
    # There are 3 types of socialType: 100 (FaceBook), 101 (Twitter), 102 (Weibo)
    thisKeyName = 'sb_indexing_top_100_' + indexType + '_' + socialType.to_s
    
    begin
      Sbdbindexing.find(thisKeyName)
    rescue Exception => e
      result = []
      n = 100
      begin
        result << [0, '2000-01-01T00:00:00Z', 'undefined_top_' + indexType + '_tempo', 'undefined_id_value']
        n -= 1
      end while n > 0
        
      a = Sbdbindexing.new
      a.id = thisKeyName
      a.arrayvalue = result
      a.save
    end
    
    return Sbdbindexing.find(thisKeyName)
  end
  
  
  
  
  ###
  # Method: updateTopIndex
  # self.
  # Input: indexType, socialType, arrayValue
  #
  # Return: true
  ###
  def self.updateTopIndex(indexType, socialType, arrayValue)
    # There are 3 types of indexType: player, video, word
    # There are 3 types of socialType: 100 (FaceBook), 101 (Twitter), 102 (Weibo)
    # arrayValue = [amount, updated_datetime, string, id]
    
    # Find index
    a = Sbdbindexing.findTopIndex(indexType, socialType)
    currentValue = a.arrayvalue
    
    # Currently this index has 100 items
    # Let's add this value, then sort, then cut the item numbered 101
    updatedValue << arrayValue
    
    # Sort
    sortedValue = updatedValue.sort.reverse
    
    # Then, we have result
    result = sortedValue[0,100]
    
    # Save it
    a.arrayvalue = result
    a.save
    
    # Done
  end
  
  #
  # @End FILE
  #
end
