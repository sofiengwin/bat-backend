module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    def self.association(name, target_type, *args, **kwargs)
      define_association_loader(name, (kwargs[:property] || name).to_s.underscore)

      field name, target_type, *args, **kwargs
    end

    def self.define_association_loader(name, association)
      # binding.pry
      klass = graphql_name.constantize # assumption: the model is named by the object type
      reflection = klass.reflect_on_association(association)
      singular = reflection.is_a?(ActiveRecord::Reflection::BelongsToReflection) ||
        reflection.is_a?(ActiveRecord::Reflection::HasOneReflection)

      define_method(name) do
        AssociationLoader.for(klass, association).load(object)
          .then { |result| singular ? result : result.sort }
      end
    end
  end
end
