require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :monero

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @monero = options['monero'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, monero) VALUES ('#{@name}', '#{@monero}') RETURNING id"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers"
    return Customer.map_items(sql)
  end

  def self.map_items(sql)
    customer_hashes = SqlRunner.run(sql)
    return customer_hashes.map { |customer| Customer.new(customer) }
  end

end