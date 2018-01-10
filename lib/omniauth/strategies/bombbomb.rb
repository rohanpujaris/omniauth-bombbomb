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

      uid { raw_info['userId'] }

      info {
        {
          first_name: raw_info['firstName'],
          last_name: raw_info['lastName'],
          email: raw_info['userName']
        }
      }

      def raw_info
        @raw_info ||= access_token.get('https://api.bombbomb.com/v2/accounts').parsed
      end
    end
  end
end
