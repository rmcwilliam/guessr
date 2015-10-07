module Guessr
  class Game < ActiveRecord::Base
    belongs_to :player

    def show_progress
      if self.last_guess > self.answer
        puts "You guessed too high!"
      else
        puts "You guessed too low!"
      end
    end

    def make_guess(guess)
      self.update(last_guess: guess, turn_count: self.turn_count + 1)
    end

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
