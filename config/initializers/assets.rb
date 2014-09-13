
  #for now - will keep themes inside of normal asset pipeline, and attempt to move again later. 

  #for theme support uncomment one of below lines
  # Rails.application.config.assets.paths << "#{Rails.root}/app/theme/minimal/assets/stylesheets"
  # Rails.application.config.assets.paths << "theme/uscis/stylesheets"

  #Rails.application.config.assets.precompile += %w( theme/uscis/stylesheets/theme.css )  

  Dir.glob("#{Rails.root}/app/assets/images/**/").each do |path|
    Rails.application.config.assets.paths << path
  end

  #added this to get style-guide to work. Not sure why we need it, but oughtn't do any harm
  # d = Dir.new("#{Rails.root}/app/assets/images/theme/minimal/")
  # d.each do |path|
  #   Rails.logger.info "adding file #{path}"
  #   Rails.application.config.assets.precompile << path
  # end