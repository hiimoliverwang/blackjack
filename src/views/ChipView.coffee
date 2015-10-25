class window.ChipView extends Backbone.View
  model: Chip

  template: _.template '<button class="betting chip chip-<%= bet %>"><%= bet %></button>'

  events:
    'click .chip-1': ->
      @model.increaseBet(1)
    'click .chip-5': ->
      @model.increaseBet(5)
    'click .chip-10': ->
      @model.increaseBet(10)
    'click .chip-25': ->
      @model.increaseBet(25)
    'click .chip-50': ->
      @model.increaseBet(50)
    'click .chip-100': ->
      @model.increaseBet(100)
    'click .end-betting': ->
      @model.endBet()

  initialize: (params) ->
    @model = params.model;
    @renderButtons()
    @render()

    @model.on('change:wallet', @render, @)

  renderButtons: ->
    @$el.append($("<p><span class='wallet'></span><span class='bet'></span><button class='betting end-betting'>END BETTING</button></p>"))
    @$el.append [1,5,10,25,50,100].map (bet) =>
      return $( @template( {'bet' : bet} ) )
    @$el.find('button').hover(->
      $(@).animate('top', '-20px')
    , ->
      $(@).animate('top', '0')
    )

  render: ->
    # @$el.first().text('')
    @$el.first().find('.wallet').text("MONEY : #{@model.get('wallet')}  ")
    @$el.first().find('.bet').text("BET : #{@model.get('bet')}")
    

