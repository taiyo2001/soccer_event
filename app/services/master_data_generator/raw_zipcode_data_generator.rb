require 'csv'

module MasterDataGenerator
  class RawZipcodeDataGenerator
    def self.generate_init_rawdata
      zipcode_downloader = ZipcodeDownloader.new

      zipcode_downloader.download_latest

      records = CSV.foreach(zipcode_downloader.unziped_file_path, headers: false, encoding: 'Shift_JIS').lazy.map do |row|
        RawZipcode.new(
          code: row[2],
          prefecture_kana: row[3],
          city_kana: row[4],
          town_kana: row[5],
          prefecture: row[6],
          city: row[7],
          town: row[8]
        )
      end

      ActiveRecord::Base.transaction do
        records.each_slice(1000, &RawZipcode.method(:import!))
      end
    end
  end
end
