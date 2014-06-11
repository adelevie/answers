require 'spec_helper'

describe Contact do
  it "is valid with a name" do
    contact = Contact.new(
        :name => 'Jeff Goldblum'
      )
    expect(contact).to be_valid
  end

  it "is valid without a name" do
    contact = Contact.new(
        :department => 'Department of Better Technology'
      )

    expect(contact.valid?).to be true
    expect(contact.errors[:name].size).to eq(0)
  end
end