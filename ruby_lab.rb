
#!/usr/bin/ruby
###############################################################
#
# CSCI 305 - Ruby Programming Lab
#
# Joel Lechman
# joel1500@bresnan.net
#
###############################################################

$bigrams = Hash.new # The Bigram data structure
$name = "Joel Lechman"

def cleanup_title(string)
	#pattern = /<SEP>[\w\s]*$/s

	pattern = /<SEP>[\w\s]*$|<SEP>[\w.\s\w]*$/

	if string =~ pattern
		titleWithSEP = "#{$&}"
	end
	sepPattern = /<SEP>/
	if titleWithSEP =~ sepPattern
		title = "#{$'}"
	end
	return title
end


#pre-process to eliminate superfluous text (STEP 2)
def pre_process(string)
	#symbols that need whats inbetween them removed
	# () [] {} ""
	inBetweenPatterns = /\([\w\s.*]*\)|\[[\w\s\*]*\]|\{[\w\s\*]*\}|\"[\w\s\*]*\"/
	if string =~ inBetweenPatterns
		newString = string.gsub(inBetweenPatterns, "")
	end


	#symbols that need the full word containing them removed? or everthing after?
	# # _ / \ - : = * ` (the tilda left single quote)
	otherPatterns = /\#\w*|\#\s*|\#.*/
	#CAN THIS JUST BE /\#/???????

	#patterns that need themselves and everything after removed
	# feat. ft.
	featPatterns = //
end



# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
	begin
		IO.foreach(file_name, encoding: "utf-8") do |line|
			title = cleanup_title(line)
			puts "---"
			puts line
			puts title
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
