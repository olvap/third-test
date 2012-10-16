class Api::VideoinfoController < Api::SbController
  ###
  # Method: voteVideo
  #
  # Input: SocialID, SocialType, VideoID,
  #        CommentText, RatePoint
  #
  # Return: Status (true), RequestID
  ###
  def voteVideo
    mReturn = true
    if(request.post?)
      #Actioner
      cSocialID = self.findKeyInJSON(params[:params], "SocialID", 2)
      cSocialType = self.findKeyInJSON(params[:params], "SocialType", 2)

      #Video infomation
      cVideoID = self.findKeyInJSON(params[:params], "VideoID", 2)
      cCommentText = self.findKeyInJSON(params[:params], "CommentText", 2)
      cRatePoint = self.findKeyInJSON(params[:params], "RatePoint", 2)

      #Push user vote
      Videoinfovote.vote(cVideoID, cSocialID, cSocialType, cCommentText, cRatePoint.to_i)
    end

    # Return JSON response
    cRequestID = self.findKeyInJSON(params[:params], "RequestID", 1)
    rData = {"Status" => mReturn}
    self.jsonRender(rData, 'Vote video', cRequestID, '100')

  end


  #
  # @End FILE
  #
end