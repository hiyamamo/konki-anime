module UsersHelper
	def get_jp_wday(sym)
		wday = { :sun => "日曜日", :mon => "月曜日", :tue => "火曜日", :wen => "水曜日", :thr => "木曜日", :fri => "金曜日", :sat => "土曜日", :other => "その他" }

		wday[sym]

	end
end
