#class Api::V1::AnswersController < ApplicationController
class Api::V1::AnswersController < Api::V1::ApiController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer)
  end

  def edit
  end
  
  def create
    p "HAAAAAALP CREATE WAS CALLED"
    @answer = Answer.new(answer_params)
    flash[:notice] = 'Answer was successfully created.' if @answer.save
    respond_with(@answer)
  end

  def update
    flash[:notice] = 'Answer was successfully updated.' if @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy
    respond_with(@answer)
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      #params[:answer]
      #params.require(:answer).permit(:text, :in_language)
      params[:answer]
    end
end
