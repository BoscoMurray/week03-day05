require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['title']
  end

  def save
    sql = "INSERT INTO films (title) VALUES ('#{@title}') RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    return Film.map_items(sql)
  end

  def self.map_items(sql)
    film_hashes = SqlRunner.run(sql)
    return film_hashes.map { |film| Film.new(film) }
  end

end