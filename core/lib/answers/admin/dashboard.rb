module Answers
  # def recent_articles_table
  #   table_for Article.order("created_at DESC").limit(5), title: "My Title" do
  #     column "Article Title", :title do |article|
  #       title = ""
  #       if article.title.present?
  #         title = article.title
  #       elsif article.title_es.present?
  #         title = article.title_es
  #       elsif article.title_cn.present?
  #         title = article.title_cn
  #       end
  #       link_to title, [:admin, article]
  #     end
  #     column "Author", :user do |article|
  #       article.user.try(:email)
  #     end
  #     column "Status", :status
  #     column "Date Created", :created_at
  #     column "Date Updated", :updated_at
  #   end
  # end

  # def your_articles_table
  #   table_for current_user.articles.order("created_at DESC") do
  #     column "Article Title", :title do |article|
  #       link_to article.title, [:admin, article]
  #     end
  #     column "Author", :user do |article|
  #       article.user.try(:email)
  #     end
  #     column "Status", :status
  #     column "Date Created", :created_at
  #   end
  # end



  ActiveAdmin.register_page "Dashboard" do
    menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

    content title: proc{ I18n.t("active_admin.dashboard") } do
      div class: "blank_slate_container", id: "dashboard_default_message" do
        span class: "blank_slate" do
          span I18n.t("active_admin.dashboard_welcome.welcome")
          small I18n.t("active_admin.dashboard_welcome.call_to_action")
        end
      end
    end

    # content do
      
    #   # TODO: replace with Question and Answer
    #   # if current_user.is_admin? || current_user.is_editor?
    #   #  panel "Recent Articles" do recent_articles_table end
    #   # end
      
    #   # if current_user.is_writer?
    #   #  panel "Your Articles" do your_articles_table end
    #   # end
      
    #   if current_user.is_admin?
    #     panel "Users" do
    #       table_for User.order("created_at DESC").limit(5) do
    #         column "User", :email do |user|
    #           link_to user.email, [:admin, user]
    #         end
    #       end

    #     end
    #   end

    # end
  end
end