def select_time(time, options = {})
	field = options[:from]
	base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
	if options[:ampm]
		hour, minute = time.strftime("%I %p,%M").split(",")
	else
		hour, minute = time.strftime("%I,%M").split(",")
	end
	select hour, :from => "#{base_id}"
	select minute, :from => base_id.gsub("4i", "5i")
end

def select_date(date, options = {})
	def select_date(date, options = {})
		field = options[:from]
		select date.year.to_s,   :from => "#{field}_1i"
		select_by_id date.month, :from => "#{field}_2i"
		select date.day.to_s,    :from => "#{field}_3i"  
	end
end
