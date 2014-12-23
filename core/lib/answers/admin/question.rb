module Answers
  ActiveAdmin.register Question, as: 'Question' do
    permit_params :text, :in_language, :tags, :tag_list
    
    #override questions controller strong params until implemented.
    controller do
      def permitted_params
        params.permit!
      end
    end

    form do |f|
      f.inputs "Details", :multipart => true do
        f.input :text
        f.input :in_language
        f.input :tag_list,  :as => :select,
                            :multiple => true,
                            :collection => ActsAsTaggableOn::Tag.all.map(&:name)
        f.actions
      end
    end

    index do
      column :text
      column :in_language
      column :tag_list
      column :created_at
      column :updated_at
      actions
    end

    show do
      attributes_table do
        row :text
        row :in_language
        row :tag_list
        row :created_at
        row :updated_at
      end
      active_admin_comments
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