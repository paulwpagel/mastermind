module Mastermind

  class InvalidCode < Exception
  end

  class CodeMaker
    attr_accessor :secret_code

    COLORS = ["Red", "Yellow", "Black", "White", "Blue", "Green"]

    def place(secret_code)
      check_pegs_size secret_code
      check_colors_are_correct secret_code

      @secret_code = secret_code
    end

    def receive_guess(guess_array)
      response = []

      guess_array.each_with_index do |guess, index|
        if in_correct_position_and_color?(guess, index)
          response << "Black"
        elsif has_color?(guess)
          response << "White"
        else
          response << ""
        end
      end

      response
    end

    private

    def in_correct_position_and_color?(guess, index)
      guess == secret_code[index]
    end

    def has_color?(guess)
      secret_code.include?(guess)
    end

    def check_pegs_size(secret_code)
      raise InvalidCode.new("Too many pegs") if secret_code.size > 4
    end

    def check_colors_are_correct(secret_code)
      secret_code.each do |code|
        raise InvalidCode.new("Incorrect colors") if !COLORS.include?(code)
      end
    end


  end
end