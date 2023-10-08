export function radialBar() {
  const meters = document.querySelectorAll("svg[data-value] .meter");

  meters.forEach((path) => {
    // Get the length of the path
    let length = path.getTotalLength();

    // Get the value of the meter
    let value = parseInt(path.parentNode.getAttribute("data-value"));
    // Calculate the percentage of the total length
    let to = length * ((100 - value) / 100);
    path.getBoundingClientRect();
    // Set the Offset
    path.style.strokeDashoffset = Math.max(0, to);
  });
}

// Call radialBar on turbo:load
document.addEventListener("turbo:load", () => {
  radialBar();
});
