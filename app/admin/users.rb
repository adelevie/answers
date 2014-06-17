ActiveAdmin.register User do

  controller do
    before_filter :check_access, :only => [:show, :edit, :update, :destroy]

    private

    def update_resource(object, attributes)
      if current_admin_user

      end
      attributes.delete_if do |k,v|
        [:is_admin, :is_editor, :is_writer].include?(k) and !current_admin_user?
      end
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end

    def check_access
      correct_user? unless current_admin_user
    end
  end

  permit_params :is_admin, :is_editor, :is_writer, :department, :email, :password, :password_confirmation

  menu :if => proc{ current_user.is_admin? || current_user.is_editor? }, :label => 'Users'

  index do
    column :email
    column :is_admin
    column :is_editor
    column :is_writer
    column :department
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :department
    end
    if current_admin_user
      f.inputs "Type of User" do
        f.input :is_admin,   :label => "Administrator"
        f.input :is_editor,  :label => "Editor"
        f.input :is_writer,  :label => "Writer"
      end
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :email
      row :is_editor
      row :is_writer
      row :is_admin
      row :created_at
      row :updated_at
    end
  end

end
