require 'yaml'

namespace 'import' do
  desc "Imports Oakland Answers data from oakland_answers.yml"
  task :oakland => :environment do

    puts "Loading Answers data from lib/tasks/oakland_answers.yml"
    @questions = YAML::load_file('lib/tasks/oakland_answers.yml')

    @questions.each do |q|
      new_q = Question.create(
          :text => q['title'],
          :in_language => "en"
        )

      new_a = Answer.create(
          :question_id => new_q.id,
          :text => q['content_main'],
          :need_to_know => q['content_main_extra'] || q['content_need_to_know'],
          :in_language => "en"
        )

      puts "Created new Q/A: #{new_q.text}\n"
    end
    puts "\n\n"
    puts "Imported #{@questions.size} questions"
  end
end
