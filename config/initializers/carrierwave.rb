CarrierWave.configure do |config|
    # hack fix for windows machine due to tmp file permission error
     # per https://github.com/jnicklas/carrierwave/issues/220/
     if ENV['RAILS_ENV'] != 'production'
          config.delete_tmp_file_after_storage = false
     end

     config.fog_credentials = {
         :provider                         => 'Google',
         :google_storage_access_key_id     => 'GOOGNA5CCD2SJWHTQ6ON',
         :google_storage_secret_access_key => 'wTQIyrQBxrfT6ua0aXykO/AfCE0+5HLkCaugb4/h'
       }
     if Rails.env != 'production'
        config.fog_directory = 'developmenttest'
     else
       config.fog_directory = 'legitstreams'
      end

end