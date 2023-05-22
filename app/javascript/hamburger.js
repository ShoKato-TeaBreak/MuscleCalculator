// document.addEventListener("DOMContentLoaded", function() {
//     console.log("DOMContentLoadedを起動しました。")
//     const hamburger = document.querySelector(".hamburger-button");
//     const button_text = document.querySelector(".hamburger-button-text")
//     const menu = document.querySelector(".hamburger-menu-items");
  
//     hamburger.addEventListener("click", function() {
//         console.log("ハンバーガーがクリックされました。");
//         hamburger.classList.toggle('active');
//         menu.classList.toggle('show');
//         if(hamburger.classList.contains('active')){
//             button_text.textContent = "Close"
//         }else{
//             button_text.textContent = "Menu"
//         }
//     });
// });

export function setupHamburgerMenu() {
    console.log("setupHamburgerMenuを起動しました。")
    const hamburger = document.querySelector(".hamburger-button");
    const button_text = document.querySelector(".hamburger-button-text")
    const menu = document.querySelector(".hamburger-menu-items");

    hamburger.addEventListener("click", function() {
        console.log("ハンバーガーがクリックされました。");
        hamburger.classList.toggle('active');
        menu.classList.toggle('show');
        if(hamburger.classList.contains('active')){
            button_text.textContent = "Close"
        }else{
            button_text.textContent = "Menu"
        }
    });
}