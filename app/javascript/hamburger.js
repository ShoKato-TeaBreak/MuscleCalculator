export function setupHamburgerMenu() {
    const hamburger = document.querySelector(".hamburger-button");
    const button_text = document.querySelector(".hamburger-button-text")
    const menu = document.querySelector(".hamburger-menu-items");

    hamburger.addEventListener("click", function() {
        hamburger.classList.toggle('active');
        menu.classList.toggle('show');
        if(hamburger.classList.contains('active')){
            button_text.textContent = "Close"
        }else{
            button_text.textContent = "Menu"
        }
    });
}