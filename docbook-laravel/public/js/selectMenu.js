const menu = document.querySelectorAll('.selectMenu')
menu.forEach(menu => {
    const select = menu.querySelector('.select')
    const caret = menu.querySelector('.caret')
    const menu2 = menu.querySelector('.menu2')
    const options = menu.querySelectorAll('.menu2 li')
    const selected = menu.querySelector('.selected')
    console.log("muaz")
    select.addEventListener('click', () => {
        select.classList.toggle('select-clicked');
        caret.classList.toggle('caret-rotate');
        menu2.classList.toggle('menu2-open')
    })
    options.forEach(option => {
        option.addEventListener('click', () => {
            selected.innerText = option.innerText;
            select.classList.remove('select-clicked');
            caret.classList.remove('caret-rotate')
            menu2.classList.remove('menu2-open')

            options.forEach(option => {
                option.classList.remove('active');
            });
            option.classList.add('active')
        })
    })
})