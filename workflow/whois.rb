#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require 'alfred'
require 'resolv'

query = ARGV[0].downcase if ARGV.length > 0

Alfred.with_friendly_error do |alfred|
  begin
    names = Resolv.getnames(query)

    if names.empty?
      alfred.feedback.add_item({title: "Didn't find anything", subtitle: query})
    end

    names.each do |name|
      alfred.feedback.add_item({
        :title    => name,
        :subtitle => query,
        :arg      => name,
        :valid    => 'yes',
      })
    end
  rescue
    alfred.feedback.add_item({
      :title    => "That doesn't look like a valid IP address",
      :subtitle => query,
      :valid    => 'no',
    })
  end

  puts alfred.feedback.to_xml()
end
