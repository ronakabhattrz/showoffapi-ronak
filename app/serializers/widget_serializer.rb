class WidgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :kind
  has_one :user
end
