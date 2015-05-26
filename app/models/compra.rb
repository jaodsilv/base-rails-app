class RemocaoLocalFalecimentoValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value = "Sim")
  	unless value == "Nao"
      	record.errors[attribute] << ("fill other fields")
    end
  end
end


class Compra < ActiveRecord::Base
	belongs_to :cadastro
	has_one :urna, class_name: "ItemCompra",as: :item
	has_one :revestimento, class_name: "ItemCompra", as: :item
	has_one :tipo_sepultamento, class_name: "ItemCompra", as: :item
	has_one :transporte_carreto, class_name: "ItemCompra", as: :item
	has_one :transporte_enterro, class_name: "ItemCompra", as: :item
	has_one :sepultamento, class_name: "ItemCompra", as: :item
	has_one :outros, class_name: "ItemCompra", as: :item

	accepts_nested_attributes_for :urna
	accepts_nested_attributes_for :revestimento
	accepts_nested_attributes_for :tipo_sepultamento
	accepts_nested_attributes_for :transporte_carreto
	accepts_nested_attributes_for :transporte_enterro
	accepts_nested_attributes_for :sepultamento
	accepts_nested_attributes_for :outros

	#validates :remocao_local_falecimento
	validates :remocao_local_falecimento, presence: true, remocao_local_falecimento: true
end