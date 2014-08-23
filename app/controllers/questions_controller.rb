class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]
  respond_to :html

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      #params[:question]
      #params.require(:question).permit(:text, :in_language)
      params[:question]
    end
end
