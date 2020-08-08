class CreateUser < Service::Create
  field :name
  field :email, presence: true
  field :access_token
  field :token_id
  field :provider_id
  field :avatar_url

  def initialize(name: nil, email:, access_token:, token_id:, provider_id:, avatar_url:)
    @name = name
    @email = email
    @access_token = access_token
    @token_id = token_id
    @provider_id = provider_id
    @avatar_url = avatar_url
  end

  def perform
    if user = User.find_by_provider_id(provider_id)
      Service::Result.resolve(user)
    else
      super(User)
    end
  end
end