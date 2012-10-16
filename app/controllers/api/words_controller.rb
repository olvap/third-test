class Api::WordsController < Api::SbController
  ###
  # Method: createWord
  # 
  # Input: 
  #
  # Return: 
  ###
  def createWord
    a = Words.new
    if (request.post?)
      a = Words.new
      
      # Insert a new Word
      a.id = "word_" + Digest::MD5.hexdigest(params[:wordName] + Time.now.to_s)
  
      a.wordName = params[:wordName]
      a.packId = params[:packId]
      a.wordCoin = params[:wordCoin]
      a.wordDesc = "Comming soon..."
      a.wordDiffLevel = params[:wordCoin]
      a.wordThumbURL = nil
      a.playedCount = 0
      a.wordIsSponsored = 0
      
      a.save
      
      # Update WordPack
      updateWordIdToWordPack('add', params[:packId], a.id)
    end
    
    # For debugging randomWordCharacters()
    #@b = Words.randomWordCharacters("Micheal Jackson")
  end
  
  
  
  
  ###
  # Method: deleteWord
  # 
  # Input: 
  #
  # Return: 
  ###
  def deleteWord
    if (request.post?)
      begin
        a = Words.find(params[:wordKey])
        a.delete
      rescue Exception => e
      end
    end
  end
  
  
  
  
  ###
  # Method: updateWordIdToWordPack
  # 
  # Input: 
  #
  # Return: 
  ###
  def updateWordIdToWordPack(method, packId, wordId)
    if(method == 'add' && packId != '' && wordId != '')
      begin
        a = Wordpacks.find(packId)
        currentWordIds = a.wordIds
        currentWordIds << wordId
        a.save
      rescue Exception => e
      end
    end
  end
end
