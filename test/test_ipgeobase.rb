# frozen_string_literal: true

require "nokogiri"

require_relative "test_helper"
require_relative "../lib/ipgeobase"

class TestIpgeobase < Minitest::Test
  def setup
    @test_ip = "83.169.216.199"
    @xml_sample = File.open("./test/fixtures/ip_api_reply.xml").read
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  # rubocop:disable Metrics/MethodLength
  def test_lookup_result_has_meta_attributes
    stub_request(:get, "http://ip-api.com/xml/#{@test_ip}")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: @xml_sample, headers: {})

    ip_meta = Ipgeobase.lookup(@test_ip)

    expected_instance_variables = %i[
      @status
      @country
      @country_code
      @region
      @region_name
      @city
      @zip
      @lat
      @lon
      @timezone
      @isp
      @org
      @as
      @query
    ]

    assert_equal(ip_meta.instance_variables, expected_instance_variables)
  end

  def test_lookup_result_check_meta_data
    stub_request(:get, "http://ip-api.com/xml/#{@test_ip}")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: @xml_sample, headers: {})

    ip_meta = Ipgeobase.lookup(@test_ip)

    assert_equal ip_meta.city, "Baranchinskiy"
    assert_equal ip_meta.lat,  "58.1617"
  end

  def test_lookup_result_has_correct_query_ip
    stub_request(:get, "http://ip-api.com/xml/#{@test_ip}")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: @xml_sample, headers: {})

    ip_meta = Ipgeobase.lookup(@test_ip)

    assert_equal(ip_meta.query, @test_ip)
  end
  # rubocop:enable Metrics/MethodLength
end
