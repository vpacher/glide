require "glide/version"
require 'timeout'
require 'httparty'
require 'json'

module Glide

	def self.get_qote(services = ['elec'], extra = {}, period = 6, tenants = 1)
		quotes = {}
		services.each do |service|
			quotes[service] = get_service_quote(service, extra[service], period, tenants)
		end
		quotes
	end

	def self.get_service_quote(service, extra, period, tenants)
		res = Timeout::timeout(5) { HTTParty.get("https://api.glide.uk.com/signup/servicePrice.json", :query => {:service => service, :period => period, :extra => extra, :tenants => tenants, :key => GLIDE_API_KEY}) }
		if res.code == 200
			JSON.parse(res.body)
		end

	end
end
