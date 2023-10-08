export function modalKantons() {
  document.addEventListener("turbo:load", () => {
    const body = document.querySelector("body");
    const modalbutton = document.querySelector("#kantons");
    const button = document.querySelector(".close-kantons");
    const modalcontain = document.querySelector("#modal-kantons");
    const applyButton = document.querySelector("#modal-kantons .button-primary");
    const allCheckbox = document.querySelector('#all-canton-checkbox');
    const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]:not(#all-canton-checkbox)');


    // Added this function to handle modal opening
    const openModal = () => {
      modalcontain.classList.add("active");
      body.style.overflow = "hidden";
      window.location.hash = ""; // Clear the hash when opening the modal
    };

    if (applyButton) {
      applyButton.addEventListener("click", function (e) {
        applyCantonFilter();
      });
    }

    if (modalbutton) {
      modalbutton.addEventListener("click", function (e) {
        e.preventDefault(); // Prevent the default behavior that adds the hash to the URL
        openModal(); // Use the openModal function to open the modal
      });
    }

    if (button) {
      button.addEventListener("click", function (e) {
        modalcontain.classList.remove("active");
        body.style.overflow = "auto";
      });
    }

    window.addEventListener("click", function (e) {
      if (e.target == modalcontain) {
        modalcontain.classList.remove("active");
        body.style.overflow = "auto";
      }
    });
  
    if (document.querySelector('#modal-kantons .button-text')) {
      document.querySelector('#modal-kantons .button-text').addEventListener('click', function (event) {
        event.preventDefault();
        clearCantonSelection();
      });
    }
  
    if (document.querySelector('#modal-kantons .button-primary')) {
      document.querySelector('#modal-kantons .button-primary').addEventListener('click', function (event) {
        event.preventDefault();
        applyCantonFilter();
      });
    }
    
    updateCantonSelection();
  });
}


function applyCantonFilter() {
  const filterCantonsUrl = document.getElementById('modal-kantons').dataset.filterCantonsUrl;
  const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]');
  const allCantons = ['AG', 'AR', 'AI', 'BL', 'BS', 'BE', 'FR', 'GE', 'GL', 'GR', 'JU', 'LU', 'NE', 'NW', 'OW', 'SH', 'SZ', 'SO', 'SG', 'TG', 'TI', 'UR', 'VS', 'VD', 'ZG', 'ZH'];
  const selectedCantons = [];

  cantonCheckboxes.forEach((checkbox) => {
    const label = checkbox.parentElement;
    const labelText = checkbox.parentElement.textContent.trim();
    if (label.classList.contains('all-canton-label') && checkbox.checked) {
      selectedCantons.push("All");
    } else if (checkbox.checked) {
      const cantonAbbr = labelText.match(/\((.*?)\)/)[1];
      selectedCantons.push(cantonAbbr);
    }
  });
  
  updateCantonIndicator();

  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
  fetch(filterCantonsUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
    body: JSON.stringify({ selected_cantons: selectedCantons }),
  })
    .then((response) => {
      if (response.ok) {
        window.location.reload();
      } else {
        console.error('Failed to apply canton filter');
      }
    })
    .catch((error) => {
      console.error('Error:', error);
    });
}

function updateCantonSelection() {
  if (document.getElementById('modal-kantons')) {
    const getCantonFilterUrl = document.getElementById('modal-kantons').dataset.getCantonFilterUrl;
    fetch(getCantonFilterUrl, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => response.json())
      .then((data) => {
        const allCheckbox = document.querySelector('#all-canton-checkbox');
        const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]:not(#all-canton-checkbox)');
        
        if (data.selected_cantons.includes("All")) {
          allCheckbox.checked = true;
          cantonCheckboxes.forEach((checkbox) => {
            checkbox.checked = false;
          });
        } else {
          allCheckbox.checked = false;
          cantonCheckboxes.forEach((checkbox) => {
            const labelText = checkbox.parentElement.textContent.trim();
            const cantonAbbrMatch = labelText.match(/\((.*?)\)/);
            if (cantonAbbrMatch === null) {
              console.error('Failed to match canton abbreviation for label:', labelText);
              return;
            }
            const cantonAbbr = cantonAbbrMatch[1];
            checkbox.checked = data.selected_cantons.includes(cantonAbbr);
          });
        }
        updateCantonIndicator();
      })
      .catch((error) => {
        console.error('Error:', error);
      });
    }
}

function updateCantonIndicator() {
  const cantonIndicator = document.querySelector('#cantons_indicator');
  const allCheckbox = document.querySelector('#all-canton-checkbox');
  const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]:not(#all-canton-checkbox)');
  const selectedCantonsCount = Array.from(cantonCheckboxes).filter(checkbox => checkbox.checked).length;

  if (cantonIndicator && allCheckbox) {
    if (!allCheckbox.checked) {
      cantonIndicator.textContent = selectedCantonsCount;
      cantonIndicator.style.display = 'inline-block';
    }
  }

}

function clearCantonSelection() {
  const allCheckbox = document.querySelector('#all-canton-checkbox');
  const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]:not(#all-canton-checkbox)');

  allCheckbox.checked = true;
  cantonCheckboxes.forEach((checkbox) => {
    checkbox.checked = false;
  });

  updateCantonIndicator();
}

function initializePeopleIndex() {
  const allCheckbox = document.querySelector('#all-canton-checkbox');
  const cantonCheckboxes = document.querySelectorAll('#modal-kantons input[type=checkbox]:not(#all-canton-checkbox)');

  if (allCheckbox) {
    allCheckbox.addEventListener('change', function () {
      if (allCheckbox.checked) {
        cantonCheckboxes.forEach((checkbox) => {
          checkbox.checked = false;
        });
      }
    });

    cantonCheckboxes.forEach((checkbox) => {
      checkbox.addEventListener('change', function () {
        let allCheckboxInsideListener = document.querySelector('#all-canton-checkbox');
        if (checkbox.checked && allCheckboxInsideListener.checked) {
          allCheckboxInsideListener.checked = false;
        } else if (!Array.from(cantonCheckboxes).some(checkbox => checkbox.checked)) {
          allCheckboxInsideListener.checked = true;
        }
      });
    });
  }

  updateCantonIndicator();
}

function handleTurboLoad() {
  const body = document.querySelector('body');
  if (body.id === 'people_index') {
    initializePeopleIndex();
  }
}

document.addEventListener('turbo:load', handleTurboLoad);
document.addEventListener('DOMContentLoaded', handleTurboLoad);
modalKantons();




