namespace :db do
  namespace :data do

    def db_dump_data_file (extension = "yml")
      "#{dump_dir}/data.#{extension}"
    end

    def dump_dir(dir = "")
      "#{Rails.root}/db#{dir}"
    end

    desc 'Dump anonymized database contents to db/data.yml'
    task :dump_anonymized => :environment do
      SerializationHelper::Base.new(YamlDb::Anonymizer::Helper).dump db_dump_data_file
    end

    desc "Dump contents of database to curr_dir_name/tablename.extension (defaults to yaml)"
    task :dump_dir_anonymized => :environment do
      dir = ENV['dir'] || "#{Time.now.to_s.gsub(/ /, '_')}"
      SerializationHelper::Base.new(YamlDb::Anonymizer::Helper).dump_to_dir dump_dir("/#{dir}")
    end

  end
end
