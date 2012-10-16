require "base64"

class Api::VideoController < Api::SbController
  ###
  # Method: uploadVideo
  # 
  # Input: Base64Data
  #
  # Return: VideoID
  ###
  def uploadVideo
    if (request.post?)
      cEncodedStr = self.findKeyInJSON(params[:params], "Base64Data", 2)
      encodedStr = cEncodedStr.gsub(" ", "+")
      
      # Random File Name
      intNum = [1,2,3,4,5,6,7,8,9,0]
      ranNum = intNum[rand(intNum.length)]
    
      ranFileName = "video_" + Digest::MD5.hexdigest(ranNum.to_s + Time.now.to_s)
      
      # Create and Write then Store in the tmp Directory
      tmpS3WOWZApath = File.expand_path(File.dirname(__FILE__) + "../../../../"+"/tmp/s3wowza")
      
      if(File.open(tmpS3WOWZApath + "/" + ranFileName + ".mov", 'wb') do|f|
          f.write(Base64.decode64(encodedStr))
        end
      )
      end
      
      # Upload file to S3
      local_file = tmpS3WOWZApath + "/" + ranFileName + ".mov"
      bucket = "showbucks"
      mime_type = "video/quicktime"
      s3 = AWS::S3.new
      
      b = s3.buckets[bucket]
      
      basename = File.basename(local_file)
      o = b.objects[basename]
      o.write(:file => local_file, :content_type => mime_type)

      # Store VideoID
      Videotemp.createVideoTemp(ranFileName)
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      rData = {"Status" => "True", "VideoID" => ranFileName}
      self.jsonRender(rData, 'Video ID', cRequestID, '100')
    end
  end
  
  
  
  
  ###
  # Method: getVideoURL
  # 
  # Input: VideoID, OS ( 100: iOS, 101: android)
  #
  # Return: VideoStreamUrl
  ###
  def getVideoURL
    if (request.post?)
      cVideoID = self.findKeyInJSON(params[:params], "VideoID", 2)
      cOS = self.findKeyInJSON(params[:params], "OS", 2)
      
      case cOS.to_s
      when "100"
        # We have that file stored in S3 yet?
        # Check it later!
        # Just hard-code it
        returnFileName = "http://ec2-50-112-145-58.us-west-2.compute.amazonaws.com:1935/vods3/_definst_/mp4:s3/"
        returnFileName += cVideoID + ".mov"
        returnFileName += "/playlist.m3u8"
      when "101"
        # android
        returnFileName = "rtsp://ec2-50-112-145-58.us-west-2.compute.amazonaws.com:1935/vod/_definst_/mp4:s3/"
        returnFileName += cVideoID + ".mov"
      else
        # ignore
      end
      
      # Update Video Played Count
      begin
        b = Videotemp.find(cVideoID)
        if(b.playedCount == nil || b.playedCount == '')
          playedCount = 1
        else
          playedCount = b.playedCount
          playedCount = playedCount.to_i + 1
        end
        b.playedCount = playedCount.to_i
        b.save
      rescue Exception => e
        # ignore
      end
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      rData = {"VideoStreamUrl" => returnFileName}
      self.jsonRender(rData, 'WOWZA URL', cRequestID, '100')
    end
  end


  
  
  ###
  # Method: createVideoInfo
  # 
  # Input: OwnerSocialID, OwnerSocialType, VideoID, WordID, WordPackageID
  #
  # Return: 
  ###
  def createVideoInfo
    if (request.post?)
      cOwnerSocialID = self.findKeyInJSON(params[:params], "OwnerSocialID", 2)
      cOwnerSocialType = self.findKeyInJSON(params[:params], "OwnerSocialType", 2)
      cVideoID = self.findKeyInJSON(params[:params], "VideoID", 2)
      cWordID = self.findKeyInJSON(params[:params], "WordID", 2)
      cWordPackageID = self.findKeyInJSON(params[:params], "WordPackageID", 2)
      cVideoInfoID = self.createMD5Key("videoinfo", cVideoID)
      
      # create Video Info
      Videoinfo.createVideoInformation(cVideoInfoID, cOwnerSocialID, cOwnerSocialType, cVideoID, cWordID, cWordPackageID)
      
      # Return JSON response
      cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
      rData = {"Status" => "True", "VideoInfoID" => cVideoInfoID}
      self.jsonRender(rData, 'Video Info Created', cRequestID, '100')
    end    
  end
end

