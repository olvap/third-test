require 'couchbase/model'

class Game < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :gameType
  attribute :opponentSocialID
  attribute :ownerSocialID
  attribute :pushMode
  attribute :socialType
  attribute :videoInfoID
  attribute :gameStatus
  attribute :created_at, :default => lambda{ Time.zone.now }
  
  def save
    super
  end
  
  
  
  
  ###
  # Method: createVideoInformation 
  # 
  # Input: gameType, opponentSocialID, ownerSocialID, pushMode, socialType, videoInfoID
  #
  # Return: 
  ###
  def self.createGameInfo(gameID, gameType, opponentSocialID, ownerSocialID, pushMode, socialType, videoInfoID)
    begin
      Game.find(gameID)
    rescue Exception => e
      a = Game.new
      a.id = gameID
      a.gameType = gameType
      a.opponentSocialID = opponentSocialID
      a.ownerSocialID = ownerSocialID
      a.pushMode = pushMode
      a.socialType = socialType
      a.videoInfoID = videoInfoID
      a.gameStatus = "0"
      a.save
    end
  end
  
  
  
  
  ###
  # Method: getGameDetail 
  # 
  # Input: gameId
  #
  # Return: 
  ###
  def self.getGameDetail(gameID)
    begin
      a = Game.find(gameID)
      
      wordID = Words.getWordIDFromGame(gameID)
      wordIDDetail = Words.find(wordID)
      wordName = wordIDDetail.wordName
      wordCoin = wordIDDetail.wordCoin
      packID = wordIDDetail.packId
      randWord = Words.randomWordCharacters(wordName)
      
      videoInfo = Videoinfo.find(a.videoInfoID)
      videoID = videoInfo.videoID
      
      # get WordPackName
      wordPackDetail = Wordpacks.find(packID)
      wordPackName = wordPackDetail.packName
      
      # get opponentSocialFullname
      c = Player.find('user_' + a.socialType + '_' + a.opponentSocialID)
      opponentSocialFullname = c.fullname
      
      # get OwnerSocialFullname
      b = Player.find('user_' + a.socialType + '_' + a.ownerSocialID)
      ownerSocialFullname = b.fullname
      
      rData = {
        "OpponentSocialID" => a.opponentSocialID,
        "OpponentFullname" => opponentSocialFullname,
        "OwnerSocialID" => a.ownerSocialID,
        "OwnerFullname" => ownerSocialFullname,
        "RandomWords" => randWord,
        "Coins" => wordCoin,
        "SocialType" => a.socialType,
        "VideoID" => videoID,
        "Word" => wordName,
        "WordPackName" => wordPackName,
        "WordID" => wordID
      }
      
      return rData
    rescue Exception => e
      return nil
    end
  end
  
  
  
  
  ###
  # Method: getLatestSceneNoOfTwoPlayers
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.getLatestSceneNoOfTwoPlayers(socialType, iD1, iD2)
    indexKey = "ongame_" + socialType.to_s + "_" + iD1.to_s + "_" + iD2.to_s
    begin
      Sbdbindexing.find(indexKey)
    rescue Exception => e
      Sbdbindexing.newIndex(indexKey)
    end
    a = Sbdbindexing.find(indexKey)
    if(a.arrayvalue == [])
      return 0
    else
      currentArrayValue = a.arrayvalue
      lastValue = currentArrayValue.last
      return lastValue[0]["scene"]
    end
  end
  
  
  
  
  ###
  # Method: updateOnPlayingGameIndexing
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.updateOnPlayingGameIndexing(gameID, keyOwnerID, oppID, socialType)
    indexKey = "ongame_" + socialType + "_" + keyOwnerID + "_" + oppID
    ownerKey = "ongame_" + socialType + "_" + keyOwnerID + "_indexing"
    # add to index
    begin
      Sbdbindexing.find(indexKey)
    rescue Exception => e
      Sbdbindexing.newIndex(indexKey)
      a = Sbdbindexing.find(ownerKey)
      a.arrayvalue << indexKey
      a.save
    end
    
    a = Sbdbindexing.find(indexKey)
    
    if(a.arrayvalue == [])
      updateScene = 1
      firstArray = ["gameID" => gameID, "scene" => 1]
      a.arrayvalue << firstArray
    else
      # let's find the latest scene number
      currentArrayValue = a.arrayvalue
      lastValue = currentArrayValue.last
      latestScene = lastValue[0]["scene"]
      updateScene = latestScene.to_i + 1
      
      # Plus 1, then save
      addValue = ["gameID" => gameID, "scene" => updateScene]
      a.arrayvalue << addValue
    end
    
    # Save the indexing
    a.save
    
    return updateScene
  end
  
  
  
  
  ###
  # Method: updateSceneStatus
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.updateSceneStatus(socialType, socialID, sceneID, sceneType)
  	begin
      x = Sbdbindexing.find("ongame_" + socialType + "_" + sceneType + "_" + socialID)
      xz = x.arrayvalue
      xz.each do |sceneDetail|
        if(sceneDetail[0]["sceneID"] == sceneID)
          # prepare updated data
          updatedSceneValue = [
            "sceneNo" => sceneDetail[0]["sceneNo"],
            "sceneID" => sceneDetail[0]["sceneID"],
            "opponentSocialID" => sceneDetail[0]["opponentSocialID"],
            "opponentSocialFullname" => sceneDetail[0]["opponentSocialFullname"],
            "gameID" => sceneDetail[0]["gameID"],
            "sceneStatus" => 1,
            "createdTime" => Time.now,
          ]
          
          # add updated data
          xz << updatedSceneValue
          
          # remove old data
          xz = xz.delete_if{|x| x[0]["sceneID"] == sceneID && x[0]["sceneStatus"] == 0}
          
          # save it
          x.arrayvalue = xz
          x.save
          break
        end
      end
    rescue Exception => e
    end
  end
  
  
  
  
  ###
  # Method: removeSceneFromIndex
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.removeSceneFromIndex(socialType, ownerID, theirID, sceneType)
    begin
      x = Sbdbindexing.find("ongame_" + socialType + "_" + sceneType + "_" + ownerID)
      oTRemove = x.arrayvalue
      x.arrayvalue = oTRemove.delete_if{|x| x[0]["opponentSocialID"] == theirID}
      x.save
    rescue Exception => e
    end
  end
  
  #
  # @End FILE
  #
end
