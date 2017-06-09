require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
  end

  def save
    sql = "INSERT INTO films (title) VALUES ('#{@title}') RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE films
      SET (title) = ('#{@title}')
      WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE tickets.film_id = #{@id}"
    return Customer.map_items(sql)
  end

  def self.all
    sql = "SELECT * FROM films"
    return Film.map_items(sql)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    film_hashes = SqlRunner.run(sql)
    return film_hashes.map { |film| Film.new(film) }
  end

end