require 'open-uri'
require 'json'
require 'yaml'
require 'openssl'

=begin
API key: config/google.yml -> api_simple_key is required
=end

module Google

  @api_key = YAML::load(File.open((Rails.root || '../../') + 'config/google.yml'))["api_simple_key"] || ""

  def self.geocode(options = {})

    # Should do geocode or reverse geocode? (or none at all)
    if(options[:street] && options[:postalcode] && options[:city]) # geocode

      params = {
        "key" => @api_key,
        "region" => "nl",
        "components" => "country:NL|administrative_area:#{options[:city]}|postal_code:#{options[:postalcode]}",
        "address" => "#{options[:street]} #{options[:postalcode]} #{options[:city]}"
      }

      uri = "https://maps.googleapis.com/maps/api/geocode/json?#{URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))}"

      query = JSON.parse(
        open(
          uri,
          {ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE}
        ).read,
      )

      unless(query["status"] == "OK" && query["results"][0]["geometry"]["location_type"] == "ROOFTOP")
        raise Exceptions::APILimitReachedError if(query["status"] == "OVER_QUERY_LIMIT")
        raise Exceptions::InvalidLocationError if(query["status"] == "ZERO_RESULTS")
        raise Exceptions::InvalidLocationError if(query["results"][0]["geometry"]["location_type"] != "ROOFTOP")
        raise ::StandardError
      end

      options[:latitude] = query["results"][0]["geometry"]["location"]["lat"]
      options[:longitude] = query["results"][0]["geometry"]["location"]["lng"]

      return options

    elsif(options[:latitude] && options[:longitude]) # reverse geocode

      params = {
        "key" => @api_key,
        "region" => "nl",
        "latlng" => "#{options[:latitude]},#{options[:longitude]}",
        "location_type" => "ROOFTOP",
        "result_type" => "street_address"
      }

      uri = "https://maps.googleapis.com/maps/api/geocode/json?#{URI.escape(params.collect{|k,v| "#{k}=#{v}"}.join('&'))}"

      query = JSON.parse(
        open(
          uri,
          {ssl_verify_mode: ::OpenSSL::SSL::VERIFY_NONE}
        ).read,
      )

      unless(query["status"] == "OK")
        raise Exceptions::APILimitReachedError if(query["status"] == "OVER_QUERY_LIMIT")
        raise Exceptions::InvalidLocationError if(query["status"] == "ZERO_RESULTS")
        raise ::StandardError
      end

      street_number = ""
      street_route = ""

      query["results"][0]["address_components"].each do |component|

        if(component["types"].include? "administrative_area_level_2")
          options[:city] = component["long_name"]
        elsif(component["types"].include? "postal_code")
          options[:postalcode] = component["long_name"]
        elsif(component["types"].include? "street_number")
          street_number = component["long_name"]
        elsif(component["types"].include? "route")
          street_route = component["long_name"]
        end

      end

      raise Exceptions::InvalidLocationError unless(options[:city] && options[:postalcode] && street_number != "" && street_route != "")

      options[:street] = "#{street_route} #{street_number}"

      return options

    else
      raise ::ArgumentError
    end

  end

  module Exceptions
    class GoogleAPIError < ::StandardError

    end
    class InvalidLocationError < GoogleAPIError

    end
    class APILimitReachedError < GoogleAPIError

    end
  end
end

#STDOUT << Google.geocode(street: "Snoeckgensheuvel 29", city: "Amersfoort", postalcode: "3817 HK")