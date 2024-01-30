require 'open-uri'
require 'zip'

module MasterDataGenerator
  class ZipcodeDownloader
    # https://www.post.japanpost.jp/zipcode/dl/kogaki-zip.html
    KEN_ALL = 'KEN_ALL'.freeze
    INITIAL_URL = 'https://www.post.japanpost.jp/zipcode/dl/oogaki/zip/ken_all.zip'.freeze
    DIFF_BASE = 'https://www.post.japanpost.jp/zipcode/dl/oogaki/zip/'.freeze

    def download_latest
      @zipcode_file = zipcode_compressed_file(['zipcode', '.zip'], INITIAL_URL)
    end

    def unziped_file_path
      raise Exception, "zipcode.zip file isn't found" unless @zipcode_file

      unziped_file = unzip_file(@zipcode_file, KEN_ALL)

      raise Exception, "#{KEN_ALL} file isn't found" unless unziped_file

      unziped_file.path
    end

    # file_name: del_2401(2024/01), add_2401(2024/01)
    def download_diff_file(file_name)
      download_file_path(file_name)
    end

    private

    def zipcode_compressed_file(filename, url_path)
      tmp_file = Tempfile.open(filename)
      tmp_file.binmode
      # rubocop:disable Security/Open
      URI.open(url_path) do |url_file|
        tmp_file.write(url_file.read)
      end
      # rubocop:enable Security/Open
      tmp_file.rewind
      tmp_file
    end

    def unzip_file(file_path, file_name)
      Zip::File.open(file_path) do |zip|
        zipfile = zip.find { |item| item.name == "#{file_name}.CSV" }
        raise Exception, "specifeid csv doesn't exist" unless zipfile

        tmp_file = Tempfile.open([zipfile.name, '.csv'], '/tmp')
        zip.extract(zipfile, tmp_file.path) { true }
        return tmp_file
      end
    end

    def download_file_path(file)
      download_file = zipcode_compressed_file([file, '.zip'], "#{DIFF_BASE}#{file}.zip")
      unziped_file = unzip_file(download_file, file.upcase)

      raise Exception, "#{file} file isn't found" unless unziped_file

      unziped_file.path
    end
  end
end
