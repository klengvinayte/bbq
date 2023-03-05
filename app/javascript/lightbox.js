import Lightbox from "bs5-lightbox";

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".lightbox-toggle").forEach(el => el.addEventListener("click", Lightbox.initialize));
})
