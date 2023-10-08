export function languageSelect() {
  document.addEventListener("turbo:load", () => {
    const dropdown = document.querySelector(".language-dropdown");
    const button = document.querySelector(".language-button");
    const languageLinks = document.querySelectorAll('[data-locale]');

    button.addEventListener("click", function (e) {
      dropdown.classList.toggle("active");
      e.stopPropagation();
    });

    document.addEventListener("click", (e) => {
      if (e.target.closest(".dropdown")) return;
      dropdown.classList.remove("active");
    });

    languageLinks.forEach((link) => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const locale = link.dataset.locale;
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set('locale', locale);
        window.location.href = currentUrl.toString();
      });
    });
  });
}


// languageSelect();
// window.languageSelect = languageSelect



