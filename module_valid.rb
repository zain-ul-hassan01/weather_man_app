# frozen_string_literal: true

# Module for opening file and other methods.
module Validation
  def inputvalidation
    puts 'Enter the region of your concern.'
    used = ''
    while used
      region = gets.chomp
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
    maxtemphash, mintemphash, maxhumidity = Array.new(3) { [] }
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
      maxtemphash, mintemphash, maxhumidity = Array.new(3) { [] }
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
