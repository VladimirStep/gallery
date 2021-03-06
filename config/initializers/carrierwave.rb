require 'carrierwave/orm/activerecord'

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  ImageUploader

  if defined?(CarrierWave)
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/public/test-uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/public/test-uploads/#{model.class.to_s.underscore}/#{model.id}"
        end
      end
    end
  end
end