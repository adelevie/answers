class Api::V1::AnswersController < Api::V1::ApiController
  respond_to :json

  def index
    answers = Answer.all
    render locals: {answers: answers}
  end

  def show
    answer = Answer.find(params[:id])
    render locals: {answer: answer}
  end
  
  def create
    answer = Answer.new(answer_params)
    answer.save
    render 'answers/show', locals: {answer: answer}
  end

  def update
    answer = Answer.find(params[:id])
    answer.update(answer_params)
    render 'answers/show', locals: {answer: answer}
  end

  def destroy
    answer = Answer.find(params[:id])
    answer.destroy
    render 'answers/show', locals: {answer: answer}
  end

  private
    def answer_params
      params.require(:answer).permit(:text, :in_language, :need_to_know, :question_id)
    end
end
