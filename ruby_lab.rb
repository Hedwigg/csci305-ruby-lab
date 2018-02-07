
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# <firstname> <lastname>
# <email-address>
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "Joel Lechman"

#takes a single string, returns a cleaned up string for further processing
def cleanup_title(string)
	#for patterns that go word word (word word)       <SEP>[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]$
	#[\w\s]*  = any # of full words
	#[-!$%^&*()_+|~=`{}\[\]:";'?,.\/] = character class

	#pattern = /<SEP>[\w\s]*$|<SEP>[\w.\s\w]*$|<SEP>\w*.\w*\s*[\w*\s]*$|<SEP>[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]$|<SEP>[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*\s*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w\s]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*$/
	#everything and titles with one (multiple words)

	pattern = /<SEP>[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*$[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*[\w*\s*]*[-!$%^&*()_+|~=`{}\[\]:";'?,.\/]*/

	#grab title
	if string =~ pattern
		titleWithSEP = "#{$&}"
	end
	sepPattern = /<SEP>/
	if titleWithSEP =~ sepPattern
		title = "#{$'}"
	end

	#cleanup said title part 2
	pat1 = /[(\{\/_:"`+=*]/
	pat2 = /\|\[|\-/
	#feat and [ -
	if title =~ pat1
		title = "#{$`}"
	end
	if title =~ pat2
		title = "#{$`}"
	end

	#eliminate characters part 3

	puts "---"
	puts string
	puts title
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
