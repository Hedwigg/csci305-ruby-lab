
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
					title = cleanup_title(line)
					construct_Bi_gram(title)
				end
			end
			file.close
		else
			IO.foreach(file_name, encoding: "utf-8") do |line|
				# do something for each line (if using macos or linux)
				title = cleanup_title(line)
				bi_grams = construct_Bi_gram(title)

				#for each element in the array of bi_grams
				bi_grams.each do |a|
					puts"---"
					puts a
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
