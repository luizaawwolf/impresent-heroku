Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'NCqWm_1fBfgx4TeQI-QZoJEvsbqg2the',
    'ptVrAX6mS6wLRqLUmL8FZ8KCwxzQfomSCKE53Gt2Go-kr5v-_rxhHMIRe5cWDP6P',
    'restless-haze-0422.auth0.com',
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid email profile'
    }
  )
end