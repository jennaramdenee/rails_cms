class Collection < ApplicationRecord
  attr_accessor :title
  has_many :articles
end
