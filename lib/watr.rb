require "rubygems"
require "httparty"
require "json"

class Watr 
  include HTTParty
  #debug_output $stderr

  base_uri "http://waterservices.usgs.gov/nwis/iv"

  default_params :format => "json"

  def find_by_state(state, params = {})
    response = self.class.get("/", :query => {"stateCd" => state}.merge(params))
    check_response(response)
    return response
  end

  def find(id, params = {})
    response = self.class.get("/", :query => {"sites" => id}.merge(params))
    check_response(response)
    return response
  end

  protected
    def check_response(response)
      if response.code != 200
        raise "Error calling USGS API: #{response}"
      end
    end
end
