---
---

$ = (selector) ->
	document.querySelectorAll(selector)
_ = (nodeList, fn) ->
	if fn
		Array.prototype.map.call(nodeList, fn)
	else
		Array.prototype.slice.call(nodeList)
Element.prototype.prependChild = (child) ->
	this.insertBefore child, this.firstChild




body = $('body')[0]
navbar = $('.nav-bar')[0]

if navbar
	fixbar = navbar.cloneNode true
	menu = fixbar.querySelector('.nav-links')
	logo = $('.nav-bar .nav-toggle .nav-logo')[0].cloneNode true

	fixbar.classList.add('fixed')
	menu.prependChild logo
	menu.classList.add 'closed'

	fixthebar = (e) ->
		top = navbar.getBoundingClientRect().top

		if top < 0
			body.appendChild(fixbar) if not (body.contains fixbar)
		else if body.contains fixbar
			body.removeChild(fixbar)

	togglemenu = (e) ->
		if menu.classList.contains 'closed'
			menu.classList.remove 'closed'
		else
			menu.classList.add    'closed'

	window.addEventListener 'scroll', fixthebar
	fixbar.addEventListener 'click', togglemenu


animes = $('[data-entrance-style]')

if animes.length
	animes = _(animes)
	vh = window.innerHeight

	animes.forEach (section) ->
		animestyle = section.getAttribute 'data-entrance-style'
		section.setAttribute 'data-entrance', 'hide'

	entranceHandler = () ->
		for anime in animes
			false if anime.getAttribute('data-entrance') is anime.getAttribute('data-entrance-style')
			top = anime.getBoundingClientRect().top
			if top <= vh * 0.75
				anime.setAttribute 'data-entrance', anime.getAttribute 'data-entrance-style'



	window.addEventListener 'scroll', entranceHandler


container = $('.bg-caminhao')[0]

if container
	offset = 300
	inner = container.querySelector '.bg-caminhao-inner'
	vh = window.innerHeight

	scrollHandler = ()->
		bounding = inner.getBoundingClientRect()
		t = bounding.top
		h = bounding.height
		if t<=vh and t>=0
			styleOffset Math.ceil t / vh * offset

	styleOffset = (n) ->
		inner.style.right = n * (-1) + 'px'
		inner.style.transform = 'translate(' + n * (-1) + 'px)'

	styleOffset(offset)
	window.addEventListener 'scroll', scrollHandler

