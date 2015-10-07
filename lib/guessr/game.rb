module Guessr
  class Game < ActiveRecord::Base
    belongs_to :player

    def finished?
      self.answer == self.last_guess
    end

    def score
      if self.turn_count < 10
        100 - (10 * self.turn_count)
      else
        0
      end
    end
  end
end
