class window.Chip extends Backbone.Model
  initialize: (wallet) ->
    @set 'wallet', wallet
    console.log(@get 'wallet')

  defaults: 
    bet: 0

  increaseBet: (betAmount) ->
    console.log @get 'wallet'
    console.log betAmount
    if @get('wallet')>= betAmount
      console.log 'this is okay'
      @set 'bet', @get('bet') + betAmount
      @set 'wallet', @get('wallet') - betAmount
    else
      alert 'IMMA BUST YO KNEE CAPZ BIATCH!!!'

