require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @start_time = Time.now
    @letters = []
    10.times { @letters << ('A'..'Z').to_a[rand(26)] }
  end
  def score
    @message =""
    end_time = Time.now
    attempt = params[:answer]
    grid = params.keys[1].upcase.chars
    grid_line = ""
    grid.each {|letter| grid_line += "#{letter}, "}
    start_time = params.values[1].to_datetime
    if !(attempt.upcase.chars - grid).empty?
      @message = "Sorry but #{attempt} can' be built out of #{grid_line}"
    elsif (grid - (grid - attempt.upcase.chars)).length < attempt.chars.length
      @message = "Your overused letters, so not in the grid, no point."
    else
    result = JSON.parse(URI.parse("https://dictionary.lewagon.com/#{attempt}").read)
      if result["found"]
        session[:score] += attempt.length / (end_time - start_time).to_f
        @message = "Well done! #{attempt} is a valid word! #{attempt.length / (end_time - start_time).to_f} points. #{session[:score]} in total."
      else
        @message = "#{attempt} is not an english word, no point."
      end
    end
  end
end
