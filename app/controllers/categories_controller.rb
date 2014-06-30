
class CategoriesController < ApplicationController
  add_breadcrumb('Home', :root_url)

  def index
    def bodyclass; 'results'; end
    categories = Category.with_published_articles.by_access_count 

    add_breadcrumb 'Categories'

    respond_to do |format|
      format.html { render locals: { categories: categories } }
      format.json { render json: categories }
    end
  end

  def show
    def bodyclass; 'results'; end
    categories = Category.all
    category = categories.select {|c| c.slug == params[:id]}.first
    
    if category.nil?
    	return render(
        template: 'categories/missing', 
        locals: { categories: categories }
      )
    end

    add_breadcrumb(category.name)
    category.record_hit
    content_html = BlueCloth.new(category.name).to_html

    respond_to do |format|
      format.html { 
        render locals: { 
          category: category, 
          content_html: content_html, 
          categories: categories 
        } 
      }
      format.json { render json: category }
    end
  end
end
