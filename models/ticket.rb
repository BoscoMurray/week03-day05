require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (film_id, customer_id)
      VALUES ('#{@film_id}', '#{@customer_id}') RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
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