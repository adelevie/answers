%w(core).each do |extension|
  require "answers-#{extension}"
end
