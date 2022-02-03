# frozen_string_literal: true

require "nokogiri-happymapper"

# holds meta from http://ip-api.com
class IpMeta
  include HappyMapper

  tag "query"
  element :status, String, tag: "status"
  element :country, String, tag: "country"
  element :country_code, String, tag: "country_code"
  element :region, String, tag: "region"
  element :region_name, String, tag: "region_name"
  element :city, String, tag: "city"
  element :zip, Integer, tag: "zip"
  element :lat, String, tag: "lat"
  element :lon, String, tag: "lon"
  element :timezone, String, tag: "timezone"
  element :isp, String, tag: "isp"
  element :org, String, tag: "org"
  element :as, String, tag: "as"
  element :query, String, tag: "query"
end
