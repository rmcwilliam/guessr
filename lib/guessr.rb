require "guessr/version"
require "guessr/init_db"

require "guessr/player"
require "guessr/game"

require "pry"

module Guessr
  MAX_NUMBER = 1000

  class App
    def initialize
      @player = nil
      @game = nil
    end

    def prompt(message, validator)
      puts message
      response = gets.chomp
      until response =~ validator
        puts "Sorry, that is not a valid response. Try again."
        response = gets.chomp
      end
      response
    end

    def greeting
      puts "Welcome to the Number Guessing Game, Database Edition!"
      name = prompt("What is your name, player?", /^[a-z]{4,20}$/i)

      if Player.exists?(name: name)
        @player = Player.find_by(name: name)
      else
        @player = Player.create(name: name)
      end

      choose_game
    end

    def new_game
      @game = @player.games.create(answer: rand(1...MAX_NUMBER))
    end

    def choose_game
      existing_games = @player.games.where(finished: false)
      if existing_games.count.zero?
        new_game
      else
        choice = prompt("Would you like to play a (N)ew game or (R)esume an old game? (N/R)", /^[nr]$/i)
        if choice.upcase == "N"
          new_game
        else
          resume_game
        end
      end
    end

    def resume_game
      puts "Which game would you like to resume?"
      @player.games.each do |game|
        puts "ID: #{game.id}  |  Last Guess: #{game.last_guess}"
      end
      game_id = gets.chomp.to_i
      until @player.games.find_by(id: game_id)
        puts "You have to choose from the above list of games! Try again: "
        game_id = gets.chomp.to_i
      end
      @game = @player.games.find(game_id)
    end

    def take_turn
      @game.show_progress if @game.last_guess
      guess = prompt("What is your new guess? (1-1000)", /^\d{1,3}$/)
      @game.make_guess(guess.to_i)
    end

    def play_game
      until @game.win?
        take_turn
      end
    end

    def play_again?
      choice = prompt("Would you like to play again? (Y/N)", /^[yn]$/i)
      choice.upcase == "Y"
    end

    def run
      greeting
      play_game
      while play_again?
        new_game
        play_game
      end
      puts "Cool! Thanks for playing. :)"
    end
  end
end

binding.pry

app = Guessr::App.new
app.run
