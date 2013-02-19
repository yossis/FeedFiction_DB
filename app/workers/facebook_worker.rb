class FacebookWorker
  include Sidekiq::Worker
  
  def perform(id, key, url)
   user = User.find(id)
   user.facebook.put_connections("me" , "feedfiction:#{key}" , story: url)
  end
end