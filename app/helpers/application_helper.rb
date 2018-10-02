module ApplicationHelper
	def titles
		%W(Prof. Mr.  Mrs.  Dr.  Ms.)
	end

	def mobile_carriers
		{
			"" => "",
			"Alltel" => "alltel",
			"AT&T"   => "ATT",
			"Boost Mobile" => "boost",
			"Nextel" => "nextel",
			"Sprint" => "sprint",
			"T-Mobile" => "T-Mobile",
			"US Cellular" => "uscellular",
			"Verizon" => "verizon",
			"Virgin Mobile" => "viring",
			"Other" => "other"
		}
	end
end
