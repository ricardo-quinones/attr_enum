require 'spec_helper'

describe Card do
  let(:card) { Card.new }

  suit_hash = {clubs: 0, hearts: 1, diamonds: 2, spades: 3}

  it "allows setting the suit via symbols" do
    card.suit = :hearts
    expect(card.suit).to eql(:hearts)
    expect(card.read_attribute(:suit)).to eql(1)
  end

  it "allows setting the suit via integers" do
    card.suit = 0
    expect(card.suit).to eql(:clubs)
  end

  it "raises an error when trying to set a non-allowed integer value" do
    expect { card.suit = -1 }.to raise_error(EnumeratedTypeError)
  end

  it "raises an error when trying to set to non-allowed enum value" do
    expect { card.suit = :jacks }.to raise_error(EnumeratedTypeError)
  end

  it "raises an error when trying to set it to nil" do
    expect { card.suit = nil }.to raise_error(EnumeratedTypeError)
  end

  it "creates a Hash constant containing the keys and values of the allowable enums" do
    expect(Card::SUITS).to eq(suit_hash.with_indifferent_access)
  end

  it "attribute_was should reference the enum, not the integer" do
    card.suit = :hearts
    card.save
    card.reload
    card.suit = :clubs
    expect(card.suit_was).to eq(:hearts)
    expect(card.suit).to eq(:clubs)
  end
end
