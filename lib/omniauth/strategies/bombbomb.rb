require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Bombbomb < OmniAuth::Strategies::OAuth2
      option :name, :bombbomb

      option :client_options, {
        site: "https://app.bombbomb.com",
        authorize_url: "/auth/authorize",
        token_url: "/auth/access_token"
      }

      option :scope, 'all:manage'

      uid { raw_info["info"]["user_id"] }

      def raw_info
        response = access_token.get("app/api/api.php", params: {method: "IsValidLogin"})
        @raw_info ||= JSON.parse(response.body)
      end
    end
  end
end
