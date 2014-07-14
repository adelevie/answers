
  #for now - will keep themes inside of normal asset pipeline, and attempt to move again later. 

  #for Answers/USCIS theme support
  Rails.application.config.assets.paths << "#{Rails.root}/app/theme/uscis/assets/stylesheets"
  #Rails.application.config.assets.paths << "theme/uscis/stylesheets"  

  #Rails.application.config.assets.precompile += %w( theme/uscis/stylesheets/theme.css )  

  Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
    Rails.application.config.assets.paths << path
  end