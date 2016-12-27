# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create name:'larry', email:'larry@coloc.cc', password:'123456', admin:true
channel = Channel.create name:"root", description:"root channel"
Content.create parent_id: 0, entity_id: channel.id, entity_type: "Channel", name:channel.name, description:channel.description