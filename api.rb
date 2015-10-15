require_relative 'mantra'

module Opti365
	
	class API < Grape::API

		format :json

		resources :mantras do
			
			desc "Returns the mantra of the day" do
				detail 'easy at first'
			end
			get '/' do
				Mantra.today
			end

			desc 'Return a mantra.'
      params do
        requires :id, type: String, desc: 'Mantra id : month_day'
      end
      route_param :id do
        get do
          Mantra.find(params[:id])
        end
      end

		end

	end
end