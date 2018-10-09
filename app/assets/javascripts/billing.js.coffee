jQuery ->
	setupForm = ->
		$('#user_billing').submit ->
			if $('#user_stripe_card_token').val()
				true
			else
				$('input[type=submit]').attr('disabled', true)
				processCard()
				false

	processCard = ->
		card =
			number: $('#card_number').val()
			cvc: $('#card_code').val()
			expMonth: $('#card_month').val()
			expYear: $('#card_year').val()
		Stripe.createToken(card, handleStripeResponse)

	handleStripeResponse = (status, response) ->
		if status == 200
			$('#user_stripe_card_token').val(response.id)
			$('#user_billing').submit()
		else
			alert(response.error.message)
			$('input[type=submit]').removeAttr('disabled')

	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	setupForm()

