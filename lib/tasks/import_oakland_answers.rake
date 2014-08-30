require 'yaml'

namespace 'import' do
  desc "Imports Oakland Answers data from oakland_answers.yml"
  task :oakland => :environment do

    puts "Loading Answers data from spec/fixtures/oakland_answers.yml"
    @questions = YAML::load_file('spec/fixtures/oakland_answers.yml')

    tags = %w[recycling employment trash pets education transportation]

    @questions.each do |q|
      new_q = Question.new(
          :text => q['title'],
          :in_language => "en"
        )
      
      new_q.tag_list.add(tags.sample)
      new_q.save
 
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
