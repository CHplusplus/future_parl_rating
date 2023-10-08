export function mobileNav() {
    function initMobileNav() {
      const menu_btn = document.querySelector(".button-menu");
      const close_btn = document.querySelector(".nav-close");
      const mobile_menu = document.querySelector(".mobile-nav");
  
      menu_btn.addEventListener("click", function () {
        menu_btn.classList.add("is-active");
        mobile_menu.classList.add("is-active");
      });
  
      close_btn.addEventListener("click", function () {
        menu_btn.classList.remove("is-active");
        mobile_menu.classList.remove("is-active");
      });
    }
  
    document.addEventListener("turbo:load", initMobileNav);
  }
  
