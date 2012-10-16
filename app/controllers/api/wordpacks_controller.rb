class Api::WordpacksController < Api::SbController
  ###
  # Method: createWordPack
  # 
  # Input: 
  #
  # Return: 
  ###
  def createWordPack
    if (request.post?)
      Wordpacks.createPack(params[:packName], params[:packCoin], params[:imageName])
    end
    begin
    	a = Sbdbindexing.find("wordpackage_indexing")
      b = a.arrayvalue
      @g = []
      b.each do |v|
        f = Wordpacks.find(v)
        @g << ["name"=>f.packName, "key"=>f.id]
      end
    rescue Exception => e
    	@g = nil
    end
    
  end
end
