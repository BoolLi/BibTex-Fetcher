require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'optparse'
require 'rest_client'

OptionParser.new do |opts|
	opts.banner = "Usage: ruby parser.rb [options]"
	opts.on('-a', '--acm', 'fetch BibTex from ACM Digital Library') do |a|
		# sample: 2512761
		url = "http://dl.acm.org/exportformats.cfm?id=#{ARGV[0]}&expformat=bibtex"
		puts ARGV[0]
		doc = Nokogiri::HTML(open(url))
		puts doc.search('pre').map{|line| line.text}
	end
	opts.on('-i', '--ieee', 'fetch BibTex from IEEE Xplore') do |a|

		RestClient.post("http://ieeexplore.ieee.org/xpl/downloadCitations", "recordIds"=> 6665065, "citations-format" => "citation-only", "download-format" => "download-bibtex", "x" => "74", "y" => "7"){|response, request, result, &block|
			if [301, 302, 307].include?(response.code)
				puts response.follow_redirection(request, result, &block)
				
			else
				response.return!(request, result, &block)
			end
		}
		#puts response.code
		#agent = Mechanize.new
		#url = ARGV[0]
		#agent.get(url) do |page|
			#download_page = page.link_with(href: "/assets/v2/html/download_citations.html").click
			#agent.click(download_page.at('#download-bibtex'))
			#result = download_page.forms[0].submit
			#puts result.mech
		#end
		#Mechanize won't work. Try Using basic HTML functions.
		
		
		
	end
end.parse!

