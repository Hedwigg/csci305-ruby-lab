
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
	title = ""
	#looking for the third <SEP> by looking for the <SEP> pattern 3 times, each time setting the new title to everything to the right of the pattern.
	#this effectively extracts just the song title from the line
	sep_pattern = /<SEP>/
	if string =~ sep_pattern
		title = "#{$'}"
	end
	if title =~ sep_pattern
		title = "#{$'}"
	end
	if title =~ sep_pattern
		title = "#{$'}"
	end

	#cleanup said title part 2
	#pat1 are regular expressions identifying superflous text as stated in the instructions
	part2 = /[(\{\/:"`+=*]|feat.|\[|\-/
	#if the title contains any superfluous text, we just want whatever comes before said text using: (#{$`})
	if title =~ part2
		title = "#{$`}"
	end

	#eliminate characters part 3
	#finding and deleting the following punctuation: ?  ¿  !  ¡  .  ;  &  @  %  #  |
	punctuation = /[?¿!¡.;&@%#|_]/
	if title =~ punctuation
		title.gsub!(punctuation, "") #replace with empty string to remove
	end

	#set to lower case part 5
	title.downcase!


	return title
end


#construct_Bi_grams method takes in a song title, creates bi-grams for the words
#use each_cons method define in the Enumerable module, returns an arry of bigrams for the inputted title
def construct_Bi_gram(title)
	b_gram = title.split(' ').each_cons(2).to_a
	return b_gram

end


#function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "
	#empty hash table used for storing bigrams (all initial values = 0)
	hash = Hash.new(0)

	begin
		if RUBY_PLATFORM.downcase.include? 'mswin'
			file = File.open(file_name)
			unless file.eof?
				file.each_line do |line|
					# do something for each line (if using windows)
				end
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# do something for each line (if using macos or linux)
				title = cleanup_title(line)
				bi_grams = construct_Bi_gram(title)

				 bi_grams.each do |a|
				 	puts"___"
				 	puts a[0]
				 	puts a[1]
					puts"-"
					puts a.inspect
					#if the key exists, increment
					#if #hash.key(bigram)
						#puts "hash contains key"
					#else #else add the key
						#hash[<key>] = value
						#puts "nokey"
					#end
				end
				#debug lines
				#puts "hash length"
				#puts hash.length
			end
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
