class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]
  respond_to :html

  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "Answers", answers_path
    
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    add_breadcrumb "Answers", answers_path
    add_breadcrumb @question.text, answer_path(@question)
    
    render locals: { question: @question }
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
