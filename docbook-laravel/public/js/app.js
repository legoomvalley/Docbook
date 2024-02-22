
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
$(function () {
    let result = new Date($.now())
    result.setDate(result.getDate() + 2)
    let result2 = new Date($.now())
    result2.setDate(result2.getDate())
    console.log(result);
    $('.datePicker').datepicker(
        {
            dateFormat: 'dd-mm-yy',
            minDate: result
        });
    $('#datePickerDashboard1').datepicker(
        {
            dateFormat: 'dd-mm-yy',
        });
    $('#datePickerDashboard2').datepicker(
        {
            dateFormat: 'dd-mm-yy',
        });
    $('#datePickerDashboard3').datepicker(
        {
            dateFormat: 'dd-mm-yy',
            minDate: result2
        });
    $('input#timePicker').timepicker({
        interval: 10,
        minTime: '10:30',
        maxTime: '7:30pm',
    })
})
console.log(document.getElementsByClassName('timePicker'))
console.log("ddd")
// Navbar
const toggle = document.querySelector(".toggle");
const menu = document.querySelector(".menu");
const items = document.querySelectorAll(".item");
/* Toggle mobile menu */
function toggleMenu() {
    if (menu.classList.contains("active")) {
        menu.classList.remove("active");
        toggle.querySelector("a").innerHTML = "<i class='fas fa-bars'></i>";
    } else {
        menu.classList.add("active");
        toggle.querySelector("a").innerHTML = "<i class='fas fa-times'></i>";
    }
}

const doctorSpecialization = document.getElementsByClassName('doctorSpecializationOption')
for (var i = 0; i < doctorSpecialization.length; i++) {
    console.log(doctorSpecialization.value[i])


}

/* Activate Submenu */
function toggleItem() {
    if (this.classList.contains("submenu-active")) {
        this.classList.remove("submenu-active");
    } else if (menu.querySelector(".submenu-active")) {
        menu.querySelector(".submenu-active").classList.remove("submenu-active");
        this.classList.add("submenu-active");
    } else {
        this.classList.add("submenu-active");
    }
}



/* Event Listeners */
toggle?.addEventListener("click", toggleMenu, false);
for (let item of items) {
    if (item.querySelector(".submenu")) {
        item.addEventListener("click", toggleItem, false);
    }
    item.addEventListener("keypress", toggleItem, false);
}
document.addEventListener("click", closeSubmenu, false);

// alert 

const close = document.querySelector(".close");
const alert = document.querySelector(".alert");
console.log(close)

close.addEventListener('click', closeAlert);

function closeAlert() {
    alert.style.display = "none";
}
//

// sidebar page
function dashboard_open() {
    document.getElementById("mySidebar").style.display = "block";
}

function dashboard_close() {
    document.getElementById("mySidebar").style.display = "none";
}


// tbl id 

var tables = document.getElementsByClassName('table');
var table = tables[tables.length - 1];
var rows = table.rows;
for (var i = 1, td; i < rows.length; i++) {
    td = document.createElement('td');
    td.appendChild(document.createTextNode(i));
    rows[i].insertBefore(td, rows[i].firstChild);
}



/* Close Submenu From Anywhere */
function closeSubmenu(e) {
    if (menu.querySelector(".submenu-active")) {
        let isClickInside = menu
            .querySelector(".submenu-active")
            .contains(e.target);

        if (!isClickInside && menu.querySelector(".submenu-active")) {
            menu.querySelector(".submenu-active").classList.remove("submenu-active");
        }
    }
}


