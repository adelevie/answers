ActiveAdmin.register Guide do
  controller do
    before_filter :set_users
    before_filter :set_article

    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end

    def set_users
      @users ||= User.all
    end

    def set_article
      @article = @guide || Guide.new
    end
  end

  permit_params :title, :status, :user_id, :category_id, :preview,  :tags, :author_name

  menu :parent => "Articles"

  filter :title
  filter :tags
  filter :contact_id
  filter :status

  index do
    column "Guide Title", :title do |guide|
      link_to guide.title, [:admin, guide]
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
  
  form partial: "shared/admin/article_form"

  show do |guide|
    attributes_table do
      row :title
      row :content
      row :preview
      row :category
      row :contact
      row :slug
      row :created_at
      row :updated_at
      row :status
      table_for guide.guide_steps do
        column "Guide Steps" do |step|
          link_to step.step.to_s << ". " << step.title, admin_guide_step_path(step)
        end
      end
    end
  end
end
