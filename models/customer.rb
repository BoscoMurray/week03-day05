require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :monero

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @monero = options['monero'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, monero)
      VALUES ('#{@name}', '#{@monero}')
      RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update_db
    sql = "UPDATE customers
      SET (name, monero) = ('#{@name}', '#{@monero}')
      WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE tickets.customer_id = #{@id}"
    return Film.map_items(sql)
  end

  def customer_has_enough_funds(value)
    return @monero >= value
  end

  def get_funds
    sql = "SELECT monero FROM customers
      WHERE id = #{@id}"
    @monero = SqlRunner.run(sql)[0]["monero"].to_i
    return @monero
  end

  def deduct_funds(value)
    @monero = @monero - value
  end

  def tickets
    sql = "SELECT * FROM tickets
      WHERE customer_id = #{@id}"
    return SqlRunner.run(sql).count
  end

  def self.all
    sql = "SELECT * FROM customers"
    return Customer.map_items(sql)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map { |customer| Customer.new(customer) }
  end

end