require 'spec_helper'
require 'mastermind/code_maker'


describe Mastermind::CodeMaker do

  it 'place secret code pegs' do
    code_maker = described_class.new
    code_maker.place(["Red", "Red", "Red", "Red"])
    code_maker.secret_code.should == ["Red", "Red", "Red", "Red"]
  end

  it 'makes sure the secret code is 4' do
    code_maker = described_class.new
    lambda {code_maker.place(["Red", "Red", "Red", "Red", "Red"])}.should raise_error(Mastermind::InvalidCode, "Too many pegs")
  end

  it 'makes sure the pegs are the right colors' do
    code_maker = described_class.new
    lambda {code_maker.place(["Red", "Red", "Red", "Purple"])}.should raise_error(Mastermind::InvalidCode, "Incorrect colors")
  end

  it 'guesses 1 black match' do
    code_maker = described_class.new
    code_maker.place(["Red", "Red", "Red", "Red"])
    code_maker.receive_guess(["Red", "Green", "Yellow", "Blue"]).should == ["Black", "", "", ""]
  end

  it 'guesses 2 black match' do
    code_maker = described_class.new
    code_maker.place(["Red", "Red", "Red", "Red"])
    code_maker.receive_guess(["Red", "Red", "Yellow", "Blue"]).should == ["Black", "Black", "", ""]
  end

  it 'guesses 1 match with yellow' do
    code_maker = described_class.new
    code_maker.place(["Yellow", "Red", "Red", "Red"])
    code_maker.receive_guess(["Yellow", "Yellow", "Yellow", "Blue"]).should == ["Black", "White", "White", ""]
  end

  it 'guesses 4 match with red' do
    code_maker = described_class.new
    code_maker.place(["Red", "Red", "Red", "Red"])
    code_maker.receive_guess(["Red", "Red", "Red", "Red"]).should == ["Black", "Black", "Black", "Black"]
  end

  it 'guesses right color and wrong spot returns white' do
    code_maker = described_class.new
    code_maker.place(["Red", "Blue", "Green", "Yellow"])
    code_maker.receive_guess(["White", "Red", "White", "White"]).should == ["", "White", "", ""]
  end

end
