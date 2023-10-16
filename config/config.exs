import Config

if(Mix.env() == :dev) do
  config :klaviyo_api_client,
    base_url: "https://a.klaviyo.com/api",
    revision: "2023-09-15"
end
