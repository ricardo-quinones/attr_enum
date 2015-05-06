class WithNil < ActiveRecord::Base
  attr_accessible :category

  CATEGORY_HASH = { nil => 0, not_nil: 1 }

  attr_enum :category, CATEGORY_HASH
end
