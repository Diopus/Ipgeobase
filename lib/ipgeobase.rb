# frozen_string_literal: true

require "addressable/template"
require "nokogiri-happymapper"
require "open-uri"

require_relative "ipgeobase/version"

# First and last module
module Ipgeobase
  class Error < StandardError; end

  # Returns object based on meta-data from from http://ip-api.com
  # object's XML fields will be accessable through newly defined method
  #
  # @ return [?] with parsed meta-data
  #
  # @api private
  def self.lookup(ip)
    meta = get_meta(ip)
    HappyMapper.parse(meta)
  end

  # Builds address via 'Addressable'
  #
  # @ return [String] with uri-prepared address
  #
  # @api private
  def self.build_uri_address(segments)
    address_template = "http://ip-api.com{/segments*}"

    template = Addressable::Template.new(address_template)
    template.expand("segments" => segments)
  end
  private_class_method :build_uri_address

  # Returns meta-data from http://ip-api.com
  #
  # @ return [String] with XML data
  #
  # @api private
  def self.get_meta(ip)
    address = build_uri_address(["xml", ip])
    uri = URI(address)
    uri.read
  end
  private_class_method :get_meta

  def self.version
    VERSION
  end
end
