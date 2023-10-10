require 'aws-sdk-s3'
class StaticPagesController < ApplicationController

    def detail
        # The page that explains how it works
        @title = I18n.t("navigation.how_it_works")
    end

    def apropos
        # The page that explains who we are
        @title = I18n.t("navigation.about")
    end

    def imprint
        # The imprint
        @title = I18n.t("navigation.imprint")
    end

    def privacy
        # The page that explains our privacy
        @title = I18n.t("navigation.privacy")
    end

    def data_export
        s3 = Aws::S3::Client.new(
          region: 'eu-central-1',
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
        )
        
        object = s3.get_object(bucket: 'parliratingimages', key: 'data_export.zip')
        send_data object.body.read, filename: 'data_export.zip', type: 'application/zip'
      end
end
