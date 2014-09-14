module Answers
	class HomeController < Answers::ApplicationController
	 # caches_page :index
	  add_breadcrumb "Home", :root_url

	  def index
	    render locals: { 
	      tags_with_questions: Question.tags_with_questions
	    }
	  end

	 def about
	   add_breadcrumb "About"
	 end

	end
end