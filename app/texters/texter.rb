class Texter < ActionMailer::Base
	default content_type: 'text/html', from: "notifications@classstatus.co", subject: ""

	def self.carriers
		Texter.carrier_gateways.keys
	end

	def self.carrier_gateways
		{
			alltel:     "message.alltel.com",
			att:        "txt.att.net",
			boost:      "myboostmobile.com",
			nextel:     "messaging.nextel.com",
			sprint:     "messaging.sprintpcs.com",
			tmobile:    "tmomail.net",
			uscellular: "email.uscc.net",
			verizon:    "vtext.com",
			virgin:     "vmobl.com"
		}.with_indifferent_access
	end

protected
	def text(options)
		if true or options[:method] == "email"
			mail(to: "#{options[:to]}@#{Texter.carrier_gateways[options[:carrier]]}").deliver
			puts "Texting #{options[:to]} using email #{options[:to]}@#{Texter.carrier_gateways[options[:carrier]]}"
		else
			PlivoAPI.send_message src: '14154294110', dst: "1"+options[:to], type: :sms, text: options[:message]
			puts "Texting #{options[:to]} using plivo"
		end
	end

	# def render(view)
		# ActionView::Base.new("app/views/#{self.class.name.camelize}").render(file: view)
	# end
end
