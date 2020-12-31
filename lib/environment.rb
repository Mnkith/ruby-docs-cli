#!/usr/local/bin/ruby

require 'nokogiri'
require 'open-uri'
require 'colorize'
# require 'pry'

require_relative './ruby_docs_cli/version'
require_relative './scraper.rb'
require_relative './valid.rb'
require_relative './models/klass'
require_relative './models/mmethod'
require_relative './cli'
