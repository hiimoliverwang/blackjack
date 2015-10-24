class window.ChipView extends Backbone.View
  model: Chip

  template: _.template '<button class="chip-<%= bet %>"><%= bet %></button>'

  events:
    'click .chip-1': ->
      @model.increaseBet(1)
      @render()
    'click .chip-5': ->
      @model.increaseBet(5)
      @render()
    'click .chip-10': ->
      @model.increaseBet(10)
      @render()
    'click .chip-25': ->
      @model.increaseBet(25)
      @render()
    'click .chip-50': ->
      @model.increaseBet(50)
      @render()
    'click .chip-100': ->
      @model.increaseBet(100)
      @render()

  initialize: -> 
    @renderButtons()
    @render()

  renderButtons: ->
    @$el.append($("<p><span class='wallet'></span><span class='bet'></span></p>"))
    @$el.append [1,5,10,25,50,100].map (bet) =>
      return $( @template( {'bet' : bet} ) )

  render: ->
    # @$el.first().text('')
    @$el.first().find('.wallet').text("MONEY : #{@model.get('wallet')}  ")
    @$el.first().find('.bet').text("BET : #{@model.get('bet')}")
    

