import Config

if(Mix.env() == :dev) do
  config :klaviyo_client,
    base_url: "https://a.klaviyo.com/api",
    revision: "2023-02-22"
end
