module GroupsHelper
    def group_options
      I18n.t('groups').map { |key, value| [value, key] }
    end
  end