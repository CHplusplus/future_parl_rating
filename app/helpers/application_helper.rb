module ApplicationHelper
    def custom_javascript_include_tag(*sources)
        options = sources.extract_options!.stringify_keys
        sources.map { |source| tag(:script, { "src" => path_to_javascript(source) }.merge(options)) }.join("\n").html_safe
    end

    def active_class_for_home
      request_path = request.path
      root_path_without_locale = Rails.application.routes.url_helpers.root_path(locale: nil)
      root_path_with_default_locale = Rails.application.routes.url_helpers.root_path(locale: I18n.default_locale)
      people_path_with_locale = Rails.application.routes.url_helpers.people_path(locale: I18n.locale)
      request_path == root_path_without_locale || request_path == root_path_with_default_locale || request_path == people_path_with_locale ? 'active' : ''
    end
    
    

end
