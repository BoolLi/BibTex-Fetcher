require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'optparse'


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
		agent = Mechanize.new
		url = ARGV[0]
		agent.get(url) do |page|
			download_page = page.link_with(href: "/assets/v2/html/download_citations.html").click
			#puts download_page.form.citations-format = 'citation-only'
			agent.click(download_page.at('.button-wrap'))
		end
		
		
	end
end.parse!

