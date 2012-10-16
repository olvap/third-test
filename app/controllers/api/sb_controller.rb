require "base64"

class Api::SbController < ApplicationController
  
  ###
  # Method: findKeyInJSON
  # 
  # Input: jsonStr, key, level
  #
  # Return: ValueInNeed
  ###
  def findKeyInJSON(jsonStr, key, level)
    inputParams = ActiveSupport::JSON.decode(jsonStr)
#    inputParams[key] || inputParams["params"][key]

    @ValueInNeed = nil
    inputParams = ActiveSupport::JSON.decode(jsonStr)
    
    if(level == 2)
      inputParams["Params"].each do |paramValue|
        if(paramValue[0].to_s == key.to_s)
          @ValueInNeed = paramValue[1]
          break
        end
      end
    else
      inputParams.each do |paramValue|
        if(paramValue[0].to_s == key.to_s)
          @ValueInNeed = paramValue[1]
          break
        end
      end
    end
    
    return @ValueInNeed
  end
  
  
  
  
  ###
  # Method: createMD5Key
  # 
  # Input: key, keyName
  #
  # Return: encrypted MD5 String
  ###
  def createMD5Key(key, keyName)
    return key.to_s + "_" + Digest::MD5.hexdigest(keyName.to_s + Time.now.to_s)
  end
  
  
  
  
  ###
  # Method: jsonRender
  # 
  # Input: 
  #
  # Return: 
  ###
  def jsonRender(data, message, requestID, status)
    @result = {
                "Data" => data,
                "Message" => message.to_s,
                "RequestID" => requestID.to_s,
                "Status" => status.to_s
              }
    render json: @result
  end
  
  #
  # @End FILE
  #
end

