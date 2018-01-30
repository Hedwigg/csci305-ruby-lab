
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
patternSet1 = /<SEP>\w*<SEP>\w*<SEP>|<SEP>\w*<SEP>\w* \w*<SEP>|<SEP>\w*<SEP>\w* \w* \w*<SEP>|<SEP>\w*<SEP>\w* \w* \w* \w*<SEP>|<SEP>\w*<SEP>\w* \w* \w* \w* \w*<SEP>/
patternSet2 = /<SEP>\w*<SEP>\w*<SEP>|<SEP>\w*<SEP>\w*.* \w*<SEP>|<SEP>\w*<SEP>\w*.* \w*.* \w*<SEP>|<SEP>\w*<SEP>\w*.* \w*.* \w*.* \w*<SEP>|<SEP>\w*<SEP>\w*.* \w*.* \w*.* \w*.* \w*<SEP>/
patternSet3 = /<SEP>\w*<SEP>\w* .* \w* <SEP>|<SEP>\w*<SEP>.*\w* \w*.*<SEP>|<SEP>\w*<SEP>\w*.*<SEP>|<SEP>\w*<SEP>.*\w* .* \w* .* \w*.*<SEP>/
#pattern = /.*>(.*)/

if string =~ patternSet1
	title = "#{$'}"
	return title
elsif string =~ patternSet2
	title = "#{$'}"
	return title
elsif string =~ patternSet3
	title = "#{$'}"
	return title
end
else
	puts string
end

# function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

	begin
		#IO.foreach(file_name) do |line|
		IO.foreach(file_name, encoding: "utf-8") do |line|
			# do something for each line
			title = cleanup_title(line)
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
