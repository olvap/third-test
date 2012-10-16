class Api::WordController < Api::SbController
  ###
  # Method: getWordPackage
  # 
  # Input: 
  #
  # Return: 
  ###
  def getWordPackage
    if(request.post?)
      begin
        Sbdbindexing.find('wordpackage_indexing_cache')
      rescue Exception => e
        Sbdbindexing.newIndex('wordpackage_indexing_cache')
      end
      
      a = Sbdbindexing.find('wordpackage_indexing_cache')
      if(a.arrayvalue == [])
        a.arrayvalue = getRawWordList
        a.save
      else
        result = a.arrayvalue
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      self.jsonRender(result, 'Word Package List', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getRawWordList
  # 
  # Input: 
  #
  # Return: 
  ###
  def getRawWordList
    result = []
    
    sA = Sbdbindexing.find('wordpackage_indexing')
    @listCurrentWordPack = sA.arrayvalue
    @listCurrentWordPack.each do |wordPackId|
      a = Wordpacks.find(wordPackId)
      packName = a.packName
      packCoin = a.packCoin
      imageName = a.imageName
      packId = a.id
      
      # get Words from PackId
      @wordIds = a.wordIds
      aWords = []
      if(@wordIds.to_s != '')
        @wordIds.each do |wordId|
          begin
            b = Words.find(wordId)
            wordInfo = {
              'Brief' => b.wordDesc,
              'DifficultLevel' => b.wordDiffLevel,
              'Thumbnailurl' => b.wordThumbURL,
              'Word' => b.wordName,
              'ID' => b.id,
              'Coins' => b.wordCoin,
              'Sponsored' => b.wordIsSponsored
            }
            aWords << wordInfo
          rescue Exception => e
          end
        end
      end
      
      # 
      packInfo = {
        'ID' => packId,
        'Name' => packName,
        'Coins' => packCoin,
        'Image' => imageName,
        'Words' => aWords
      }
      result << packInfo
    end
    
    return result
  end
end
