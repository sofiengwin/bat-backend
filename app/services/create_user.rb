class CreateUser < Service::Create
  field :name
  field :username, presence: true
  field :email, presence: true
  field :access_token
  field :token_id
  field :provider_id
  field :avatar_url

  def initialize(name: nil, username:, email:, access_token:, token_id:, provider_id:, avatar_url:)
    @name = name
    @username = username
    @email = email
    @access_token = access_token
    @token_id = token_id
    @provider_id = provider_id
    @avatar_url = avatar_url
  end

  def perform
    super(User)
  end
end