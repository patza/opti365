require 'spec_helper'

describe Opti365::Mantra do

end

describe Opti365::API do
	include Rack::Test::Methods

	def app
		Opti365::API
	end

	context '/ is not accessible' do

		it "GET / should return 404" do
			get '/'
			expect(last_response.status).to eq(404)
		end
	end

	context 'api endpoint is /mantras' do

		before {
			# File.create("/Users/pea/Documents/CODE/mantras/mantras/")
			get '/mantras'
		}

		it "GET /mantras should return 200 OK" do
			expect(last_response.status).to eq(200)
		end

		it "GET /mantras should a header Content-Type set to application/json" do
			expect(last_response.header["Content-Type"]).to eq("application/json")
		end

		it "GET /mantras should return an hash with a date and a mantra" do
			expect(JSON.parse(last_response.body).keys).to eq(["date", "mantra"])
		end	

		it "should return the date of the current day" do
			expect(JSON.parse(last_response.body)["date"]).to eq(Date.today.strftime("%d/%m"))
		end
		
		context 'api endpoint is /mantras/[:month_:day]' do
			context '1_1' do 
				before {
					get '/mantras/1_1'
				}
				it "GET /mantras should return an hash with a date and a mantra" do
					expect(JSON.parse(last_response.body).keys).to eq(["date", "mantra"])
				end		

				it "GET /mantras/1_1 should return the mantra for 1st January" do
					expect(JSON.parse(last_response.body)["mantra"]).to eq("Cop an attitude. A positive attitude, that is. Your attitude is one of the few things you have total control over. Sometimes life limits your choices, but life never limits what kind of attitude you can select. Choosing a positive attitude will change your life. It will infiltrate every aspect of who you are, what you do, and where you go. You have the power to change what you experience by changing how you think about those experiences.")
				end

				it "should return the date of the mantra passed in argument [:month_:day]" do
					expect(JSON.parse(last_response.body)["date"]).to eq("1/1")
				end
			end
			context '8_30' do 
				before {
					get '/mantras/8_30'
				}
				it "GET /mantras should return an hash with a date and a mantra" do
					expect(JSON.parse(last_response.body).keys).to eq(["date", "mantra"])
				end		

				it "GET /mantras/8_30 should return the mantra for 30th August" do
					expect(JSON.parse(last_response.body)["mantra"]).to eq("A great deal of beauty lies within you. Close your eyes and look within. Search for the beauty that's not visible to the naked eye. There is beauty in your courage, your strength, and your heart. There is beauty in your thoughts, your emotions, and your soul. Close your eyes and you will see it.")
				end

				it "should return the date (day/month) of the mantra passed in argument [:month_:day]" do
					expect(JSON.parse(last_response.body)["date"]).to eq("30/8")
				end
			end			

		end		
	end
end