ActiveAdmin.register Accumulation do
  permit_params :outcome,
    :odd,
    :rating,
    tips_attributes: [:id, :outcome, :_destroy]

  form do |f|
    f.inputs
    f.inputs do
      f.has_many :tips do |t|
        # t.input :odd
      end
    end
    f.actions
  end
end