class Api::GameController < Api::SbController
  ###
  # Method: createGame
  # 
  # Input: 
  #
  # Return: 
  ###
  def createGame
    if(request.post?)
      cToken = self.findKeyInJSON(params[:params], "Token", 2)
      cPushMode = self.findKeyInJSON(params[:params], "PushMode", 2)
      cOpponentSocialID = self.findKeyInJSON(params[:params], "OpponentSocialID", 2)
      cOpponentSocialFullname = self.findKeyInJSON(params[:params], "OpponentSocialFullname", 2)
      cOwnerSocialID = self.findKeyInJSON(params[:params], "OwnerSocialID", 2)
      cOwnerSocialFullname = self.findKeyInJSON(params[:params], "OwnerSocialFullname", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      cVideoInfoID = self.findKeyInJSON(params[:params], "VideoInfoID", 2)
      cGameType = nil
      
      # Check if these 2 players played game for 1000 scenes
      currentSceneNo = Game.getLatestSceneNoOfTwoPlayers(cSocialType, cOwnerSocialID, cOpponentSocialID)
      
      # If scene number is >= 1000. Reached the limit
      if(currentSceneNo >= 1000)
        rData = {"Status" => "False"}
        rMessage = "1000 scenes reached"
      else
        # Push Notification
        case cPushMode.to_s
        when "100"
          begin
            p = Player.find("user_" + cSocialType + "_" + cOpponentSocialID)
            deviceToken = p.deviceToken
          rescue Exception => e
            deviceToken = ''
          end
          APNS.host = 'gateway.sandbox.push.apple.com'
          APNS.pem = File.join(Rails.root, 'config', 'apns-dev.pem')
          APNS.port = 2195
          APNS.send_notification(deviceToken, :alert => "You have a new game!", :badge => 1, :sound => 'default')
        when "101"
          # android
        else
          # ignore
        end
        
        # Create Game ID
        intNum = [1,2,3,4,5,6,7,8,9,0]
        ranNum = intNum[rand(intNum.length)]
        gameID = "game_" + Digest::MD5.hexdigest(ranNum.to_s + Time.now.to_s)

        # Create Game Information
        Game.createGameInfo(gameID, cGameType, cOpponentSocialID, cOwnerSocialID, cPushMode, cSocialType, cVideoInfoID)
        
        # Update On Playing Game indexing
        sceneNo = Game.updateOnPlayingGameIndexing(gameID, cOwnerSocialID, cOpponentSocialID, cSocialType)
        Game.updateOnPlayingGameIndexing(gameID, cOpponentSocialID, cOwnerSocialID, cSocialType)
        
        # Update Invited Game indexing
        Sbdbindexing.addToIndex("user_" + cSocialType + "_invitedgame_" + cOpponentSocialID, gameID)
        
        # Update Created Game indexing
        Sbdbindexing.addToIndex("user_" + cSocialType + "_createdgame_" + cOwnerSocialID, gameID)
        
        # Remove Opponent's MyScene & Owner's TheirScene
        Game.removeSceneFromIndex(cSocialType, cOpponentSocialID, cOwnerSocialID, "myscene")
        Game.removeSceneFromIndex(cSocialType, cOwnerSocialID, cOpponentSocialID, "theirscene")
        
        Game.removeSceneFromIndex(cSocialType, cOwnerSocialID, cOpponentSocialID, "myscene")
        Game.removeSceneFromIndex(cSocialType, cOpponentSocialID, cOwnerSocialID, "theirscene")
        
        # Update to Scene indexing
        mySceneData = [
          "sceneNo" => sceneNo,
          "sceneID" => Digest::MD5.hexdigest('scene' + Time.now.to_s),
          "opponentSocialID" => cOwnerSocialID,
          "opponentSocialFullname" => cOwnerSocialFullname,
          "gameID" => gameID,
          "sceneStatus" => 0,
          "createdTime" => Time.now
        ]
        Sbdbindexing.addToIndex("ongame_" + cSocialType.to_s + "_myscene_" + cOpponentSocialID, mySceneData)
        
        theirSceneData = [
          "sceneNo" => sceneNo,
          "sceneID" => Digest::MD5.hexdigest('scene' + Time.now.to_s),
          "opponentSocialID" => cOpponentSocialID,
          "opponentSocialFullname" => cOpponentSocialFullname,
          "gameID" => gameID,
          "sceneStatus" => 0,
          "createdTime" => Time.now
        ]
        Sbdbindexing.addToIndex("ongame_" + cSocialType.to_s + "_theirscene_" + cOwnerSocialID, theirSceneData)
        
        rData = {"Status" => "True"}
        rMessage = "Game Created Successfully"
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(rData, rMessage, cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getGameInfo
  # 
  # Input: 
  #
  # Return: 
  ###
  def getGameInfo
    if(request.post?)
      cGameID = self.findKeyInJSON(params[:params], "GameID", 2)
      
      # Get Game Information
      rData = Game.getGameDetail(cGameID)
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(rData, 'Game Detail', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: updateGameResult
  # 
  # Input: 
  #
  # Return: 
  ###
  def updateGameResult
    if(request.post?)
      cGameID = self.findKeyInJSON(params[:params], "GameID", 2)
      cStatus = self.findKeyInJSON(params[:params], "Status", 2) # 100: Owner Win, 101: Opp Win, 102: draw
      cCoins = self.findKeyInJSON(params[:params], "Coins", 2)
      cRedRockets = self.findKeyInJSON(params[:params], "RedRocket", 2)
      cRWBRockets = self.findKeyInJSON(params[:params], "RWBRocket", 2)
      cOwnerSocialID = self.findKeyInJSON(params[:params], "OwnerSocialID", 2)
      cOpponentSocialID = self.findKeyInJSON(params[:params], "OpponentSocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      cSceneID = self.findKeyInJSON(params[:params], "SceneID", 2)
      
      
      begin
        # update Game Status
        a = Game.find(cGameID.to_s)
        a.gameStatus = cStatus.to_s
        a.save
        
        # update ShowBucks & Scene Indexing
        case cStatus.to_s
        when "102" # Owner Win
          #winnerID = cOwnerSocialID
          #loserID = cOpponentSocialID
          g = Sbdbindexing.find("ongame_" + cSocialType.to_s + "_" + cOwnerSocialID.to_s + "_" + cOpponentSocialID.to_s)
          gx = g.arrayvalue
          gz = gx.last
          gz[0]["scene"] = 0
          g.arrayvalue = gx
          g.save
    
          h = Sbdbindexing.find("ongame_" + cSocialType.to_s + "_" + cOpponentSocialID.to_s + "_" + cOwnerSocialID.to_s)
          hx = h.arrayvalue
          hz = hx.last
          hz[0]["scene"] = 0
          h.arrayvalue = hx
          h.save
        when "101" # Opp Win
          #winnerID = cOpponentSocialID
          #loserID = cOwnerSocialID
          Player.addPlayerCoins(cOpponentSocialID, cSocialType, cCoins)
          Player.addPlayerCoins(cOwnerSocialID, cSocialType, cCoins)
        else
        #  winnerID = loserID = nil
        end
        
        #if(winnerID != nil && loserID != nil)
        #  Player.updatePlayerCoins(winnerID, loserID, cSocialType, cCoins)
        #end
        
        # update Opponent Rockets
        Player.updatePlayerRockets(cOpponentSocialID, cSocialType, cRedRockets, cRWBRockets)
        
        # update status for this game at Opponent's "My Scene"
        Game.updateSceneStatus(cSocialType, cOpponentSocialID, cSceneID, "myscene")
        
        # update status for this game at Owner's "Their Scene"
        Game.updateSceneStatus(cSocialType, cOwnerSocialID, cSceneID, "theirscene")
        
        #
        rStatus = "100"
      rescue Exception => e
        rStatus = "101"
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      rData = {"Status" => "true"}
      self.jsonRender(rData, 'Game Result Updated', cRequestID, rStatus)
    end
  end
  
  #
  # @End FILE
  #
end
