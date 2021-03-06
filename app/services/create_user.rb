class CreateUser < Service::Create
  field :name
  field :email, presence: true
  field :access_token
  field :token_id
  field :provider_id
  field :avatar_url
  field :approved_provider_at

  def initialize(name: nil, email:, access_token:, token_id:, provider_id:, avatar_url:, approved_provider_at: nil)
    @name = name
    @email = email
    @access_token = access_token
    @token_id = token_id
    @provider_id = provider_id
    @avatar_url = avatar_url
    @approved_provider_at = approved_provider_at
  end

  def perform
    if user = User.find_by_provider_id(provider_id)
      Service::Result.resolve(user)
    else
      super(User)
    end
  end
end