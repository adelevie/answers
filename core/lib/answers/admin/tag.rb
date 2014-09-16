module Answers
	ActiveAdmin.register ActsAsTaggableOn::Tag, as: 'Tag' do
	  permit_params :name, :taggings_count
	  
	   index do
	    column :id
	    column :name
	    column :taggings_count
	    actions
	  end
	end
end