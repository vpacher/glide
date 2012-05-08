require "glide/version"
require 'timeout'
require 'httparty'
require 'json'

module Glide
	@@api_key = ""

	def self.api_key
		@@api_key
	end

	def self.api_key=(key)
		@@api_key = key
	end

	def self.get_quote(services = ['elec'], extra = {}, period = 6, tenants = 1)
		quotes = {}
		services.each do |service|
			quotes[service] = get_service_quote(service, extra[service], period, tenants)
		end
		calculate_totals(quotes)
	end

	def self.get_service_quote(service, extra, period, tenants)
		res = Timeout::timeout(5) { HTTParty.get("https://api.glide.uk.com/signup/servicePrice.json", :query => {:service => service, :period => period, :extra => extra, :tenants => tenants, :key => api_key}) }
		JSON.parse(res.body)["results"]
	rescue Timeout::Error => e
		{"message" => "A timeout error has occured", "error" => 2}
	rescue
		{"message" => "An error has occured", "error" => 3}
	end

	def self.calculate_totals(quotes)
		quotes["total"] = {}
		quotes["total"]["tenant_week"] = quotes.map { |e| e[1]["tenant_week"].to_f }.reduce(:+).to_s
		quotes["total"]["tenant_month"] = quotes.map { |e| e[1]["tenant_month"].to_f }.reduce(:+).to_s
		quotes["total"]["monthly_fee"] = quotes.map { |e| e[1]["monthly_fee"].to_f }.reduce(:+).to_s

		quotes		
	end
end
