require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :price, :time, :seats

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @price = options['price']
    @time = options['time']
    @seats = options['seats'].to_i
  end

  def save
    sql = "INSERT INTO screenings (film_id, price, time, seats)
      VALUES ('#{@film_id}', '#{@price}', '#{@time}', #{@seats})
      RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM screenings"
    return Screening.map_items(sql)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    screening_hashes = SqlRunner.run(sql)
    return screening_hashes.map { |screening| Screening.new(screening) }
  end

end