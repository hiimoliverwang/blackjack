class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->
  hit: ->
    if @minScore() <= 21
      if @minScore() == 21 && !@isDealer
        if prompt 'are you sure? you idiot'
          @add(@deck.pop())
          @last()
      else 
        @add(@deck.pop())
        @last()


    if @minScore() > 21 then @trigger 'bust'


  hasAce: -> @reduce (memo, card) ->
    if memo or card.get('value') is 1
      1
    else 0
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  score: ->
    s = @scores()
    if s[1] <= 21
      return s[1]
    else s[0]

  stand: ->
    @trigger('stand')

  dealerTurn: ->
    @at(0).flip()
    while @scores()[0] < 17 and (@scores()[1] < 18 or @scores()[1] > 21)
      # console.log @scores() 
      @hit()
    return @score();




