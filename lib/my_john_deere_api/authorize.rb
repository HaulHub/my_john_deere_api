class MyJohnDeereApi::Authorize
  attr_reader :request_token, :request_secret, :access_token, :access_secret, :consumer

  ##
  # Create an Authorize object.
  #
  # This is used to obtain authentication an access key/secret
  # on behalf of a user.

  def initialize
    @consumer = MyJohnDeereApi::Consumer.app_get
  end

  ##
  # Option a url which may be used to obtain a verification
  # code from the oauth server.

  def authorize_url
    return @authorize_url if defined?(@authorize_url)

    requester = consumer.get_request_token
    @request_token = requester.token
    @request_secret = requester.secret

    @authorize_url = requester.authorize_url
  end

  ##
  # Turn a verification code into access tokens. If this is
  # run from a separate process than the one that created
  # the initial RequestToken, the request token/secret
  # can be passed in.

  def verify(code, token=nil, secret=nil)
    token ||= request_token
    secret ||= request_secret

    requester = OAuth::RequestToken.new(consumer, token, secret)
    access_object = requester.get_access_token(oauth_verifier: code)
    @access_token = access_object.token
    @access_secret = access_object.secret
    nil
  end
end