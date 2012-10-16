require 'couchbase/model'

class Player < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming
  
  attribute :fullname
  attribute :username
  attribute :socialID
  attribute :socialType
  attribute :follower
  attribute :following
  attribute :coins
  attribute :redRockets
  attribute :rwbRockets
  attribute :mobileOS
  attribute :deviceToken
  attribute :created_at, :default => lambda{ Time.zone.now }
  

  #esto no hace nada, debe estar para hacer un before o afte validation.
  def save
    super
  end
  
  ###
  # Method: findUser 
  # 
  # Input: socialID, socialType
  #
  # Return: Status (true), RequestID
  ###
  def self.findUser(socialID, socialType)
    a = "user_" + socialType.to_s + "_" + socialID.to_s
    begin
      return Player.find(a)
    rescue Exception => e
      return nil
    end
  end
  
  
  
  
  ###
  # Method: updatePlayerCoins 
  # 
  # Input: winnerID, loserID, socialType, coins
  #
  # Return: true
  ###
  def self.updatePlayerCoins(winnerID, loserID, socialType, coins)
    # esto deberia se 2 metodos
    begin
      #no deberia usar el metodo que usó antes? esto no es dry
      a = Player.find("user_" + socialType.to_s + "_" + winnerID.to_s)
      aCurrentCoins = a.coins
      a.coins = aCurrentCoins.to_i + coins.to_i
      a.save
      
      b = Player.find("user_" + socialType.to_s + "_" + loserID.to_s)
      bCurrentCoins = b.coins
      if(aCurrentCoins.to_i > coins.to_i)
        b.coins = aCurrentCoins.to_i - coins.to_i
      else
        b.coins = 0
      end
      b.save

    #rescata exceptiones pero no hace nada
    rescue Exception => e
      
    end
  end
  
  
  
  
  ###
  # Method: addPlayerCoins 
  # 
  # Input: winnerID, loserID, socialType, coins
  #
  # Return: true
  ###
  def self.addPlayerCoins(socialID, socialType, coins)
    #mismos errores que antes
    begin
      a = Player.find("user_" + socialType.to_s + "_" + socialID.to_s)
      aCurrentCoins = a.coins
      a.coins = aCurrentCoins.to_i + coins.to_i
      a.save
    rescue Exception => e
      
    end
  end
  
  
  
  
  ###
  # Method: updatePlayerRockets 
  # 
  # Input: playerID, socialType, redRocket, rwbRocket
  #
  # Return: true
  ###
  def self.updatePlayerRockets(playerID, socialType, redRocket, rwbRocket)
    begin
      a = Player.find("user_" + socialType.to_s + "_" + playerID.to_s)
      a.redRockets = redRocket.to_i
      a.rwbRockets = rwbRocket.to_i
      a.save
    rescue Exception => e
      
    end
  end
  
  
  
  
  ###
  # Method: updateTop100Player
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.updateTop100Player
    cSocialType = '100'
    thisKeyName = "top_100_players_" + cSocialType.to_s
    
    # Check if we have index for top 100 player
    begin
      a = Sbdbindexing.find(thisKeyName)
    rescue Exception => e
      Sbdbindexing.newIndex(thisKeyName)
      a = Sbdbindexing.find(thisKeyName)
    end
      
  end
  
  
  
  
  ###
  # Method: createUser 
  # 
  # Input: socialID, socialType, fullname, username, socialRange, mobileOS
  #
  # Return: true
  ###

  #los metodos create y update no deberían ser con parametros.
  def self.createUser(socialID, socialType, fullname, username, socialRange, mobileOS, deviceToken)
    strSocialType = "user_" + socialType.to_s
    tmpID = strSocialType + "_" + socialID.to_s
    begin
      Player.find(tmpID)
    rescue Exception => e
      # Let's create his account
      # debería poner las cosas en hashes
      cUser = Player.new
      cUser.id = tmpID
      cUser.fullname = fullname.to_s
      cUser.username = username.to_s
      cUser.socialID = socialID.to_s
      cUser.socialType = socialType.to_s
      cUser.mobileOS = mobileOS.to_s
      cUser.follower = []
      cUser.following = []
      cUser.coins = 100
      cUser.redRockets = 10
      cUser.rwbRockets = 5
      cUser.deviceToken = deviceToken.to_s
      cUser.save
      
      # Create key user_{socialtype}_createdgame_{socialID}
      Sbdbindexing.newIndex(strSocialType + "_createdgame_" + socialID.to_s)

      # Create key user_{socialtype}_invitedgame_{socialID}
      Sbdbindexing.newIndex(strSocialType + "_invitedgame_" + socialID.to_s)
      
      # Add to user_{socialtype}_indexing_{3}
      Sbdbindexing.addToIndex(strSocialType + "_indexing_" + socialRange.to_s, tmpID)
      
      # Add to user_{socialtype}_indexing
      Sbdbindexing.addToIndex(strSocialType + "_indexing", strSocialType + "_indexing_" + socialRange.to_s)
      
      # Create On Playing Game indexing
      Sbdbindexing.newIndex("ongame_" + socialType.to_s + "_myscene_" + socialID.to_s)
      Sbdbindexing.newIndex("ongame_" + socialType.to_s + "_" + socialID.to_s + "_indexing")
    end
  end
  
  #
  # @End FILE
  #
end
