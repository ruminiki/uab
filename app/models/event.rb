class Event < ActiveRecord::Base

	validates :name, presence: true
	validates :begin, presence: true
	validates :end, presence: true

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
		self.local = self.local.mb_chars.upcase.to_s
	end

	def self.search(session)
		name   = session["search_event_name"]
		_begin = session["search_event_begin"]
		#_end   = session["search_event_end"]
		
		where("events.name like ?", "%#{name}%")
		.where("('#{_begin}' between events.begin and events.end) or events.begin >= '#{_begin}'")
		.order("begin")
		#.where('events.end <= ?', '#{_end}')


	end

end
