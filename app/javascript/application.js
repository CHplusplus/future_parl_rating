// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"

import { mobileNav } from "mobileNav";
import { navbarScroll } from "navbarScroll";
import { radialBar } from "radialBar";
import { languageSelect } from "languageSelect";
import { sortSelect } from "sortSelect";
import { modalKantons } from "modalKantons";
import { modalParteiens } from "modalParteiens";
import { showMore } from "showMore";
import { initSearchPeople } from "initSearchPeople";

window.radialBar = radialBar;

mobileNav();
navbarScroll();
radialBar();
languageSelect();
sortSelect();
modalKantons();
modalParteiens();
initSearchPeople();
showMore();
