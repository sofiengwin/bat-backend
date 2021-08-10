class BackendSchema < GraphQL::Schema
  mutation(Mutations::Root)
  query(Queries::Root)

  use GraphQL::Batch
end
