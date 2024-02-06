# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Please wait a moment for the insertion of the address'

MasterDataGenerator::RawZipcodeDataGenerator.generate_init_rawdata
MasterDataGenerator::RegionDataGenerator.instance.generate_init_pref_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_city_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_zipcode_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_town_data

%w[user league team team_comment event event_attendance event_comment favorite].each do |item|
  puts("======== begin create #{item} sample data ========")
  require_relative "seeds/#{item}"
  puts("======== finish create #{item} sample data ========")
end
