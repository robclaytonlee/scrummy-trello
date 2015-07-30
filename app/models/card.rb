class Card < ActiveRecord::Base
  belongs_to :board, counter_cache: true
  belongs_to :list, counter_cache: true
end
