require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :screening_id, :customer_id, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screening_id = options['screening'].id.to_i
    @customer_id = options['customer'].id.to_i
    @price = options['screening'].price.to_i
  end

  def save
    # if customer.get_funds >= screening.price
      sql = "INSERT INTO tickets (screening_id, customer_id, price)
        VALUES ('#{@screening_id}', '#{@customer_id}', #{@price})
        RETURNING id"
      @id = SqlRunner.run(sql)[0]['id'].to_i
      customer.deduct_funds(@price)
      customer.update_db
    # else
    #   return "Customer does not have enough funds."
    # end
  end

  # def film
  #   sql = "SELECT * FROM films
  #     WHERE id = #{@screening.film_id}"
  #   film = SqlRunner.run(sql)[0]
  #   return Film.new(film)
  # end

  def customer
    sql = "SELECT * FROM customers
      WHERE id = #{@customer_id}"
    customer = SqlRunner.run(sql)[0]
    return Customer.new(customer)
  end

  def screening
    sql = "SELECT * FROM screenings
      WHERE id = #{@screening_id}"
    customer = SqlRunner.run(sql)[0]
    return Screening.new(customer)
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