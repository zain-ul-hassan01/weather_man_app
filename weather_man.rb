# frozen_string_literal: true

require 'colorize'
require_relative './module_valid'
require_relative './module_year'
require_relative './module_month'

# Weatherman Application
class WeatherMan
  include Validation
  include Yearvalid
  include Monthvalid
  region = WeatherMan.new.inputvalidation
  puts 'Enter the year of your concern.'
  year = gets.chomp
  path = Dir.pwd
  hashyear = {}
  maxhash, minhash, maxhumidity1, newarr, finarr, maxtemp, mintemp, humidity, arrformax, arrformin, arrforhum = Array.new(11) { [] }
  months = %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  # ################ Opening File in directory according to user input####################################
  Dir.foreach(path) do |filename|
    next if ['.', '..'].include?(filename)

    if region == filename
      months.each do |month|
        # ############################Opening files Month by month in directory and storing data in array###############
        newarr = WeatherMan.new.openfile(path, filename, year, month)
        if newarr.length.positive?
          finarr.push(newarr)
          newarr = []
        end
      end
      ind = 0
      months.each do |month|
        hashyear[month.to_s] = finarr[ind]
        ind += 1
      end
      maxhash, minhash, maxhumidity1 = WeatherMan.new.populatefromhash(hashyear, maxhash, minhash, maxhumidity1)

      arrformax = WeatherMan.new.formax(maxhash, arrformax)
      arrformin = WeatherMan.new.formin(minhash, arrformin)
      arrforhum = WeatherMan.new.formax(maxhumidity1, arrforhum)

      WeatherMan.new.highestyear(arrformax, months)
      WeatherMan.new.lowestyear(arrformin, months)
      WeatherMan.new.humidityyear(arrforhum, months)
      # ###################### Taking input for month to jump onto next portion of task (Part 2,3,4)###################
      maxtemp, mintemp, humidity = WeatherMan.new.monthinput(path, filename, year)
    end
  end

  maxtemp = maxtemp.map(&:to_i)
  mintemp = mintemp.map(&:to_i)
  humidity = humidity.map(&:to_i)
  puts "MaxTemp: #{maxtemp.max}C MinTemp: #{mintemp.min}C"

  # ################ Part 2 of weather man printing averages of month temperature.#####################################

  WeatherMan.new.part2(maxtemp, mintemp, humidity)

  # ############### Part 3 of weather man printing days of month with their highest and lowest temperature.############
  WeatherMan.new.part3(maxtemp, mintemp)
  # ##################################Part 4 Bonus Task Print Highest and lowest on one bar line.######################

  WeatherMan.new.part4(maxtemp, mintemp)
end
