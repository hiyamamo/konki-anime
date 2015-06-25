class SeasonValidator < ActiveModel::Validator
	def validate(record)
		s = Season.where("current = ?", true)
		if record.current == true && !s.empty?
			record.errors[:current] << "should only one which is true"
		end
	end
end
