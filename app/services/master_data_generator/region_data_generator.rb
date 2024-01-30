module MasterDataGenerator
  class RegionDataGenerator
    include Singleton

    def generate_init_pref_data
      ActiveRecord::Base.transaction do
        records = RawZipcode.select(:id, :prefecture, :prefecture_kana)
                            .group_by(&:prefecture)
                            .sort_by { |_, b| b.first.id }
                            .map { |_, pref| [pref.first.prefecture, pref.first.prefecture_kana] }

        prefs = records.map do |record|
          Prefecture.new(
            name: record.first,
            kana: record.second
          )
        end
        Prefecture.import!(prefs)
      end
    end

    def generate_init_city_data
      ApplicationRecord.transaction do
        prefs = Prefecture.all.group_by(&:name).transform_values(&:first)
        entries = RawZipcode.select(:prefecture, :city, :city_kana).distinct
        cities = entries.map do |item|
          pref = prefs.fetch(item.prefecture)
          City.new(prefecture_id: pref.id,
                   name: item.city,
                   kana: item.city_kana)
        end
        City.import!(cities)
      end
    end

    def generate_init_town_data
      ApplicationRecord.transaction do
        attrs = %i[town town_kana prefecture city code]

        num_all = RawZipcode.count
        num_distinct = RawZipcode.select(*attrs).distinct.length
        raise 'attributes are not unique!' if num_all != num_distinct

        cities = City.includes(:prefecture)
                     .group_by { |item| [item.prefecture.name, item.name] }
                     .transform_values(&:first)

        RawZipcode.find_in_batches do |raw_zipcodes|
          items = raw_zipcodes.map do |item|
            attrs.map { |attr| item.send(attr) }
          end
          zipcodes =
            Zipcode.where(id: items.map { |item| item[4] }).group_by(&:id).transform_values(&:first)
          towns = items.map do |town, kana, pref_name, city_name, code|
            city = cities.fetch([pref_name, city_name])
            zipcode = zipcodes.fetch(code)
            begin
              Town.new(city:, zipcode:, name: town, kana:)
            rescue StandardError => e
              Rails.logger.info(e)
            end
          end
          Town.import!(towns)
        end
      end
    end

    def generate_init_zipcode_data
      ApplicationRecord.transaction(isolation: :serializable) do
        RawZipcode.find_in_batches do |raw_zipcodes|
          codes = raw_zipcodes.map(&:code).uniq
          in_db = Zipcode.where(id: codes).pluck(:id)
          codes -= in_db
          zipcodes = codes.map do |code|
            Zipcode.new(id: code)
          end
          Zipcode.import!(zipcodes)
        end
      end
    end
  end
end
