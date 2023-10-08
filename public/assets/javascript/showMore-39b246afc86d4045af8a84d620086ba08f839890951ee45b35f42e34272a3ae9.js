function setupEventListeners() {
  var hide = document.querySelectorAll(".hide-item");
  var hideVer = document.querySelectorAll(".hide-item-survey");
  var button = document.querySelector(".button-show");
  var buttonVer = document.querySelector(".button-show-survey");
  var blur = document.querySelector(".hide-items-gradient");
  var blurVer = document.querySelector(".hide-items-gradient-survey");

  if (button) {
    button.removeEventListener("click", _removeClasses); // Remove any previous event listeners
    button.addEventListener("click", _removeClasses);
  }

  if (buttonVer) {
    buttonVer.removeEventListener("click", _removeClassessurvey); // Remove any previous event listeners
    buttonVer.addEventListener("click", _removeClassessurvey);
  }

  function _removeClasses() {
    for (var i = 0; i < hide.length; i++) {
      hide[i].classList.toggle("hide-item");

      button.innerHTML = button.getAttribute("data-hide-text");
      if (hide[i].classList.contains("hide-item") == true) {
        button.innerText = button.getAttribute("data-show-text");
      } else {
        button.innerText = button.getAttribute("data-hide-text");
      }
    }
    blur.classList.toggle("hide-items-gradient");
  }

  function _removeClassessurvey() {
    for (var k = 0; k < hideVer.length; k++) {
      hideVer[k].classList.toggle("hide-item-survey");

      buttonVer.innerHTML = buttonVer.getAttribute("data-hide-text");
      if (hideVer[k].classList.contains("hide-item-survey") == true) {
          buttonVer.innerText = buttonVer.getAttribute("data-show-text");
      } else {
          buttonVer.innerText = buttonVer.getAttribute("data-hide-text");
      }
    }
    blurVer.classList.toggle("hide-items-gradient-survey");
  }
}

export function showMore() {
  document.addEventListener("turbo:load", () => {
    setupEventListeners();
  });

  document.addEventListener("turbo:before-render", () => {
    setupEventListeners();
  });
}

  


;
