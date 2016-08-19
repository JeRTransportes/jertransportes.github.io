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
