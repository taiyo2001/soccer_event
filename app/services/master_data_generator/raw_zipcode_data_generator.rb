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

    # def self.generate_add_rawdata(diff_date = last_month_diff_date)
    #   file_name = "add_#{diff_date}"
    #   raise Exception, "#{file_name} has already added" if RawAddZipcode.exists?(file_name:)

    #   ActiveRecord::Base.transaction do
    #     CSV.foreach(ZipcodeDownloader.new.download_diff_file(file_name), headers: false, encoding: 'Shift_JIS') do |row|
    #       RawAddZipcode.create(
    #         file_name:,
    #         code: row[2],
    #         prefecture_kana: row[3],
    #         city_kana: row[4],
    #         town_kana: row[5],
    #         prefecture: row[6],
    #         city: row[7],
    #         town: row[8]
    #       )
    #     end
    #   end
    # end

    # def self.generate_del_rawdata(diff_date = last_month_diff_date)
    #   file_name = "del_#{diff_date}"
    #   raise Exception, "#{file_name} has already added" if RawDeleteZipcode.exists?(file_name:)

    #   ActiveRecord::Base.transaction do
    #     CSV.foreach(ZipcodeDownloader.new.download_diff_file(file_name), headers: false, encoding: 'Shift_JIS') do |row|
    #       RawDeleteZipcode.create(
    #         file_name:,
    #         code: row[2],
    #         prefecture_kana: row[3],
    #         city_kana: row[4],
    #         town_kana: row[5],
    #         prefecture: row[6],
    #         city: row[7],
    #         town: row[8]
    #       )
    #     end
    #   end
    # end

    # def self.last_month_diff_date
    #   (Time.current - 1.month).strftime('%Y%m').to_i - 200_000
    # end
  end
end
