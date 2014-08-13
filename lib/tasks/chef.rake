namespace :chef do
  desc "Create required files based on .example files - WARNING: This will overwrite existing config files."
  task :de_example do
    # create a var with all filenames that end in .example
    example_files = Dir["**/*.example"] << '.databag_secret.example'
    # de-example all files except the 
    example_files.each do |f|
      # make a date-stamped backup of the file if it exists
      backup(f.chomp('.example'))
      # de-example the file unless it's a data bag
      FileUtils.cp(f, f.chomp('.example')) unless f.include?('data_bags')
    end

    # alt method using system command
    # system 'for i in `find . -name "*.example"`;do cp -- "$i" "${i//.example/}";done'
  end

  desc "Create required files based on .example files - WARNING: This will overwrite existing config files."
  task :remove_backups do
    (Dir[".*.2014**"] + Dir["**/*.2014*"]).each { |f| FileUtils.rm f }
  end

  desc "Generate new data bag secret"
  task :setup_secret do
    require 'securerandom'
    backup('.databag_secret')
    File.open('.databag_secret',"w") { |file| file.puts SecureRandom.hex(64) }
  end

end

# backup file and timestamp if it exists
def backup(file)
  FileUtils.cp(file, "#{file}.#{Time.now.strftime('%Y%m%d%M%S')}") if File.exists?(file) && !file.include?('data_bags')
end
