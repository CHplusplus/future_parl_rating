module PartiesHelper
    def party_options
      I18n.t('parties').map { |key, value| [value, key] }
    end
  end