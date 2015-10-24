# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'chip', new Chip(100)
    @newHand()

  newHand: ->
    @checkDeck()
    @set 'playerHand', @get('deck').dealPlayer()
    @get('playerHand').on 'bust', ->
      console.log "YOU LOSE, BUSTER!!!"
    , @
    @get('playerHand').on 'stand', ->
      score = @.get('dealerHand').dealerTurn()
      console.log score
      if score > 21 or score < @get('playerHand').score() 
        console.log 'YOU WIN!!!';
      else
        console.log 'YOU LOSE, LOSER!!!'
    , @
    @set 'dealerHand', @get('deck').dealDealer()
    @trigger('newHand')

  checkDeck: -> 
    if @get('deck').length < 15
      console.log('shuffling...')
      @set 'deck', new Deck()

  # dealerTurn: ->
  #   console.log 'dealerTurn' 








