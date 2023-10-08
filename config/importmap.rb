# config/importmap.rb
Rails.application.config.importmap.map do
    # Pin npm packages by running ./bin/importmap
    pin "application", preload: true
    pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
    pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
    pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
    pin_all_from "app/javascript/controllers", under: "controllers"
    pin_all_from "app/javascript", under: "javascript"
  
    # Custom mappings
    pin "mobileNav", to: "javascript/mobileNav.js"
    pin "navbarScroll", to: "javascript/navbarScroll.js"
    pin "radialBar", to: "javascript/radialBar.js"
    pin "languageSelect", to: "javascript/languageSelect.js"
    pin "sortSelect", to: "javascript/sortSelect.js"
    pin "modalKantons", to: "javascript/modalKantons.js"
    pin "modalParteiens", to: "javascript/modalParteiens.js"
    pin "showMore", to: "javascript/showMore.js"
    pin "initSearchPeople", to: "javascript/search.js"
  end
  