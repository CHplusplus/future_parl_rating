module OfficesHelper
    def office_options
      I18n.t('offices').map { |key, value| [value, key] }
    end
  end