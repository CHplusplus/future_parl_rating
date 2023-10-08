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
end
