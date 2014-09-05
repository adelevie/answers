require 'spec_helper'

describe'Questions', type: :feature do

  describe 'question tags', vcr: true do
    let(:answer) { create(:answer) }
    let(:question) { create(:question) }
    let(:tag) {create(:tag)}

    context 'Tag found' do

      before do
        allow(Question).to receive(:find) {question}
        allow(question).to receive(:answers).and_return([answer])
        allow(question).to receive(:tag_list).and_return([tag])
        visit answer_path(answer.id)
      end

      subject { page }

      it { should have_link("#{tag}", href: tag_search_path(:tag => tag)) }
      it { is_expected.to have_content "More Questions on..."}
    end
  end

end
