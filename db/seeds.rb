require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')
require_relative('../models/screening')

require('pry-byebug')

Ticket.delete_all
Screening.delete_all
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

screening1 = Screening.new({
  "film_id" => film1.id,
  "price" => film1.price,
  "time" => "13:00",
  "seats" => "30"
  })
screening1.save
screening2 = Screening.new({
  "film_id" => film2.id,
  "price" => film2.price,
  "time" => "18:00",
  "seats" => "15"
  })
screening2.save
screening3 = Screening.new({
  "film_id" => film2.id,
  "price" => film2.price,
  "time" => "21:00",
  "seats" => "15"
  })
screening3.save

ticket1 = Ticket.new({
  "screening" => screening1,
  "customer" => customer1
  })
ticket1.save
ticket2 = Ticket.new({
  "screening" => screening1,
  "customer" => customer2
  })
ticket2.save
ticket3 = Ticket.new({
  "screening" => screening2,
  "customer" => customer2
  })
ticket3.save



binding.pry
nil