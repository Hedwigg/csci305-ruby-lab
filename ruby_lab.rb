
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
	part2 = /[(\[\{\/:"`+\-_=*\\]|feat./
	#if the title contains any superfluous text, we just want whatever comes before said text using: (#{$`})
	if title =~ part2
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
	return title
end

#function that takes a title and creates bigrams for the words in title.
def construct_bigram(title)
	#eliminate stop words before creating bigram counts
	pattern = /a\b|an\b|and\b|by\b|for\b|from\b|in\b|of\b|on\b|or\b|out\b|the\b|to\b|with\b/ #\b to match the end of the word so it doesnt grab an when the word is and
	title.gsub!(pattern,"")

	title_array = title.split #split the title by words. (splits by spaces by default)

	for i in 0..title_array.length-2
		$bigrams[title_array[i]]
		if $bigrams[title_array[i]] == nil #when the key/second hash does not exist, create a new one and initialize to 0 so we can increment
			$bigrams[title_array[i]] = Hash.new(0)
		end
		#increment value for the key by one
		$bigrams[title_array[i]][title_array[i+1]] += 1
	end
end


#Function to find the most_common key/word that follows the passed in word. returns the most common word/key
#most common is defined by the value of the hash key.
def mcw(keyWord)

	highest_value = 0	 	#variable to keep track of what the highest value currently is.
	most_common_key = "" #most common key
	$bigrams[keyWord].each do |key, value|
		if value > highest_value	#if current value is higher, set highest to said value
			highest_value = value	#update the highest value
			most_common_key = key	#update most common key (mcw)
		end
	end
	return most_common_key
end

#produces the most probably title based on the most common key/word that follows the previous word.
def create_title(startingWord)
	begin															#rescue block for catching when there is not another word after
		finalTitle = startingWord
		length = 0
		previous = startingWord
		used = Array.new #an array for storing words we have used before (in an attempt to fix repeating titles)

		while length < 99999	#maximum of 20 words to start, 99999 after the repetition fix
			current = mcw(previous)	#getting the next word in the sequence #has to be done before the repeat check

			if(used.include?(current))	#if the word has been used before, we dont want the repeating pattern so we will stop adding to the title.
				break												#this still allows for one repeated word because it makes some titles funny. ex.
			else
				used.push(current)	#if the word hasnt been used yet, mark it as used by putting it in the used array
			end

			if (current != "" && current != nil)	#while the next string has another word after it
				length += 1
				finalTitle <<" "	#catonate a space
				finalTitle << current	#catonate the current word
				previous = current	#reset for previous
			else
				length = 20	#there wasnt a next word
			end
		end
		return finalTitle
	rescue													#rescue block for catching when there is not another word after
		return finalTitle
	end
end

#function to process each line of a file and extract the song titles
def process_file(file_name)
	puts "Processing File.... "

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
				construct_bigram(title)
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
	input = ""
	while input != "q*"	#while the input is not q:
	 	puts "Enter a word [Enter 'q*' to quit]:"
	 	input = STDIN.gets.chomp
	 	puts create_title(input)	#output the created title
	 end
	 puts "---program end---"
end

if __FILE__==$0
	main_loop()
end
