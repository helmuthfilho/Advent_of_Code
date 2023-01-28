def translate_to_snafu_number(decimal)
  snafu = ''
  
  while decimal.positive?
    decimal, rem = decimal.divmod(5)
    case rem
    when 0, 1, 2
      snafu += rem.to_s
    when 3
      decimal += 1
      snafu += '='
    when 4
      decimal += 1
      snafu += '-'
    end
  end
  return snafu.reverse
end

def translate_snafu_number(snafu)
  snafu_size = snafu.length - 1
  sum = 0
  
  snafu.chars.each_with_index do |char, index|
    case char
    when '-'
      char = -1
    when '='
      char = -2
    else
      char = char.to_i
    end

    sum += (char * (5 ** (snafu_size - index)))
  end

  return sum
end

def get_total_sum_of_snafu_list_in_decimal(snafu_list)
  total_sum = 0

  snafu_list.each do |snafu|
    total_sum += translate_snafu_number(snafu)
  end

  return total_sum
end

input = File.readlines('input.txt').map {|line| line.strip}

total_in_decimal = get_total_sum_of_snafu_list_in_decimal(input)
snafu_number = translate_to_snafu_number(total_in_decimal)

puts total_in_decimal
puts snafu_number