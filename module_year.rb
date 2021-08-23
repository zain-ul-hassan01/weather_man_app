# frozen_string_literal: true

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
