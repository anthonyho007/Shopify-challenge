class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total
  has_many :lineitems, serializer: LineitemsSerializer
end
