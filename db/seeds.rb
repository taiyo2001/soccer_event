# !/usr/bin/env ruby

puts 'Please wait a moment for the insertion of the address'

MasterDataGenerator::RawZipcodeDataGenerator.generate_init_rawdata
MasterDataGenerator::RegionDataGenerator.instance.generate_init_pref_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_city_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_zipcode_data
MasterDataGenerator::RegionDataGenerator.instance.generate_init_town_data

%w[user].each do |item|
  puts("======== begin create #{item} sample data ========")
  require_relative "seeds/#{item}"
  puts("======== finish create #{item} sample data ========")
end
