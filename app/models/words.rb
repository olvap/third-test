require 'couchbase/model'

class Words < Couchbase::Model
  
  include ActiveModel::Conversion
  extend ActiveModel::Callbacks
  extend ActiveModel::Naming

  attribute :wordName
  attribute :packId
  attribute :wordCoin
  attribute :wordDesc
  attribute :wordDiffLevel
  attribute :wordThumbURL
  attribute :wordIsSponsored
  attribute :playedCount
  attribute :created_at, :default => lambda{ Time.zone.now }
  
  def save
    super
  end 
  



  ###
  # Method: randomWordCharacters
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.randomWordCharacters(word)
    chars = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M"]
    
    word = word.sub(" ", "").upcase
    word = word.split(%r{\s*})
    
    # Goal? Device's screens will show up minimum of 2 rows
    # There are fixed number of 7 characters per row
    
    wordLength = word.length
    
    chk = wordLength.divmod(7)
    
    if(wordLength <= 14)
      neededNumber = 14 - wordLength
    else
      if(chk[1] != 0)
        neededNumber = 7 - chk[1]
      else
        neededNumber = 0
      end
    end
    
    (1..neededNumber).each do |i|
      ranChar = chars[rand(chars.length)]
      word << ranChar
    end
        
    return word.shuffle
  end
  
  
  
  
  ###
  # Method: getWordIDFromGame
  # 
  # Input: 
  #
  # Return: 
  ###
  def self.getWordIDFromGame(gameID)
    begin
      a = Game.find(gameID)
      videoInfoID = a.videoInfoID
      videoInfoDetail = Videoinfo.find(videoInfoID)
      return videoInfoDetail.wordID
    rescue Exception => e
      return nil
    end
  end
  
end
