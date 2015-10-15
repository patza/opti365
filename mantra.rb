module Opti365
	class Mantra		
		
		def self.path
			File.dirname(__FILE__) + '/mantras'	
		end

		def self.today
			Mantra.find
		end

		def self.find id = nil
			id = Date.today.strftime("%-m_%-d") if id.nil?
			{date: id.split('_').reverse.join('/'), mantra: Pathname.new("#{Mantra.path}/#{id}.txt").read}
		end

	end
end