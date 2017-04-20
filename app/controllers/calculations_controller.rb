class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    space_count = @text.count(" ")
    char_count = @text.length
    no_punctuation = @text.gsub(/[.,:;"?!()]/, ' ')
    temp = @text.downcase
    words = temp.gsub(/[.,:;"?!()]/, ' ').split(" ")
    i = 0
    count = 0
    a = @special_word.downcase
    while i<=words.size
      if a == words[i]
        count+=1
      end
      i+=1
    end

    @word_count = @text.gsub(/[.,:;"?!()]/, ' ').split(" ").size

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = char_count - space_count

    @occurrences = count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    rate = @apr/1200
    period = @years*12
    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal*(rate/(1-(1+rate)**(-period)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/60
    @hours = (@ending-@starting)/3600
    @days = (@ending-@starting)/(3600*24)
    @weeks = (@ending-@starting)/(3600*24*7)
    @years = (@ending-@starting)/(3600*24*7*52)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    a = @numbers.sort
    array_size=a.count

    if array_size%2 == 0
      temp_median = (a[(array_size/2)-1]+a[(array_size/2)])/2
    else
      temp_median = a[(array_size-1)/2]
    end


    temp_sum=0
    i=0
    while i<array_size
        temp_sum+=a[i]
        i+=1
    end

    temp_mean = temp_sum/array_size

    temp_num=0
    i=0
    while i<array_size
        temp_num+=(a[i]-temp_mean)**2
        i+=1
    end
    temp_var = temp_num/(array_size)

    most_frequent_item = a.uniq.max_by{ |i| a.count( i ) }

    @sorted_numbers = a.sort

    @count = a.count

    @minimum = a.min

    @maximum = a.max

    @range = a.max-a.min

    @median = temp_median

    @sum = temp_sum

    @mean = temp_sum/array_size

    @variance = temp_var

    @standard_deviation = Math.sqrt(temp_var)

    @mode = most_frequent_item

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
