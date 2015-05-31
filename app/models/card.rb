class Card < ActiveRecord::Base
  belongs_to :board, counter_cache: true
end
