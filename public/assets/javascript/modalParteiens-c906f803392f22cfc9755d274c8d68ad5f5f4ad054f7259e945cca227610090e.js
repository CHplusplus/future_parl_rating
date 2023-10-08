export function modalParteiens() {
  document.addEventListener("turbo:load", () => {
    const body = document.querySelector("body");
    const modalbutton = document.querySelector("#parteiens");
    const button = document.querySelector(".close-parteiens");
    const modalcontain = document.querySelector("#modal-parteiens");

    const openModal = () => {
      modalcontain.classList.add("active");
      body.style.overflow = "hidden";
    };

    if (modalbutton) {
      modalbutton.addEventListener("click", function (e) {
        e.preventDefault();
        openModal();
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

    if (modalcontain) {
      handlePartyFilter();
    } 
  });
}
  
function handlePartyFilter() {

  const modalParteiens = document.querySelector("#modal-parteiens");
  const getPartyFilterUrl = modalParteiens.dataset.getPartyFilterUrl;
  const filterPartiesUrl = modalParteiens.dataset.filterPartiesUrl;

  fetch(getPartyFilterUrl)
  .then((response) => response.json())
  .then((data) => {
    if (data.selected_parties.includes("All")) {
      allCheckbox.checked = true;
      partyCheckboxes.forEach((checkbox) => {
        checkbox.checked = false;
      });
    } else {
      allCheckbox.checked = false;
      partyCheckboxes.forEach((checkbox) => {
        checkbox.checked = data.selected_parties.includes(checkbox.value);
      });
    }
  });

  const allCheckbox = document.querySelector("#modal-parteiens .checkbox-list input[type='checkbox'][value='All']");
  const partyCheckboxes = Array.from(document.querySelectorAll("#modal-parteiens .checkbox-list input[type='checkbox']:not([value='All'])"));
  const clearSelectionLink = document.querySelector("#modal-parteiens .modal-footer .button-text");
  const applyButton = document.querySelector("#modal-parteiens .modal-footer .button-primary");

  if (!allCheckbox || !clearSelectionLink || !applyButton || partyCheckboxes.length === 0) {
    return;
  }
  
  allCheckbox.addEventListener("change", (e) => {
    if (e.target.checked) {
      partyCheckboxes.forEach((checkbox) => {
        checkbox.checked = false;
      });
    }
  });

  partyCheckboxes.forEach((checkbox) => {
    checkbox.addEventListener("change", (e) => {
      if (e.target.checked) {
        allCheckbox.checked = false;
      }
    });
  });

  clearSelectionLink.addEventListener("click", (e) => {
    e.preventDefault();
    allCheckbox.checked = true;
    partyCheckboxes.forEach((checkbox) => {
      checkbox.checked = false;
    });
  });

  applyButton.addEventListener("click", (e) => {
    e.preventDefault(); 
  
    const selectedParties = partyCheckboxes.filter((checkbox) => checkbox.checked).map((checkbox) => checkbox.value);
    if (selectedParties.length === 0) {
      selectedParties.push("All");
    }
  
    fetch(filterPartiesUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({ selected_parties: selectedParties }),
    }).then((response) => {
      if (response.ok) {
        window.location.reload();
      }
    });
  });
  
}

modalParteiens();



