module Answers
  ActiveAdmin.register Answer do
    permit_params :question_id, :text, :in_language, :need_to_know
    
    form do |f|
      f.inputs "Details" do
        f.input :question, :as => :select, :collection => Question.all.map {|q| [q.text, q.id]}, :include_blank => false
        f.input :need_to_know
        f.input :text
        f.input :in_language
      end
      f.actions
    end
    
    # See permitted parameters documentation:
    # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
    #
    # permit_params :list, :of, :attributes, :on, :model
    #
    # or
    #
    # permit_params do
    #  permitted = [:permitted, :attributes]
    #  permitted << :other if resource.something?
    #  permitted
    # end
    
  end
end