class Types::CountryType < GraphQL::Schema::Object
  field :id, Integer, null: false
  field :name, String, null: false
  field :code, String, null: false
end
