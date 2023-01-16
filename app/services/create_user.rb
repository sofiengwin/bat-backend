class CreateUser < Service::Create
  field :name
  field :username
  field :provider_id, presence: true
  field :approved_provider_at
  field :email
  field :avatar_url

  def initialize(name:, provider_id:, approved_provider_at:, email:, avatar_url:)
    @name = name
    @username = name
    @provider_id = provider_id
    @approved_provider_at = approved_provider_at
    @email = email
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
