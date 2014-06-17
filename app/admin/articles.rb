ActiveAdmin.register Article do

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  permit_params :title, :content, :content_md, :content_main, :content_main_extra,
    :content_need_to_know, :render_markdown, :preview, :contact_id, :tags,
    :is_published, :slugs, :category_id, :updated_at, :created_at, :author_pic,
    :author_pic_file_name, :author_pic_content_type, :author_pic_file_size,
    :author_pic_updated_at, :author_name, :author_link, :type, :service_url, :user_id, :status,
    :keyword_ids, :title_es, :preview_es, :content_main_es,
    :title_cn, :preview_cn, :content_main_cn

  filter :title
  filter :tags
  filter :contact_id
  filter :status

  index do
    column "Article Title", :title do |article|
      title = ""
      if article.title.present?
        title = article.title
      elsif article.title_es.present?
        title = article.title_es
      elsif article.title_cn.present?
        title = article.title_cn
      end
      link_to title, [:admin, article]
    end
    column :category
    column :content_type
    column :type
    column "Created", :created_at
    column "Author name", :author_name
    column "Status", :status
    actions
  end

  form do |f|
    f.inputs "Article Details" do
      if params[:action] == 'new'
        f.input :user_id, :as => :hidden, :input_html => { :value => current_user.id }
      end
      if current_user.is_writer?
        f.input :status,  :as => :select, :collection => ["Draft", "Pending Review"]
      else
        f.input :status,  :as => :select, :collection => ["Draft", "Pending Review", "Published"]
      end
      f.input :title
      f.input :content, :input_html => {:class => 'editor'}
      f.input :preview
      f.input :category
      f.input :type,  :as => :select, :collection => ["QuickAnswer", "WebService", "Guide"]
      f.input :contact
      f.input :service_url
      f.input :tags, :as => :string
      f.input :author_link
      f.input :author_pic
      f.input :author_name
    end
    f.actions
  end
end
