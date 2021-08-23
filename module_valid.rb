# frozen_string_literal: true

# Module for opening file and other methods.
module Validation
  def inpvalidation
    puts 'Enter the region of your concern.'
    while region = gets.chomp
      case region
      when 'Dubai'
        region = 'Dubai'
        break
      when 'Lahore'
        region = 'lahore'
        break
      when 'Murree'
        region = 'Murree'
        break
      else
        puts 'Please Enter a valid City'
      end
    end
    region
  end

  def openfile(path, filename, year, mon)
    newarr = []
    begin
      IO.foreach("#{path}/#{filename}/#{filename}_weather_#{year}_#{mon}.txt") do |data|
        if /\A#{year}/.match?(data)
          data = data.split(',')
          newarr.push(data) if data.any?
        end
      end
    rescue e
      puts e
      exit
    end
    newarr
  end

  def populatefromhash(hashyear, maxhash, minhash, maxhumidity1)
    maxtemphash = []
    mintemphash = []
    maxhumidity = []
    hashyear.each do |_key, value|
      begin
        value.each do |val|
          maxtemphash.push(val[1].to_i)
          mintemphash.push(val[3].to_i)
          maxhumidity.push(val[7].to_i)
        end
      rescue e
        puts e
        exit
      end
      maxhash.push(maxtemphash)
      minhash.push(mintemphash)
      maxhumidity1.push(maxhumidity)
      maxtemphash = []
      mintemphash = []
      maxhumidity = []
    end
    [maxhash, minhash, maxhumidity1]
  end

  def formax(arr, arrformax, key = -1)
    temp = []
    arr.each do |value|
      key += 1
      el = value.index(value.max)
      temp.push(key)
      temp.push(value.max)
      temp.push(el)
      arrformax.push(temp)
      temp = []
    end
    arrformax
  end

  def formin(arr, arrformin, key = -1)
    temp = []
    arr.each do |value|
      key += 1
      el = value.index(value.min)
      temp.push(key)
      temp.push(value.min)
      temp.push(el)
      arrformin.push(temp)
      temp = []
    end
    arrformin
  end

  def findarr(arr1, max)
    temp = []
    arr1.each do |arr|
      temp = arr if arr.find { |el| el == max } != nil
    end
    temp
  end
end

# Module to find Year data.
module Yearvalid
  def highestyear(arrformax, months)
    values = []
    arrformax.each { |arr| values.push(arr[1]) }
    max = values.max
    temp = findarr(arrformax, max)
    puts "Highest Temperature: #{max}C on #{months[temp[0]]} #{temp[2] + 1}"
  end

  def lowestyear(arrformin, months)
    values = []
    arrformin.each do |arr|
      values.push(arr[1]) if arr[1] != 0
    end
    min = values.min
    temp = findarr(arrformin, min)
    puts "Lowest Temperature: #{min}C on on #{months[temp[0]]} #{temp[2] + 1}"
  end

  def humidityyear(arrforhum, months)
    values = []
    arrforhum.each { |arr| values.push(arr[1]) }
    maxhum = values.max
    temp = findarr(arrforhum, maxhum)
    puts "Highest Humidity: #{maxhum}% on #{months[temp[0]]} #{temp[2] + 1}"
  end
end

# Module to find monthdata.
module Monthvalid
  def monthinp(path, filename, year)
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
