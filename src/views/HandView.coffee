class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    if @collection.at(0).get 'revealed'
      scoreEl = "#{@collection.scores()[0]}"
      if @collection.hasAce() 
        scoreEl += " or #{@collection.scores()[1]}"
    else
      scoreEl = "#{@collection.minScore()}"


    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el

    @$('.score').text scoreEl

