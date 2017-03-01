class User < ActiveRecord::Base
  def self.create_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save! if user.is_member?
    end
  end

  def is_member?
      #authenticate against FB API
      groupID = 232092133503945; #BWERP
      response = Unirest.get "https://graph.facebook.com/v2.8/#{groupID}/members?fields=id&limit=5000&access_token=#{oauth_token}"
      response.body["data"].any? { |member| member[:id] = uid }
  end

end
