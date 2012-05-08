# Glide

The glide gem is a simple wrapper around the Glide UK api to retrived quotes for individual services required in one go and sum up the totals.

# Installation

## with bundler:

    gem 'glide'

## without bundler:

    sudo gem install 'glide'

# Usage

## Set your API access key:

    Glide::api_key = "YourKeyGoesHere"

## Do a query:

	quotes = Glide.get_quote(["elec", "water", "gas"], {"water" => "SW1 0AA"}, 6, 1)

where the paramaters are as follows:

	Glide.get_quote(service, extra, period, tenants)

service: Can be one or any combination of elec, water, gas, telephone, broadband and tv_license    
extra: required additional information for certain services:
	for elec 'green', 'nogas' or 'green,nogas' is optional
	for water postcode is required
	for broadband llu24s for standard broadband or llu24p for premium broadband is required
	
=====