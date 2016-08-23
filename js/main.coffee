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
navlinks = navbar.querySelector('.nav-links')
initialTitle = document.title

if navbar
	fixbar = navbar.cloneNode true
	menu = fixbar.querySelector('.nav-links')
	logo = $('.nav-bar .nav-toggle .nav-logo')[0].cloneNode true
	sections = _( menu.querySelectorAll('a[href^="#"]') ).map (link) ->
		return $(link.attributes.href.nodeValue.toString())[0]


	fixbar.classList.add('fixed')
	menu.prependChild logo
	menu.classList.add 'closed'

	onPageScroll = (e) ->
		top = navbar.getBoundingClientRect().top

		if top <= 0
			body.appendChild(fixbar) if not (body.contains fixbar)
		else if body.contains fixbar
			body.removeChild(fixbar)

		sectionOnPage = undefined

		for section in sections
			vl = section.getBoundingClientRect().top - window.innerHeight / 2
			break if vl > 0
			sectionOnPage = section
			if section.hasAttribute('data-title')
				newTitle = section.getAttribute('data-title') if section.hasAttribute('data-title')
				newId = section.id

		if newTitle
			document.title = initialTitle + ' - ' + newTitle
		else
			document.title = initialTitle

		_(menu.querySelectorAll 'a').forEach (a) ->
			if a.attributes.href.nodeValue.toString() is '#' + newId
				a.classList.add 'selected'
			else
				a.classList.remove 'selected'

	navigate = (e) ->
		if menu.classList.contains 'closed'
			menu.classList.remove 'closed'
			navlinks.classList.remove 'closed'
		else
			menu.classList.add 'closed'
			navlinks.classList.add 'closed'

		if e.target.href
			e.preventDefault()
			fixbarOffset = fixbar.getBoundingClientRect().height || navbar.getBoundingClientRect().height
			target = e.target.attributes.href.nodeValue.toString()
			return if not target
			sectionTarget = $(target)[0]
			if sectionTarget
				scrollTarget = sectionTarget.offsetTop - fixbarOffset
				scrollToY scrollTarget, 500, 'easeInOutQuint', () -> 
					false

	window.addEventListener 'scroll', onPageScroll
	navbar.addEventListener 'click', navigate
	fixbar.addEventListener 'click', navigate


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
		inner.style.transform = 'translate(' + n * (-1) + 'px)'

	styleOffset(offset)
	inner.style.right = offset * (-1) + 'px'
	window.addEventListener 'scroll', scrollHandler

