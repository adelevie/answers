require 'spec_helper'

describe'Questions', type: :feature do

  describe 'question tags' do
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }
    let(:tag) {create(:tag)}

    context 'Tag found' do

      before do
        allow(question).to receive(:answers).and_return([answer])
        allow(question).to receive(:tag_list).and_return([tag])
        allow_any_instance_of(Question).to receive(:similar).and_return([question])
        allow(Question).to receive(:find) {question}
        visit answer_path(answer.id)
      end

      subject { page }

      it { should have_link("#{tag}", href: tag_search_path(:tag => tag)) }
      it { is_expected.to have_content "More Questions on..."}
    end
  end


  describe 'similar questions' do
    let(:question_1) { create(:question) }
    let(:question_2) { create(:question) }
    let(:answer) { create(:answer) }

    context 'Similar questions listed' do
      before do
        allow_any_instance_of(Question).to receive(:similar).and_return([question_1, question_2])
        allow(Question).to receive(:find) {question_1}
        visit answer_path(answer.id)
      end

      subject { page }

      it { is_expected.to have_content "Similar Questions"}
      it { should have_link("#{question_1.text}", href: answer_path(question_1.id)) }
      it { should have_link("#{question_2.text}", href: answer_path(question_2.id)) }
    end

  end
end
