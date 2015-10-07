module Guessr
  class Player < ActiveRecord::Base
    has_many :games
  end
end
