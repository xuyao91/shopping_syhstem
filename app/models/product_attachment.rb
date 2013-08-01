class ProductAttachment < Attachment
  acts_as_paranoid
  belongs_to :product, :foreign_key => :owner_id
end
