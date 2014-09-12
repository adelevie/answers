module AnswersGem
  class Api::V1::QuestionsController < AnswersGem::Api::V1::ApiController
    respond_to :json

    def index
      questions = ::Question.all
      render locals: {questions: questions}
    end

    def show
      question = ::Question.find(params[:id])
      render locals: {question: question}
    end
  
    def create
      question = ::Question.new(question_params)
      question.save
      render 'questions/show', locals: {question: question}
    end

    def update
      question = ::Question.find(params[:id])
      question.update(question_params)
      render 'questions/show', locals: {question: question}
    end

    def destroy
      question = ::Question.find(params[:id])
      question.destroy
      render 'questions/show', locals: {question: question}
    end

    private

      def question_params
        params.require(:question).permit(:text, :in_language)
      end
  end
end
