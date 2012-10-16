require 'couchbase/model'

class Videotemp < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :playedCount
  attribute :created_at, :default => lambda{ Time.zone.now }
  

  def save
    super
  end
  
  ###
  # Method: createVideoTemp 
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.createVideoTemp(id)
    begin
      Videotemp.find(id)
    rescue Exception => e
      a = Videotemp.new
      a.id = id
      a.playedCount = 0
      a.save
    end
  end
  
  #
  # @End FILE
  #
end
