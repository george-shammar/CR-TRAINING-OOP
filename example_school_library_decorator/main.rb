# rubocop:disable Metrics/CyclomaticComplexity, Lint/UselessAssignment

require_relative './book'
require_relative './rental'
require_relative './student'
require_relative './teacher'

class Library
  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def create_book
    puts 'Book Name'
    title = gets.chomp.match('[a-zA-Z]+.*').string

    puts 'Book Author'
    author = gets.chomp.match('[a-zA-Z]+.*').string

    new_book = Book.new(title, author)
    @books.push(new_book)
    puts 'Added successfully'
  end

  def details
    puts 'name: '
    name = gets.chomp

    puts 'age: '
    age = gets.chomp
  end

  def create_person
    puts 'Are you a teacher or a student'
    puts 'Enter number one (1) for Teacher or number two (2) for Student'

    input = gets.chomp.to_i
    return puts 'Invalid Enrty.' unless [1, 2].include?(input)

    case input
    when 2
      details

      print 'Do you have parent permission?'
      permission = gets.chomp
      permission = permission.downcase == 'Y'

      @people << Student.new(name, age, permission)

      puts 'Student has been created successfully'
    when 1
      details

      print 'specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, name, specialization)

      puts 'Teacher has been created successfully'
    end
  end

  def create_rental
    puts 'Choose book'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end

    puts 'Date'
    date = gets.chomp

    puts 'Enter book index'
    book_index = gets.chomp.to_i

    puts "Enter a person's index"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_index = gets.chomp.to_i

    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Added successfully'
  end

  def list_books
    if @books.length.positive?
      @books.each { |book| puts "title: #{book.title}, Author: #{book.author}" }
    else
      puts 'No book found.'
    end
  end

  def list_people
    @people.each do |person|
      puts ' '
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      puts ' '
    end
  end
end

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

def option(library)
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
# rubocop:enable Metrics/CyclomaticComplexity, Lint/UselessAssignment

def main
  library = Library.new
  user_entry = nil

  while user_entry != '7'
    display

    user_entry = gets.chomp

    option(library)

  end
end

main
