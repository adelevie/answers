module Answers
  class QuestionsController < Answers::ApplicationController
    respond_to :html

    add_breadcrumb "Home", :answers_path

    def index
      add_breadcrumb "Answers", answers.answers_path
      
      @questions = Question.all
      respond_with(@questions)
    end

    def show
      question = Question.find(params[:id])
      add_breadcrumb "Answers", answers.answers_path
      add_breadcrumb question.text, answers.answer_path(question)

      render locals: { question: question, similar_questions: question.similar(limit:3) }
    end

    private

      def question_params
        #params[:question]
        #params.require(:question).permit(:text, :in_language)
        params[:question]
      end
    end
end
