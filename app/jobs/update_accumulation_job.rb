class UpdateAccumulationJob < ApplicationJob
  def perform
    providers = User.all
    providers.each do |provider|
      update_accumulations_for_user(user: provider)
    end
  end

  private def update_accumulations_for_user(user:)
    user.accumulations.current.each do |accumulation|
      update_accumulation(accumulation: accumulation)
    end
  end

  private def update_accumulation(accumulation:)
    if accumulation.tips.all?(&:won?)
      accumulation.update(outcome: 'won')
      Point.create!(pointable: accumulation, value: accumulation.tips.map(&:odd).reduce(:*), user: accumulation.user)
    elsif accumulation.tips.any?(&:lost?)
      accumulation.update(outcome: 'lost')
    end
  end
end