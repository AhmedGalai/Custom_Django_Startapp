

function initDarkMode(){

	let isDarkmode = document.querySelector('body').classList.contains('darkmode');
	// console.log(isDarkmode);
	if (localStorage.getItem('darkMode')!= null){
		if (localStorage.getItem('darkMode')=='on'){
			turnOn();
		} else {
			turnOff();
		}		
	} else {
		if (window.matchMedia("(prefers-color-scheme:dark)").matches){
			turnOn();
		} else {
			turnOff();
		}
	}
	$('#darkmode-toggle').on('click',()=>{
		if (isDarkmode) {
			turnOff();
		} else {
			turnOn();
		}
	});
	function turnOn(){
		$('body').addClass('darkmode');
		localStorage.setItem('darkMode','on');
		isDarkmode = true;
	}
	function turnOff(){
		$('body').removeClass('darkmode');
		localStorage.setItem('darkMode','off');
		isDarkmode = false;
	}
}

function initMenus(){
	const menus = $('.menu');
	menus.forEach(menu=>{
		if (menu != null && menu != undefined){
			let toggle = menu.querySelector('.toggle');
			toggle.addEventListener('click',()=>{
				let active = menu.classList.contains('active');
				menus.forEach(temp=>{
					temp.classList.remove('active')
				});
				if (!active) {menu.classList.add('active')};
			});
		}
	});
}

function initCarousells(){
	let carousells = $('.carousell');
	carousells.forEach(carousell =>{
		let items = carousell.querySelectorAll('.item');
		let previous = carousell.querySelector('.previous');
		let next = carousell.querySelector('.next');
		previous.addEventListener('click',()=>{
			let activeItems = carousell.querySelectorAll('.active');
			activeItems.forEach(item =>{
				if (item.previousElementSibling == null){
					if (carousell.classList.contains('cycle')){
						items[items.length-1].classList.add('active');
						item.classList.remove('active');
					}
				} else {
					item.previousElementSibling.classList.add('active');
					item.classList.remove('active');
				}
			})
		})
		next.addEventListener('click',()=>{
			let activeItems = carousell.querySelectorAll('.active');
			activeItems.forEach(item =>{
				console.log(item, item.nextElementSibling);
				if (item.nextElementSibling == null){
					if (carousell.classList.contains('cycle')){
						items[0].classList.add('active');
						item.classList.remove('active');
					}
				} else {
					item.nextElementSibling.classList.add('active');
					item.classList.remove('active');
				}
			})
		})
	})
}

$.init = function(){
	initDarkMode();
	initMenus();
	initCarousells();
}