require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require('pry-byebug')

Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({"name" => "Eugene", "monero" => "10"})
customer1.save
customer2 = Customer.new({"name" => "Ross", "monero" => "100"})
customer2.save

film1 = Film.new({"title" => "Donnie Darko", "price" => "10"})
film1.save
film2 = Film.new({"title" => "The Goonies", "price" => "6"})
film2.save

ticket1 = Ticket.new({
  "film" => film1,
  "customer" => customer1
  })
ticket1.save
ticket2 = Ticket.new({
  "film" => film1,
  "customer" => customer2
  })
ticket2.save
ticket3 = Ticket.new({
  "film" => film2,
  "customer" => customer2
  })
ticket3.save

binding.pry
nil