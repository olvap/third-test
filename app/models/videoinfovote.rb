require 'couchbase/model'

class Videoinfovote < Couchbase::Model

  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attribute :videoID
  attribute :dataArr
  attribute :numberRate
  attribute :totalRate
  
  
  
  def save
    super
  end

  
  
  
  ###
  # Method: vote
  #
  # Input: videoID, socialID, socialType, commentContent, rateNum
  #
  # Return: void
  ###
  def self.vote(videoID, socialID, socialType, commentContent, rateNum)
    # Index key
    videoItSelf = "videorating_" + socialType + "_" + videoID
    
    begin
      first = Videoinfovote.find(videoItSelf)
    rescue Exception => e
      a = Videoinfovote.new
      a.id = videoItSelf
      a.videoID = videoID
      a.dataArr = []
      a.numberRate = 0
      a.totalRate = 0
      a.save
       
      # Add to videoinfo_indexing
      Sbdbindexing.addToIndex("videorating_" + socialType + "_indexing", a.id)
      
      first = Videoinfovote.find(videoItSelf)
    end
    
    myNode = [
      "raterid" => "user_" + socialType.to_s + "_" + socialID.to_s,
      "comment" => commentContent.to_s,
      "ratePoint" => rateNum
    ]

    first.dataArr << myNode
    if (rateNum > 0)
      first.numberRate = first.numberRate + 1
      first.totalRate = first.totalRate +  rateNum
    end
    
    first.save
  end

  ###
  # Method: getAverageRate
  # Input: VideoID, videoSocialType
  #
  # Return:
  #
  ###
  def self.getAverageRate(videoID, videoSocialType)
    mReturn = 0

    first = nil
    begin
      first = Videoinfovote.find("videorating_" + videoSocialType + "_" + videoID)
    rescue Exception => e
      if (first!=nil && first!=false)
        if (first.numberRate > 0)
          return first.totalRate/first.numberRate
        else
          return 0
        end
      else
        return 0
      end
    end
  end

  ###
  #
  # Input: VideoID
  #
  # Return:
  #
  ###
  def self.getCommentRate(videoID, videoSocialType)
    first = nil
    begin
      first = Videoinfovote.find("videorating_" + videoSocialType + "_" + videoID)
    rescue Exception => e
      myReturn = []
      if (first!=nil && first!=false)
        return first.dataArr
      end
      return myReturn
    end
  end

end