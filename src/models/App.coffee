# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    window.gameState = 'betting' #'betting', 'game-end', 'hitting'
    @set 'deck', deck = new Deck()
    @set 'chip', new Chip(100)
    @newHand()
    @get("chip").on 'end-bet', ->
      window.gameState = 'hitting'
      @trigger('stateChange')
    , @

  newHand: ->
    @checkDeck()
    @set 'playerHand', @get('deck').dealPlayer()
    @get('playerHand').on 'all', @playerEvents, @
    @set 'dealerHand', @get('deck').dealDealer()
    @get('chip').resetBet()
    @trigger('newHand')


  playerEvents : (event) =>
    switch event
      when 'bust'
        window.gameState = 'end-game'
        @checkForBroke()
        @trigger("stateChange")
        console.log "YOU LOSE, BUSTER!!!"
      when 'stand'
        score = @.get('dealerHand').dealerTurn()
        # console.log score
        if score > 21 or score < @get('playerHand').score() 
          console.log 'YOU WIN!!!';
          @get('chip').win()
        else
          console.log 'YOU LOSE, LOSER!!!'
        window.gameState = 'end-game'
        @checkForBroke()
        @trigger('stateChange')

  checkDeck: -> 
    if @get('deck').length < 15
      console.log('shuffling...')
      @set 'deck', new Deck()

  checkForBroke: ->
    if @get('chip').get('wallet') == 0
      @get('chip').set 'wallet', 100
      @get('chip').resetBet();
      alert('L2BlackJack');
      