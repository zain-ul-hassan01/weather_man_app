# frozen_string_literal: true

# Module to find monthdata.
module Monthvalid
  def monthinput(path, filename, year)
    puts 'Enter the month of your concern.'
    month = gets.chomp
    maxtemp = []
    mintemp = []
    humidity = []
    begin
      IO.foreach("#{path}/#{filename}/#{filename}_weather_#{year}_#{month}.txt") do |block|
        if /\A#{year}/.match?(block)
          block = block.split(',')
          maxtemp.push(block[1])
          mintemp.push(block[3])
          humidity.push(block[8])
        end
      end
    rescue e
      puts e
      exit
    end
    [maxtemp, mintemp, humidity]
  end

  def part2(maxtemp, mintemp, humidity)
    maxsum = maxtemp.reduce { |sum, num| sum + num }
    minsum = mintemp.reduce { |sum, num| sum + num }
    meanhumidity = humidity.reduce { |sum, num| sum + num }
    averagemax = maxsum / maxtemp.length
    averagemin = minsum / mintemp.length
    averagehumidity = meanhumidity / humidity.length
    puts "Highest Average: #{averagemax}C"
    puts "Lowest Average: #{averagemin}C"
    puts "Average Humidity: #{averagehumidity}%"
  end

  def part3(maxtemp, mintemp)
    ind = 0
    maxtemp.zip(mintemp).each do |max1, min1|
      ind += 1
      print ind.to_s
      max1.times do
        print '+'.red
      end
      puts "#{max1}C"
      print ind.to_s
      min1.times do
        print '+'.blue
      end
      puts "#{min1}C"
    end
  end

  def part4(maxtemp, mintemp)
    ind = 0
    maxtemp.zip(mintemp).each do |max1, min1|
      ind += 1
      print ind.to_s
      min1.times do
        print '+'.blue
      end
      max1.times do
        print '+'.red
      end
      puts "#{min1}C - #{max1}C"
    end
  end
end
