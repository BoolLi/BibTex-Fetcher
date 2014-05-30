#BibTex Fetcher

A simple program written in Ruby to fetch BibTex from different digital libraries.

##How to install:
run

    bundle install

which will install all the dependencies.

##Usage:

    ruby parser.rb [options] your_URL

    -a, --acm                        fetch BibTex from ACM Digital Library

    -i, --ieee                       fetch BibTex from IEEE Xplore

    -e, --eudl                       fetch BibTex from EUDL

    -s, --springer                   fetch BibTex from Spring

The program will output the Bibtex in HTML format. Note that if you run the command in command line, you might want to escape the "=" and "&" characters in the URL.

##Examples:

###From ACM Digiral Library:
    ruby parser.rb -a http://dl.acm.org/citation.cfm?id\=544220.544241\&coll\=DL\&dl\=ACM\&CFID\=468547649\&CFTOKEN\=32770262

###From IEEE Xplore:
    ruby parser.rb -i http://ieeexplore.ieee.org/xpl/articleDetails.jsp?tp\=\&arnumber\=6112362\&queryText%3Dns3

###From EUDL:
    ruby parser.rb -e http://eudl.eu/doi/10.4108/trans.ue.1.2.e3

###From Springer:
    ruby parser.rb -s http://link.springer.com/article/10.2478/s11696-013-0462-1

# License
Copyright (c) 2014 Li Li(BoolLi, http://boolli.github.io/), under the
[MIT license](http://www.opensource.org/licenses/mit-license.php).
