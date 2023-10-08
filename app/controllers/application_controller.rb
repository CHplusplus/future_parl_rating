class ApplicationController < ActionController::Base
    before_action :set_locale

    private

    def set_locale
        available_locales = %w(de fr)
        user_locale = http_accept_language.compatible_language_from(available_locales)
        if available_locales.include?(params[:locale])
          I18n.locale = params[:locale]
        else
          I18n.locale = user_locale || I18n.default_locale
        end
      end
    
      def default_url_options
        { locale: I18n.locale }
      end

end
