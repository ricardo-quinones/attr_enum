module AttrEnum
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def attr_enum(attr_name, enums)
      # === Arguments
      # +attr_name+:: the name of the enumerated type, e.g :suit
      # +types+:: a hash of valid types, e.g. {clubs: 0, hearts: 1, diamonds: 2, spades: 3}
      # === Example
      #   class Card
      #     attr_enum :suit, {clubs: 0, hearts: 1, diamonds: 2, spades: 3}
      #   end
      # ==== Class constant
      #   Card::SUITS
      #   => {clubs: 0, hearts: 1, diamonds: 2, spades: 3}
      # ==== reader/writer attributes
      #   c = Card.new
      #   c.suit = :clubs
      #   c.suit
      #   => :clubs
      # ==== dirty attributes (attribute_was)
      #   c = Card.new
      #   c.suit = :clubs
      #   c.save
      #   c.suit = :hearts
      #   c.suit_was
      #   => :clubs
      # ==== Error handling:
      #   Card.new.suit = :jack
      #   => EnumeratedTypeError, Not a valid suit. Please assign the suit to one of the following: :clubs, :hearts, :diamonds, or :spades.

      if enums.is_a?(Hash)
        enums = enums.with_indifferent_access
      else
        raise ArgumentError, "attr_enum second argument must be a hash"
      end

      class_eval do
        unless const_defined? "#{attr_name.to_s.pluralize.upcase}"
          const_set("#{attr_name.to_s.pluralize.upcase}", enums.with_indifferent_access)
        end

        define_method "#{attr_name}" do
          enum_int = read_attribute(attr_name.to_sym)

          # Return nil if enum integer is nil
          # allows for nil values in column.
          return enum_int unless enum_int

          value = enums.key(enum_int)

          # This removes the necessity for the keys of the hash to be strings or symbols.
          # Keys could be `nil`.
          value.respond_to?(:to_sym) ? value.to_sym : value
        end

        define_method "#{attr_name}=" do |value|
          # This allows for setting the values as integers as well.
          # Mainly needed for single table inheritance models that
          # set the default type of the enum column, which will be
          # an integer.
          if value.is_a?(Fixnum)
            unless enums.values.include?(value)
              attr_int_string = enums.values.map { |s| "#{s}" }.to_sentence(last_word_connector: ', or ')
              raise EnumeratedTypeError, "That is not a valid #{attr_name} integer value. Please assign the integer value to one of the following: #{attr_int_string}."
            end
            write_attribute(attr_name.to_sym, value)
          elsif !enums[value]
            # Raise error if key not found
            attr_name_string = enums.keys.map { |s| ":#{s}" }.to_sentence(last_word_connector: ', or ')
            raise EnumeratedTypeError, "That is not a valid #{attr_name}. Please assign the #{attr_name} to one of the following: #{attr_name_string}."
          else
            write_attribute(attr_name.to_sym, enums[value])
          end
        end

        define_method "#{attr_name}_was" do
          send("#{attr_name}_changed?") ? enums.invert[changed_attributes[attr_name.to_s]].to_sym : send("#{attr_name}")
        end
      end
    end
  end
end

class EnumeratedTypeError < StandardError
end

ActiveRecord::Base.send :include, AttrEnum