
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
	/<SEP>[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*$[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*|<SEP>[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/][\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/][\w*\s*]*/
	title = ""

	#grab title (only grabs english titles)
	if string =~ pattern
		titleWithSEP = "#{$&}"
	end
	sepPattern = /<SEP>/
	if titleWithSEP =~ sepPattern	#Remove Preceding <SEP>
		title = "#{$'}"
	end

	#cleanup said title part 2
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

	#puts "---"
	#puts string
	#puts title
	return title
end

#function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		IO.foreach(file_name, encoding: "utf-8") do |line|
			# do something for each line
			cleanup_title(line)
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
