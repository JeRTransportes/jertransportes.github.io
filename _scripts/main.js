import scrollToY from './lib/scrollToY';

Element.prototype.prependChild = function(child) {
	this.insertBefore(child, this.firstChild);
};

const navbar = document.querySelector('.nav-bar');

if (navbar) {
	const navlinks = navbar.querySelector('.nav-links');
	const initialTitle = document.title;
	const fixbar = navbar.cloneNode(true);
	const menu = fixbar.querySelector('.nav-links');
	const logo = navbar.querySelector('.nav-toggle .nav-logo').cloneNode(true);
	const sections = Array.prototype.map.call(menu.querySelectorAll('a[href^="#"]'), (link) =>
		document.querySelector(link.attributes.href.nodeValue.toString()));

	fixbar.classList.add('fixed');
	menu.prependChild(logo);
	menu.classList.add('closed');
	window.addEventListener('scroll', onPageScroll, false);
	navbar.addEventListener('click', navigate, false);
	fixbar.addEventListener('click', navigate, false);

	function onPageScroll() {
		const top = navbar.getBoundingClientRect().top;
		const isInPage = document.body.contains(fixbar);

		if (top <= 0) isInPage || document.body.appendChild(fixbar);
		else if (isInPage) document.body.removeChild(fixbar);

		let newTitle, newId;

		sections.forEach(section => {
			const vl = section.getBoundingClientRect().top - window.innerHeight / 2;
			if (vl > 0) return;
			if (section.hasAttribute('data-title')) {
				newTitle = section.getAttribute('data-title');
				newId = section.id;
			}
		});
		if (newTitle) document.title = initialTitle + ' - ' + newTitle;
		else document.title = initialTitle;

		Array.prototype.forEach.call(menu.querySelectorAll('a'), a =>
			a.attributes.href.nodeValue.toString() === '#' + newId ?
				a.classList.add('selected') :
				a.classList.remove('selected')
		);
	}
	
	function navigate(e) {
		if (menu.classList.contains('closed')) {
			menu.classList.remove('closed');
			navlinks.classList.remove('closed');
		}
		else {
			menu.classList.add('closed');
			navlinks.classList.add('closed');
		}
		if (e.target.href) {
			e.preventDefault();
			const target = e.target.attributes.href.nodeValue.toString();
			if (!target) return;
			const fixbarOffset = fixbar.getBoundingClientRect().height || navbar.getBoundingClientRect().height;
			const sectionTarget = document.querySelector(target);
			if (sectionTarget) {
				const scrollTarget = sectionTarget.offsetTop - fixbarOffset;
				scrollToY(scrollTarget, 500, 'easeInOutQuint', () => false);
			}
		}
	}
}

const animes = document.querySelectorAll('[data-entrance-style]');

if (animes.length) {

	const vh = window.innerHeight

	Array.prototype.forEach.call(animes, (section) => section.setAttribute('data-entrance', 'hide'));
	
	window.addEventListener('scroll', entranceHandler, false);
	function entranceHandler() {
		Array.prototype.forEach.call(animes, anime => {
			if (anime.getAttribute('data-entrance') === anime.getAttribute('data-entrance-style')) return false;
			const top = anime.getBoundingClientRect().top;
			if (top <= vh * 0.75) anime.setAttribute('data-entrance', anime.getAttribute('data-entrance-style'));
		});
	}

}

const container = document.querySelector('.bg-caminhao');

if (container) {
	const offset = 300;
	const inner = container.querySelector('.bg-caminhao-inner');
	const vh = window.innerHeight;
	
	styleOffset(offset);
	inner.style.right = offset * (-1) + 'px';
	window.addEventListener('scroll', scrollHandler, false);

	function scrollHandler() {
		const t = inner.getBoundingClientRect().top;
		if (t<=vh && t>=0) styleOffset(Math.ceil(t) / vh * offset);
	}

	function styleOffset(n) {inner.style.transform = 'translate(' + n * (-1) + 'px)'}
}
