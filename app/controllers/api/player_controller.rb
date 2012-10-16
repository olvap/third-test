class Api::PlayerController < Api::SbController
  
  ###
  # Method: updateSocialProfile
  # 
  # Input: DeviceID, Services,
  #        Fullname, Username, LangCode
  #        SocialID, SocialType, SocialRange, Services
  #        RequestID, SessionID, Token
  #
  # Return: Status (true), RequestID
  ###
  def updateSocialProfile
    if(request.post?)
      # Check if user exists
      cSocialID = self.findKeyInJSON(params[:params], "SocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      cSocialRange = self.findKeyInJSON(params[:params], "SocialRange", 2)
      cFullname = self.findKeyInJSON(params[:params], "Fullname", 2)
      cUsername = self.findKeyInJSON(params[:params], "Username", 2)
      cServices = self.findKeyInJSON(params[:params], "Services", 2)
      
      # Check user's mobile OS
      if(cServices["AndroidPush"] != '')
        cDeviceToken = cServices["AndroidPush"]
        cMobileOS = 'Android'
      else
        cDeviceToken = cServices["AppleAPNS"]
        cMobileOS = 'iOS'
      end
      

      if(Player.findUser(cSocialID, cSocialType)) # If exists, return true
        # Ignore
        a = Player.find("user_" + cSocialType.to_s + "_" + cSocialID.to_s)
        a.deviceToken = cDeviceToken
        a.mobileOS = cMobileOS
        a.save
      else # Else, create new, give him 100 showbucks, 10 RR, and 5 RWBR for free
        Player.createUser(cSocialID, cSocialType, cFullname, cUsername, cSocialRange, cMobileOS, cDeviceToken)
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      rData = {"Status" => "True"}
      self.jsonRender(rData, 'User Information Updated', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getMyProfile
  # 
  # Input: DeviceID, LangCode
  #        SocialID, SocialType, SocialRange
  #        RequestID, SessionID, Token
  #
  # Return: User's Coins, RequestID
  ###
  def getMyProfile
    if(request.post?)
      cSocialID = self.findKeyInJSON(params[:params], "SocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      
      rData = {}
      
      # find this player's highest scene number, if not, just return 0
      a = Sbdbindexing.find("ongame_" + cSocialType + "_myscene_" + cSocialID)
      arrayValue = a.arrayvalue
      
      case arrayValue.size
      when 1
        highestSceneNo = 1
      when 0
        highestSceneNo = 0
      else
        b = arrayValue[1].sort.reverse
        highestSceneNo = b[0]["sceneNo"]
      end
      
      # return this player's information
      begin
        u = Player.findUser(cSocialID, cSocialType)
        rData = {
                  "Coins" => u.coins, 
                  "RedRockets" => u.redRockets, 
                  "RWBRockets" => u.rwbRockets,
                  "HighestSceneNo" => highestSceneNo
                }
        rStatus = "100"
      rescue Exception => e
        rStatus = "101"
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(rData, 'User Profile', cRequestID, rStatus)
    end
  end
  
  
  
  
  ###
  # Method: getMyInvitedGame
  # 
  # Input: DeviceID, LangCode
  #        SocialID, SocialType, SocialRange
  #        RequestID, SessionID, Token
  #
  # Return: VideoInfoID (array)
  #         RequestID
  ###
  def getMyInvitedGame
    if(request.post?)
      cSocialID = self.findKeyInJSON(params[:params], "SocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      
      rData = []
      
      begin
        a = Sbdbindexing.find("ongame_" + cSocialType.to_s + "_myscene_" + cSocialID.to_s)
        invitedGameIDs = a.arrayvalue
        
        invitedGameIDs.each do |aGameInfo|
          gameInfo = {
            "SceneID" => aGameInfo[0]["sceneID"],
            "OwnerSocialFullname" => aGameInfo[0]["opponentSocialFullname"],
            "OwnerSocialID" => aGameInfo[0]["opponentSocialID"],
            "CreatedTime" => aGameInfo[0]["createdTime"],
            "SceneNo" => aGameInfo[0]["sceneNo"],
            "SceneStatus" => aGameInfo[0]["sceneStatus"],
            "GameID" => aGameInfo[0]["gameID"]
          }
          rData << gameInfo
        end
        
        rData = rData.reverse
      rescue Exception => e
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(rData, 'My Invited Games', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getMyCreatedGame
  # 
  # Input: DeviceID, LangCode
  #        SocialID, SocialType, SocialRange
  #        RequestID, SessionID, TokenOpponentSocialID
  #
  # Return: VideoInfoID (array)
  #         RequestID
  ###
  def getMyCreatedGame
    if(request.post?)
      cSocialID = self.findKeyInJSON(params[:params], "SocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)
      
      rData = []
      
      begin
        a = Sbdbindexing.find("ongame_" + cSocialType.to_s + "_theirscene_" + cSocialID.to_s)
        invitedGameIDs = a.arrayvalue
        
        invitedGameIDs.each do |aGameInfo|
          gameInfo = {
            "SceneID" => aGameInfo[0]["sceneID"],
            "OpponentSocialFullname" => aGameInfo[0]["opponentSocialFullname"],
            "OpponentSocialID" => aGameInfo[0]["opponentSocialID"],
            "CreatedTime" => aGameInfo[0]["createdTime"],
            "SceneNo" => aGameInfo[0]["sceneNo"],
            "SceneStatus" => aGameInfo[0]["sceneStatus"],
            "GameID" => aGameInfo[0]["gameID"]
          }
          rData << gameInfo
        end
        
        rData = rData.reverse
      rescue Exception => e
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(rData, 'My Created Games', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getMyGameHistory
  # 
  # Input: DeviceID, LangCode
  #        SocialID, SocialType, SocialRange
  #        RequestID, SessionID, Token
  #
  # Return: VideoInfoID (array)
  #         RequestID
  ###
  def getMyGameHistory
    
  end
  
  #
  # @End of FILE
  #
end
