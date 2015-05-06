require 'spec_helper'

describe WithNil do
  let(:with_nil_object) { WithNil.new }

  category_hash = WithNil::CATEGORY_HASH

  it "allows setting the category as nil" do
    with_nil_object.category = nil
    expect(with_nil_object.read_attribute(:category)).to eq(category_hash[nil])
    expect(with_nil_object.category).to eq(nil)
  end
end