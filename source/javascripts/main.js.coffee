###########################
# Console Protection
###########################
window.console = { log: ()->{} } if window.console is 'undefined'


###########################
# UI
###########################
UI = {}
UI._fadeDuration = 250
UI._scrollDuration = 350
UI._scrollTopOffset = 100
UI._navbarTrans = true
UI._navbarTransClass = 'trans'

# UI.Navbar
#start---------------------
UI.Navbar = (_$domElement, _$) ->
  $el = _$domElement
  solid: ->
    $el.removeClass UI._navbarTransClass
  transparent: ->
    $el.addClass UI._navbarTransClass
  bindListeners: ->
    _this = @
    _$(window).on 'scroll.ui.transparentizeNavbar', (e) ->
      if $(@).scrollTop() > UI._scrollTopOffset then _this.transparent() else _this.solid()
#end-----------------------
uiNavbar = {}


# UI.BackToTop
#start---------------------
UI.BackToTop = (_$domElement, _$) ->
  $el = _$domElement
  show: ->
    $el.fadeIn(@_fadeDuration, () -> _$(window).trigger('shown.ui.backToTop'))
  hide: ->
    $el.fadeOut(@_fadeDuration, () -> _$(window).trigger('hidden.ui.backToTop'))
  scrollToTop: ->
    _$('html, body').animate { scrollTop: 0 }, @_scrollDuration
  bindListeners: ->
    _this = @
    $el.on 'click.ui.backToTop', (e) -> _this.scrollToTop()
    _$(window).on 'scroll.ui.backToTop', (e) ->
      if $(@).scrollTop() > UI._scrollTopOffset then _this.show() else _this.hide()
#end-----------------------
uiBackToTop = {}


# UI.Loading
#start---------------------
UI.LoadingOverlay = (_$domElement, _$) ->
  $el = _$domElement
  show: ->
    $el.fadeIn(@_fadeDuration, () -> _$(window).trigger('shown.ui.loading'))
  hide: ->
    $el.fadeOut(@_fadeDuration, () -> _$(window).trigger('hidden.ui.loading'))
#end-----------------------
uiLoadingOverlay = {}



###########################
# Locally Scoped jQuery
# jQuery DOM Ready
#         &
# Document Listeners
###########################
(($$) ->
  $$ window.jQuery, window, document
)(($, window, document) ->
  $(document)
    .ready (e) ->
      console.log '[DOM Ready] DOM is ready.'
      #
      uiNavbar = new UI.Navbar $('[data-ui-scope="navbar"]'), $
      uiNavbar.bindListeners()
      #
      uiBackToTop = new UI.BackToTop $('[data-ui-scope="backToTop"]'), $
      uiBackToTop.bindListeners()
      #
      uiLoadingOverlay = new UI.LoadingOverlay $('[data-ui-scope="loading"]'), $
      uiLoadingOverlay.hide()

    # Pseudo Links
    .on 'click.pseudoLink', 'a[href="#"], a.pseudo', (e) ->
        e.preventDefault()

  $(window)
    .on 'resize', (e) ->
      console.log '[window resize]'
)