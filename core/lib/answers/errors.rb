module Answers

  # = Answers Errors
  #
  # Generic Answers exception class
  class AnswersError < StandardError
  end

  # Raised when an extension has not been properly defined. See the exception message for further
  # details
  class InvalidEngineError < AnswersError
  end
end
