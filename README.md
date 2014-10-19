# AttrEnum

A simple and declarative way to make integer type columns used to signal state of a model/object function more like enums in code.

## Why?

Makes code more declarative and easier to understand when changing the state or type of model/object.

## Installation

Add this line to your application's Gemfile:

    gem 'attr_enum'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attr_enum

## Usage

**In your model**

    class User < ActiveRecord::Base
      attr_enum :suit, {clubs: 0, hearts: 1, diamonds: 2, spades: 3}

      ...
    end

**Example**:

    > card = Card.new(suit: :hearts)
     => #<Card id: nil, suit: 1, created_at: nil, updated_at: nil>
    >
    > card.suit
     => :hearts
    >
    > card.send(:read_attribute, :suit)
     => 1
    >
    > card.suit = :jacks
     => EnumeratedTypeError: That is not a valid suit. Please assign the suit to one of the following: :clubs, :hearts, :diamonds, or :spades.
    >
    > card.suit = -1
     => EnumeratedTypeError: That is not a valid suit integer value. Please assign the integer value to one of the following: 0, 1, 2, or 3.


## Contributing

1. Fork it ( http://github.com/ricardo-quinones/attr_enum/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

This project rocks and uses MIT-LICENSE.