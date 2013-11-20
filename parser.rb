require 'nokogiri' 
require 'open-uri' 
require 'mechanize'
require 'optparse'
require 'rest_client'

OptionParser.new do |opts|
	opts.banner = "Usage: ruby parser.rb [options]"
	
	# Fetch BibTex from ACM DL
	opts.on('-a', '--acm', 'fetch BibTex from ACM Digital Library') do |a|
		# example: 2512761
		url = "http://dl.acm.org/exportformats.cfm?id=#{ARGV[0]}&expformat=bibtex"
		puts ARGV[0]
		doc = Nokogiri::HTML(open(url))
		puts doc.search('pre').map{|line| line.text}
	end

	# Fetch BibTex from IEEE Xplore
	opts.on('-i', '--ieee', 'fetch BibTex from IEEE Xplore') do |a|
		# exsample: 6665065	
		RestClient.post("http://ieeexplore.ieee.org/xpl/downloadCitations", "recordIds"=> ARGV[0], "citations-format" => "citation-only", "download-format" => "download-bibtex", "x" => "74", "y" => "7"){|response, request, result, &block|
			if [301, 302, 307].include?(response.code)
				puts response.follow_redirection(request, result, &block)
				
			else
				response.return!(request, result, &block)
			end
		}
	end

	# Fetch BibTex from EUDL
	opts.on('-e', '--eudl', 'fetch BibTex from EUDL') do |a|
		# example: http://eudl.eu/doi/10.4108/trans.ue.1.2.e3
		url =ARGV[0]
		url = 'http://'+ url if not url.include? 'http://'
		doc = Nokogiri::HTML(open(url)) 	
		puts doc.search('pre').map{|line| line.text} 
	end

	# Fetch BibTex from Springer
	opts.on('-s', '--eudl', 'fetch BibTex from Spring') do |a|
		# example: http://link.springer.com/article/10.2478/s11696-013-0462-1
		subUrl = /link.springer.com\//.match(ARGV[0]).post_match
		url = "http://link.springer.com/export-citation/#{subUrl}.bib"
		Mechanize.new do |agent|
			puts agent.get(url).content
		end
	end


end.parse!

