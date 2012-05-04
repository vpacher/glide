require 'glide'

describe Glide do 
	before do
		GLIDE_API_KEY = "1O3N6dk0jENDVGIO44WDUbLT7AIG8W6Z"
	end
	it 'should return a hash' do
		Glide.get_qote.should be_an_instance_of(Hash)
	end
	
end