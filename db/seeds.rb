# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts('======== begin create destroy_all sample data ========')
require_relative 'seeds/destroy_all'
puts('======== finish create destroy_all sample data ========')

puts 'Please wait a moment for the insertion of the address'

MasterDataGenerator::RawZipcodeDataGenerator.generate_init_rawdata if RawZipcode.count.zero?
MasterDataGenerator::RegionDataGenerator.instance.generate_init_pref_data if Prefecture.count.zero?
MasterDataGenerator::RegionDataGenerator.instance.generate_init_city_data if City.count.zero?
MasterDataGenerator::RegionDataGenerator.instance.generate_init_zipcode_data if Zipcode.count.zero?
MasterDataGenerator::RegionDataGenerator.instance.generate_init_town_data if Town.count.zero?

%w[user league team team_comment event event_attendance event_comment favorite].each do |item|
  puts("======== begin create #{item} sample data ========")
  require_relative "seeds/#{item}"
  puts("======== finish create #{item} sample data ========")
end
