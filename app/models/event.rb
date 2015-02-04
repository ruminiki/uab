class Event < ActiveRecord::Base

	has_many :event_participants

	validates :name, presence: true
	validates :begin, presence: true
	validates :end, presence: true

	before_save :upper_case
	before_update :upper_case

	#selected participant
	attr_accessor :event_participant
	attr_accessor :event_participant_id

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
		self.local = self.local.mb_chars.upcase.to_s
	end

	def self.search(session)
		name   = session["search_event_name"]
		_month = session["search_event_month_selected"]

	    if _month.blank?
	      _month = Time.now.strftime("%Y-%m")
	    else
	      _month = _month[0..6]
	    end

		#_end   = session["search_event_end"]
		
		where("events.name like ?", "%#{name}%")
		.where("DATE_FORMAT(begin, '%Y-%m') = '#{_month}'")
		.order("begin")
		#.where('events.end <= ?', '#{_end}')
	end

	def formated_begin_date
		self.begin.strftime("%d/%m/%Y %H:%M") if self.begin
	end

	def formated_begin_date_without_time
		self.begin.strftime("%d/%m/%Y") if self.begin
	end	

	def formated_begin_date_only_time
		self.begin.strftime("%H:%M") if self.begin
	end	

	def formated_end_date
		self.end.strftime("%d/%m/%Y %H:%M") if self.end
	end
end
