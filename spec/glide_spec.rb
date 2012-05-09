require 'glide'

describe Glide do 

	# RESPONSE
	let(:response_elec) { Marshal.load("\004\bo:\027HTTParty::Response\n:\r@headerso: HTTParty::Response::Headers\006:\f@header{\017\"\vserver[\006\"\vApache\"\tdate[\006\"\"Sun, 06 May 2012 16:19:40 GMT\"\fexpires[\006\"\"Thu, 19 Nov 1981 08:52:00 GMT\"\vpragma[\006\"\rno-cache\"\023content-length[\006\"\b113\"\021content-type[\006\"\025application/json\"\017connection[\006\"\nclose\"\017set-cookie[\a\"9symfony=2n594frr1c83aldiloljk7erq3; path=/; HttpOnly\"9symfony=6pvq9hfd8elj5n8j2m5ij9kkp7; path=/; HttpOnly\"\022cache-control[\006\"\rno-cache\"\vx-farm[\006\"\nHTTPS:\025@parsed_response{\a\"\fversion\"\rv3.1.1.5\"\fresults{\t\"\020monthly_fee\"\n30.20\"\020tenant_week\"\t6.97\"\nnotes0\"\021tenant_month\"\n30.20:\r@requesto:\026HTTParty::Request\v:\016@last_urio:\017URI::HTTPS\017:\016@fragment0:\n@porti\002\273\001:\n@path\"\036/signup/servicePrice.json:\016@registry0:\016@password0:\f@opaque0:\n@user0:\v@query\"\002/\001key=1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z&period=6&extra=&service=elec&tenants=1&key=1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z&period=6&extra=&service=elec&tenants=1&key=1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z&period=6&extra=&service=elec&tenants=1&key=1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z&period=6&extra=&service=elec&tenants=1:\n@host\"\025api.glide.uk.com:\f@scheme\"\nhttps:\r@options{\n:\025follow_redirectsT:\023default_params{\000:\vparserc\025HTTParty::Parser:\nquery{\n:\bkey\"%1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z:\nextra0:\vperiodi\v:\fservice\"\telec:\ftenantsi\006:\nlimiti\n;\020@4:\021@raw_requesto:\023Net::HTTP::Get\f:\021@body_stream0;\020\"j/signup/servicePrice.json?key=1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z&period=6&extra=&service=elec&tenants=1:\n@body0;\b{\a\"\017connection[\006\"\nclose\"\thost[\006\"\025api.glide.uk.com:\027@response_has_bodyT:\026@request_has_bodyF:\f@method\"\bGET:\021@http_methodc\023Net::HTTP::Get:\023@last_responseo:\020Net::HTTPOK\r:\022@http_version\"\b1.1:\020@body_existT:\f@socket0;&\"v{\"results\":{\"monthly_fee\":\"30.20\",\"tenant_week\":\"6.97\",\"tenant_month\":\"30.20\",\"notes\":null},\"version\":\"v3.1.1.5\"};\b{\017@\b@\t@\024@\025@\021@\022@\016@\017@\v@\f@\027@\030@\032@\e@!@\"@\035@\036@$@%:\r@message\"\aOK:\n@code\"\b200:\n@readT;&@L:\016@response@J") }

	before do
		Glide::api_key = "ABC"
	end
	
	describe "get_quote" do 

		it 'should return a hash' do
			HTTParty.should_receive(:get).exactly(6).times.and_return(response_elec)
			quotes = Glide.get_quote(services = ["elec", "water", "gas", "telephone", "broadband", "tv_license"])
			quotes.should be_an_instance_of(Hash)
			quotes["elec"]["monthly_fee"].should eql("30.20")
			quotes["water"]["tenant_month"].should eql("30.20")
			quotes["total"]["monthly_fee"].should eql("181.20")
			quotes["total"]["tenant_week"].should eql("41.82")
			quotes["total"]["tenant_month"].should eql("181.20")
		end

	end
	
	describe "get_service_quote" do
	
		it 'should respond with HTTParty response and convert to json' do
			HTTParty.should_receive(:get).and_return(response_elec)
			# HTTParty.should_receive(:get) do |args|
			# 	args[1][:query][:service].should eql("elec")
			# 	return response_elec
			# end	
			Glide.get_service_quote("elec", nil, 6, 1).should eql({"monthly_fee"=>"30.20", "tenant_week"=>"6.97", "notes"=>nil, "tenant_month"=>"30.20"})
		end

		it 'should handle timeout errors' do
			HTTParty.should_receive(:get).and_raise(Timeout::Error)
			Glide.get_service_quote("elec", nil, 6, 1).should eql({"message" => "A timeout error has occured", "error" => 2})
		end

		it 'should handle errors' do
			HTTParty.should_receive(:get).and_raise(ZeroDivisionError)
			Glide.get_service_quote("water", nil, 6, 1).should eql({"message" => "An error has occured", "error" => 3})
		end
	end

	describe "calculate_totals" do
		it "should return totals as new element in hash" do
			quotes = {"elec" => {"monthly_fee"=>"30.20", "tenant_week"=>"6.97", "notes"=>nil, "tenant_month"=>"30.20"}, "water" => {"monthly_fee"=>"30.20", "tenant_week"=>"6.97", "notes"=>nil, "tenant_month"=>"30.20"}}
			rt = Glide.calculate_totals(quotes)
			rt["total"]["monthly_fee"].should eql("60.40")
			rt["total"]["tenant_week"].should eql("13.94")
			rt["total"]["tenant_month"].should eql("60.40")
		end
	end

end