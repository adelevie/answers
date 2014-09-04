require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AnswersHelper. For example:
#
# describe AnswersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, :type => :helper do
  it "will see if the official_site_title is set based on secrets" do
    expect(official_site_title).to eq(Rails.application.secrets.official_site_title)
  end
  
  it "will see if the official_style_guide is set based on secrets" do
    expect(official_style_guide).to eq(Rails.application.secrets.official_style_guide)
  end
  
  it "will see if the official_city_name is set based on secrets" do
    expect(official_city_name).to eq(Rails.application.secrets.official_city_name)
  end
  
  it "will see if the official_contact_email is set based on secrets" do
    expect(official_contact_email).to eq(Rails.application.secrets.official_contact_mail)
  end
  
  it "will see if the official_government_long_url is set based on secrets" do
    expect(official_government_long_url).to eq(Rails.application.secrets.official_government_url)
  end
end
