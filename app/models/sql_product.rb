class SqlProduct < ApplicationRecord
  include ProductValidator
  self.table_name = 'products'
end
