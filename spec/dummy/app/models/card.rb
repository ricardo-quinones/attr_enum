class Card < ActiveRecord::Base
  attr_accessible :suit

  attr_enum :suit, {clubs: 0, hearts: 1, diamonds: 2, spades: 3}
end
