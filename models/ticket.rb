require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film = options['film']
    @customer = options['customer']
  end

  def save
    if @customer.get_funds >= @film.price
      sql = "INSERT INTO tickets (film_id, customer_id)
        VALUES ('#{@film.id}', '#{@customer.id}')
        RETURNING id"
      @id = SqlRunner.run(sql)[0]['id'].to_i
      @customer.deduct_funds(@film.price)
      @customer.update_db
    else
      return "Customer does not have enough funds."
    end
  end

  def film
    sql = "SELECT * FROM films
      WHERE id = #{@film.id}"
    film = SqlRunner.run(sql)[0]
    return Film.new(film)
  end

  def customer
    sql = "SELECT * FROM customers
      WHERE id = #{@customer.id}"
    customer = SqlRunner.run(sql)[0]
    return Customer.new(customer)
  end

  def self.all
    sql = "SELECT * FROM tickets"
    return Ticket.map_items(sql)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    ticket_hashes = SqlRunner.run(sql)
    return ticket_hashes.map { |ticket| Ticket.new(ticket) }
  end

end