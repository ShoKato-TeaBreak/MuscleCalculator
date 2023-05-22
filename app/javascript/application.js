// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { setupHamburgerMenu } from 'hamburger';

document.addEventListener("turbo:load", function() {
    setupHamburgerMenu();
});