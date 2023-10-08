function getParameterByName(name, url) {
  if (!url) url = window.location.href;
  name = name.replace(/[[\]]/g, "\\$&");
  const regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return "";
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function setupSortSelect() {
  const dropdown = document.querySelector(".sort-dropdown");
  const button = document.querySelector(".sort-button-container");
  const icon = document.querySelector(".ph-sort-ascending");
  const option1 = document.querySelector(".option1");
  const option2 = document.querySelector(".option2");
  const iconOption = document.querySelector(".option1 i");
  const iconOption2 = document.querySelector(".option2 i");

  const sortByPointsAscendingUrl = button ? button.dataset.sortByPointsAscendingUrl : null;
  const sortByPointsDescendingUrl = button ? button.dataset.sortByPointsDescendingUrl : null;

  // Get the value of the 'order' parameter
  const order = getParameterByName("order");

  // Set the active state for the sort options based on the 'order' parameter
  if (order === "ascending") {
    if (option1) option1.classList.remove("active");
    if (option2) option2.classList.add("active");
    if (icon) {
      icon.classList.add("ph-sort-descending");
      icon.classList.remove("ph-sort-ascending");
    }
    if (iconOption) {
      iconOption.classList.remove("ph-check-circle-fill");
      iconOption.classList.remove("icon");
    }
    if (iconOption2) {
      iconOption2.classList.add("ph-check-circle-fill");
      iconOption2.classList.add("icon");
    }
  } else {
    if (option1) option1.classList.add("active");
    if (option2) option2.classList.remove("active");
    if (icon) {
      icon.classList.remove("ph-sort-descending");
      icon.classList.add("ph-sort-ascending");
    }
    if (iconOption) {
      iconOption.classList.add("ph-check-circle-fill");
      iconOption.classList.add("icon");
    }
    if (iconOption2) {
      iconOption2.classList.remove("ph-check-circle-fill");
      iconOption2.classList.remove("icon");
    }
  }

  if (button) {
    button.addEventListener("click", function (e) {
      if (dropdown) {
        dropdown.classList.toggle("shown");
      }
      e.stopPropagation();
    });
  }

  document.addEventListener("click", (e) => {
    if (e.target.closest(".dropdown")) return;
    if (dropdown) {
      dropdown.classList.remove("shown");
    }
  });

  if (option1) {
    option1.addEventListener("click", function (e) {
      if (sortByPointsDescendingUrl) {
        window.location.href = sortByPointsDescendingUrl;
      }
    });
  }

  if (option2) {
    option2.addEventListener("click", function (e) {
      if (sortByPointsAscendingUrl) {
        window.location.href = sortByPointsAscendingUrl;
      }
    });
  }
}

export function sortSelect() {
  setupSortSelect();
}

document.addEventListener("turbo:render", () => {
  if (document.querySelector("body").id === "people_index") {
    sortSelect();
  }
});
