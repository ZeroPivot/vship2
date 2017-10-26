require "rubygems"
require "rubygame"
include Rubygame
require "lib/controller.rb"
require "lib/setup.rb"
require "lib/player.rb"


TTF.setup #setup true-type font manipulation

setup = Setup.new()
setup.run()