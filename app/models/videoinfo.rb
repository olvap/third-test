require 'couchbase/model'

class Videoinfo < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :ownerSocialID
  attribute :ownerSocialType
  attribute :rate
  attribute :videoID
  attribute :wordID
  attribute :wordPackageID
  attribute :created_at, :default => lambda{ Time.zone.now }
  

  def save
    super
  end
  
  ###
  # Method: createVideoInformation 
  # 
  # Input: cOwnerSocialID, cOwnerSocialType, cVideoID, cWordID, cWordPackageID
  #
  # Return: 
  ###
  def self.createVideoInformation(cVideoInfoID, cOwnerSocialID, cOwnerSocialType, cVideoID, cWordID, cWordPackageID)
    begin
      Videoinfo.find(cVideoInfoID)
    rescue Exception => e
      a = Videoinfo.new
      a.id = cVideoInfoID
      a.ownerSocialID = cOwnerSocialID
      a.ownerSocialType = cOwnerSocialType
      a.rate = 0
      a.videoID = cVideoID
      a.wordID = cWordID
      a.wordPackageID = cWordPackageID
      a.save
      
      # Update Word Played Count
      begin
        b = Words.find(cWordID)
        if(b.playedCount == nil || b.playedCount == '')
          playedCount = 1
        else
          playedCount = b.playedCount
          playedCount = playedCount.to_i + 1
        end
        b.playedCount = playedCount.to_i
        b.save
      rescue Exception => e
        # ignore
      end
    end
  end
  
  #
  # @End FILE
  #
end
