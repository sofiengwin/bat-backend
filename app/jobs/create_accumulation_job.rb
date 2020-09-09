class CreateAccumulationJob < ApplicationJob
  def perform
    providers = User.where.not(approved_provider_at: nil)

    providers.each do |provider|
      create_accumulation(user: provider)
    end
  end

  private def create_accumulation(user:)
    tips = user.tips.current

    return if tips.count < 2 || user.accumulations.current.exist?

    CreateAccumulation.perform(tips: tips, user_id: user.id, approved_at: Time.now)
  end
end