class ShortenedUrlsController < ApplicationController
    def show
        token = ::Shortener::ShortenedUrl.extract_token(params[:id])
        url   = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: params)
        # do some logging, store some stats
        redirect_to url[:url], status: :moved_permanently, allow_other_host: true
    end
end
