require_relative './book'
require_relative './rental'
require_relative './student'
require_relative './teacher'

# rubocop:disable Metrics/MethodLength

class App
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

  def create_person
    puts 'Are you a teacher or a student'
    puts 'Enter number one (1) for Teacher or number two (2) for Student'

    input = gets.chomp.to_i
    return puts 'Invalid Enrty.' unless [1, 2].include?(input)

    case input
    when 2
      puts 'name: '
      name = gets.chomp

      puts 'age: '
      age = gets.chomp

      print 'Do you have parent permission?'
      permission = gets.chomp
      permission = permission.downcase == 'Y'

      @people << Student.new(name, age, permission)

      puts 'Student has been created successfully'
    when 1
      puts 'name: '
      name = gets.chomp

      puts 'age: '
      age = gets.chomp

      print 'specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, name, specialization)

      puts 'Teacher has been created successfully'
    end
  end

  def create_rental
    puts 'Choose book using the book index'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end

    puts 'Date'
    date = gets.chomp

    puts 'Enter book index from the list above'
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

  # def all_rentals
  #   print 'ID of person: '
  #   id = gets.chomp.to_i
  #   rentals = @rentals.filter { |rental| rental.person.id == id }
  #   puts 'Rentals:'
  #   rentals.each do |rental|
  #     puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
  #   end
  # end
end

# rubocop:enable Metrics/MethodLength
