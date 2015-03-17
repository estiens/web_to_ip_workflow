#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'bundle/bundler/setup'
require 'alfred'
require 'resolv'

query = ARGV[0].downcase if ARGV.length > 0

Alfred.with_friendly_error do |alfred|
  begin
    ip_addresses = Resolv.getaddresses(query)

    if ip_addresses.empty?
      alfred.feedback.add_item({title: "Didn't find anything", subtitle: query})
    end

    ip_addresses.each do |address|
      alfred.feedback.add_item({
        title: address,
        subtitle: query,
        arg: address,
        valid: 'yes',
      })
    end
  rescue
    alfred.feedback.add_item({
      title: "Something went wrong :(",
      subtitle: query,
      valid: 'no',
    })
  end
  puts alfred.feedback.to_xml()
end