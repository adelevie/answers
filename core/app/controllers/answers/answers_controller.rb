module Answers
  class AnswersController < ActionController::Base
  before_action :set_answer, only: [:show]
  respond_to :html

  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      #params.require(:user).permit(:username, :email, :password, :salt, :encrypted_password)
      #params[:answer]
      params.require(:answer).permit(:text, :in_language, :need_to_know)
    end
  end
end
