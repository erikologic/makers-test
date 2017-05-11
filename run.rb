#!/usr/bin/env ruby

require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/printer_order'
require './models/discount_manager'
require './models/discount_express_delivery'
require './models/discount_10percent'

standard_delivery = Delivery.new(:standard, 10.0)
express_delivery = Delivery.new(:express, 20.0)

broadcaster_viacom = Broadcaster.new(1, 'Viacom')
broadcaster_disney = Broadcaster.new(2, 'Disney')
broadcaster_discovery = Broadcaster.new(3, 'Discovery')
broadcaster_horse_and_country = Broadcaster.new(7, 'Horse and Country')

material_wnp = Material.new('WNP/SWCL001/010')
material_zdw = Material.new('ZDW/EOWW005/010')

discount_manager = DiscountManager.new
discount_manager.add DiscountExpressDelivery.new
discount_manager.add Discount10Percent.new

####### FIRST ORDER
puts "First Order"
order1 = Order.new(material_wnp)
order1.printer = PrinterOrder.new(order1)
order1.discount = discount_manager

order1.add broadcaster_disney, standard_delivery
order1.add broadcaster_discovery, standard_delivery
order1.add broadcaster_viacom, standard_delivery
order1.add broadcaster_horse_and_country, express_delivery

print order1.output
print "\n\n\n\n"

####### SECOND ORDER
puts "Second Order"

order2 = Order.new(material_zdw)
order2.printer = PrinterOrder.new(order2)
order2.discount = discount_manager

order2.add broadcaster_disney, express_delivery
order2.add broadcaster_discovery, express_delivery
order2.add broadcaster_viacom, express_delivery

print order2.output
print "\n"
