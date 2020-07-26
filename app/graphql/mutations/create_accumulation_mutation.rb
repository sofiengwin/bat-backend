module Mutations
  class CreateAccumulationMutation < BaseMutation
    argument :userId, ID, required: true
    argument :tips, [ID], required: true

    field :accumulation, Types::AccumulationType, null: true
    field :errors, [Types::ServiceErrorType], null: true

    def resolve(**inputs)
      return { errors: [ServiceError.new(:admin, 'notAuthorized')] } unless context[:current_user]
  
      result = CreateAccumulation.perform(
        user_id: inputs[:userId],
        tips: inputs[:tips],
      )

      if result.succeeded?
        { accumulation: result.value }
      else
        { errors: ServiceError.from(result.reason) }
      end
    end
  end
end