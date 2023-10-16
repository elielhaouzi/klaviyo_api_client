alias KlaviyoApiClient.Events.Event
alias KlaviyoApiClient.Profiles.Profile
alias KlaviyoApiClient.Metrics.Metric

Supervisor.start_link(KlaviyoApiClient.Supervisor, [])

event = Event.new!(%{"attributes" => %{}})
metric = Metric.new!(%{"attributes" => %{"name" => "Evoluta - Started Checkout"}})
profile = Profile.new!(%{"id" => "01HCWAA8MJGZRNKHE20XJN0892"})
body =
  event
  |> put_in([Access.key!(:attributes), Access.key!(:profile)], %{data: profile})
  |> put_in([Access.key!(:attributes), Access.key!(:metric)], %{data: metric})

# KlaviyoApiClient.create_event("", %{"data" => body})
