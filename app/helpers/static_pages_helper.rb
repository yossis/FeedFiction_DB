module StaticPagesHelper
	def add_how_many_words(lines)
		words = Array.new
		lines.each do |w|
			words.push w.line
		end
		55-words.join(' ').split(' ').count
	end
end
