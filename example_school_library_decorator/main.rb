require_relative './app'

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength

def display
  puts 'Welcome to OOP Library'
  puts ' '
  puts 'Please choose a number'
  puts '1 - list all books'
  puts '2 - list all people'
  puts '3 - create a person'
  puts '4 - create a book'
  puts '5 - create a rental'
  puts '6 - list all rentals'
  puts '7 - exit'
end

def main
  library = App.new
  user_entry = nil

  while user_entry != '7'
    display

    user_entry = gets.chomp

    case user_entry
    when '1'
      library.list_books
    when '2'
      library.list_people
    when '3'
      library.create_person
    when '4'
      library.create_book
    when '5'
      library.create_rental
    when '6'
      library.all_rentals
    when '7'
      puts 'Bye'
    else
      puts 'Invalid entry'
    end

  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

main
