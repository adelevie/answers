# class Api::V1::QuestionsController < ApplicationController
class Api::V1::QuestionsController < Api::V1::ApiController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def edit
  end
  
  def create
    @question = Question.new(question_params)
    flash[:notice] = 'Question was successfully created.' if @question.save
    respond_with(@question)
  end

  def update
    flash[:notice] = 'Question was successfully updated.' if @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    @question.destroy
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
