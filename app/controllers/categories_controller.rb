
class CategoriesController < ApplicationController
  add_breadcrumb('Home', :root_url)

  def index
    def bodyclass; 'results'; end
    categories = Category.with_published_articles.by_access_count 

    add_breadcrumb 'Categories'
    locals = { categories: categories }
    
    respond_to do |format|
      format.html { render locals: locals }
      format.json { render json: locals }
    end
  end

  def show
    def bodyclass; 'results'; end
    categories = Category.all
    category = categories.select {|c| c.slug == params[:id]}.first
    
    if category.nil?
      locals = { categories: categories }
      respond_to do |format|
        format.html do
          return render(
            template: 'categories/missing', locals: locals
          )
        end
        format.json { render json: locals }
      end
    end

    add_breadcrumb(category.name)
    category.record_hit
    content_html = BlueCloth.new(category.name).to_html

    locals = { 
      category: category,
      content_html: content_html, 
      categories: categories 
    } 

    respond_to do |format|
      format.html do 
        render locals: locals
      end
      format.json do
        render json: locals.except(:categories) 
      end
    end
  end
end
