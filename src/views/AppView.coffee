class window.AppView extends Backbone.View

  tagName: 'section'

  template: _.template '
    <button class="hitting hit-button" style="display: none;">Hit</button> <button class="hitting stand-button" style="display: none;">Stand</button> <button class="new-game-button" style="display: none;">New Game</button>
    <div class="hand player-hand-container"></div>
    <div class="hand dealer-hand-container"></div>
    <div class="money-bags"></div>
  '

  events:
    'click .hit-button': -> 
      @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('playerHand').stand()
    'click .new-game-button': -> 
      window.gameState = 'betting'
      @model.newHand()

  initialize: ->
    @render()
    @model.on 'newHand', @render, @
    @model.on 'stateChange', ->
      @render()
    , @
    # $('.hitting').fadeOut()
    # $('.new-game-button').fadeOut()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$el.prepend($("<h1> #{window.gameState}</h1>"))
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.money-bags').html new ChipView(model: @model.get 'chip').el
    console.log(window.gameState)

    if window.gameState == "hitting"
      @$el.find('.new-game-button').fadeOut()
      @$el.find('.betting').fadeOut();
      @$el.find('.hitting').fadeIn();
    else if window.gameState == 'end-game'
      @$el.find('.betting').fadeOut();
      @$el.find('.hitting').fadeOut();
      @$el.find('.new-game-button').fadeIn()
    else if window.gameState == 'betting'
      @$el.find('.betting').fadeIn();
      debugger
      @$el.find('.hitting').fadeOut();
      @$el.find('.new-game-button').fadeOut();


