
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Joel Lehman
# joel1500@bresnan.net
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "Joel Lechman"

#takes a single string, returns a cleaned up string for further processing
def cleanup_title(string)
	pattern =
	/<SEP>[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*$[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*|<SEP>[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/][\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/][\w*\s*]*|<SEP>[\w\s]*$/
	title = ""

	#grab title (only grabs english titles ex ignores titles with letter accents in them)
	if string =~ pattern
		titleWithSEP = "#{$&}"
	end
	sepPattern = /<SEP>/
	if titleWithSEP =~ sepPattern	#Remove Preceding <SEP> to end up with just the title
		title = "#{$'}"
	end

	#cleanup said title part 2
	#pat1-3 are regular expressions identifying superflous text as stated in the instructions
	pat1 = /[(\{\/:"`+=*]/
	pat2 = /\|\[\-/
	pat3 = /feat.|\[|\-/
	#if the title contains any superfluous text, we just want whatever comes before said text (#{$`})
	if title =~ pat1
		title = "#{$`}"
	end
	if title =~ pat2
		title = "#{$`}"
	end
	if title =~ pat3
		title = "#{$`}"
	end

	#eliminate characters part 3
	#finding and deleting the following punctuation: ?  ¿  !  ¡  .  ;  &  @  %  #  |
	punctuation = /[?¿!¡.;&@%#|]/
	if title =~ punctuation
		title.gsub!(punctuation, "") #replace with empty string to remove
	end

	#set to lower case part 5
	title.downcase!

	#debug lines (remove)
	puts "---"
	puts string
	puts title

	return title
end


#construct_Bi_grams method takes in a song title, splits it into individual words and creates bi-grams for the words
# => https://snippets.aktagon.com/snippets/584-generating-word-n-grams-with-ruby
# => https://www.sitepoint.com/natural-language-processing-ruby-n-grams/
# => http://www.rubyguides.com/2015/09/ngram-analysis-ruby/
def construct_Bi_grams(title)

end


#function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		IO.foreach(file_name, encoding: "utf-8") do |line|
			# do something for each line
			title = cleanup_title(line)
			construct_Bi_grams(title)
		end

		puts "Finished. Bigram model built.\n"
	rescue
		STDERR.puts "Could not open file"
		exit 4
	end
end

# Executes the program
def main_loop()
	puts "CSCI 305 Ruby Lab submitted by #{$name}"

	if ARGV.length < 1
		puts "You must specify the file name as the argument."
		exit 4
	end

	# process the file
	process_file(ARGV[0])

	# Get user input
end

if __FILE__==$0
	main_loop()
end
