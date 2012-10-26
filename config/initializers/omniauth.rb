Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, CONFIG[:facebook_id], CONFIG[:facebook_secret], {:client_options => {:ssl => {:ca_path => "/usr/lib/ssl/certs"}}}
	provider :twitter, CONFIG[:twitter_key], CONFIG[:twitter_secret]
	provider :linkedin, CONFIG[:API_Key], CONFIG[:Secret_Key]
end