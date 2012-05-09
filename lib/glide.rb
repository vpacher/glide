require "glide/version"
require 'timeout'
require 'httparty'
require 'json'

module Glide
	HUMAN_NAME = {"elec" => "Electricity", "tv_license" => "TV License"}

	def self.api_key
		@@api_key ||= ""
	end

	def self.api_key=(key)
		@@api_key = key
	end

	def self.get_quote(services = ['elec'], extra = {}, period = 6, tenants = 1)
		quotes = {}
		services.each do |service|
			quotes[service] = get_service_quote(service, extra[service], period, tenants)
			quotes[service]["human_name"] = insert_human_name(service)
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

	def self.insert_human_name(service)
		HUMAN_NAME[service] || service.capitalize
	end

	def self.calculate_totals(quotes)
		quotes["total"] = {}
		["tenant_week", "tenant_month", "monthly_fee"].each do |k|
			quotes["total"][k] = "%.2f" % quotes.map { |e| e[1][k].to_f }.reduce(:+)
		end

		quotes		
	end
end
