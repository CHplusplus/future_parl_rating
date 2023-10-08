module CantonsHelper
    CANTON_CODES = %w[AG AR AI BL BS BE FR GE GL GR JU LU NE NW OW SG SH SZ SO TG TI UR VS VD ZG ZH]

    def translated_cantons(selected = nil)
        canton_names = CANTON_CODES.map { |code| [I18n.t("cantons.#{code}"), code] }
        options_for_select(canton_names, selected)
    end

  end