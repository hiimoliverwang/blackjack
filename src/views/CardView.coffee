class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @model.get('url')
    @$el.addClass 'covered' unless @model.get 'revealed'

