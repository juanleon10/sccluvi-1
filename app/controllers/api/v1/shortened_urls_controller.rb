class Api::V1::ShortenedUrlsController < ApplicationController

    require 'uri'
    require 'net/http'
    require 'cgi'
    require 'socket'

    def new
        rank = get_rank params[:url]
        data = Shortener::ShortenedUrl.generate(params[:url])
        render json: [
            # 'data': data, 
            'url': data.url,
            'unique_key': data.unique_key,
            'use_count': data.use_count,
            'shortener': "#{request.base_url}/#{data.unique_key}",
            'rank': rank
        ]
    end
    
    private

    def get_rank url
        url = URI("https://awis.api.alexa.com/api?Action=UrlInfo&ResponseGroup=Rank&Output=json&Url=#{url}")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-api-key"] = '8T7SlYd7Tp16a9VPBovC26LXGhosXjeM97CLbUUv'
        request["cache-control"] = 'no-cache'

        response = http.request(request)
        json_response = JSON.parse(response.body)
        json_response['Awis']['Results']['Result']['Alexa']['TrafficData']['Rank']
    end

end
