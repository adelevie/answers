ActiveAdmin.register WebService do

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  permit_params :title, :contact_id, :status

  controller do
    def new
      @users = User.all
    end
    def edit
      @users = User.all
    end
   end

  menu :parent => "Articles"
  filter :title
  filter :tags
  filter :contact_id
  filter :status

  index do
    column "Web Service Title", :title do |article|
      link_to article.title, [:admin, article]
    end
    column :category
    column :contact
    column "Created", :created_at
    column "Author", :user do |article|
      if(article.user.try(:department))
        (article.user.try(:email) || "") + ", " + (article.user.try(:department).name || "")
      else
        (article.user.try(:email) || "")
      end
    end
    column :slug
    column "Status", :status
    actions
  end

  form :partial => "shared/admin/article_form"
end
