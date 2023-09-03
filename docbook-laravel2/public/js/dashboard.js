var dropdown = document.getElementsByClassName("dashboardDropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
    dropdown[i].addEventListener("click", function () {
        this.classList.toggle("active");
        var dropdownContent = this.nextElementSibling;
        if (dropdownContent.style.display === "block") {
            dropdownContent.style.display = "none";
        } else {
            dropdownContent.style.display = "block";
        }
    });
}
// modal

// Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
var btn2 = document.querySelectorAll(".myBtn");
var btn3 = document.querySelectorAll(".myBtn2");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
// function modalBtn(btn)
btnModalFunc(btn3);
btnModalFunc(btn2);
// When the user clicks on <span> (x), close the modal
span.onclick = function () {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

console.log("fdsfass")







// btn modal function
function btnModalFunc(btn) {
    btn.forEach(item => {
        item.addEventListener('click', event => {
            modal.style.display = "block";
            // }) = function () {
            //     modal.style.display = "block";
            // }
        })
    })
}
