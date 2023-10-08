function setupEventListeners() {
  var hide = document.querySelectorAll(".hide-item");
  var hideVer = document.querySelectorAll(".hide-item-vermessung");
  var button = document.querySelector(".button-show");
  var buttonVer = document.querySelector(".button-show-vermessung");
  var blur = document.querySelector(".hide-items-gradient");
  var blurVer = document.querySelector(".hide-items-gradient-vermessung");

  if (button) {
    button.removeEventListener("click", _removeClasses); // Remove any previous event listeners
    button.addEventListener("click", _removeClasses);
  }

  if (buttonVer) {
    buttonVer.removeEventListener("click", _removeClassesVermessung); // Remove any previous event listeners
    buttonVer.addEventListener("click", _removeClassesVermessung);
  }

  function _removeClasses() {
    for (var i = 0; i < hide.length; i++) {
      hide[i].classList.toggle("hide-item");

      button.innerHTML = "Show Less";
      if (hide[i].classList.contains("hide-item") == true) {
        button.innerText = "Show more";
      } else {
        button.innerText = "Show less";
      }
    }
    blur.classList.toggle("hide-items-gradient");
  }

  function _removeClassesVermessung() {
    for (var k = 0; k < hideVer.length; k++) {
      hideVer[k].classList.toggle("hide-item-vermessung");

      buttonVer.innerHTML = "Show Less";
      if (hideVer[k].classList.contains("hide-item-vermessung") == true) {
        buttonVer.innerText = "Show more";
      } else {
        buttonVer.innerText = "Show less";
      }
    }
    blurVer.classList.toggle("hide-items-gradient-vermessung");
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
