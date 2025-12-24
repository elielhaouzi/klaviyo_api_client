# alias KlaviyoApiClient.Events.Event
# alias KlaviyoApiClient.Profiles.Profile
# alias KlaviyoApiClient.Metrics.Metric
alias KlaviyoApiClient.ProfileSubscriptions.ProfileSubscriptionBulkCreateJob

# event = Event.new!(%{"attributes" => %{}})
# metric = Metric.new!(%{"attributes" => %{"name" => "Evoluta - Started Checkout"}})
# profile = Profile.new!(%{"id" => "01HCWAA8MJGZRNKHE20XJN0892"})

# body =
#   event
#   |> put_in([Access.key!(:attributes), Access.key!(:profile)], %{data: profile})
#   |> put_in([Access.key!(:attributes), Access.key!(:metric)], %{data: metric})

# KlaviyoApiClient.create_event("", %{"data" => body})

profile_subscription_bulk_create_job =
  ProfileSubscriptionBulkCreateJob.new!(%{
    "attributes" => %{
      "custom_source" => "evoluta",
      "historical_import" => true,
      "profiles" => %{
        "data" => [
          %{
            "id" => "01HQP6PY927A1C0MR4JTFCQXSH",
            "type" => "profile",
            "attributes" => %{
              "email" => "eliel.haouzi@gmail.com",
              "phone_number" => "+33755541180",
              "subscriptions" => %{
                "email" => %{
                  "marketing" => %{
                    "consent" => "SUBSCRIBED",
                    "consented_at" => "2025-09-21"
                  }
                },
                "sms" => %{
                  "marketing" => %{
                    "consent" => "SUBSCRIBED",
                    "consented_at" => "2025-09-21"
                  }
                }
              }
            }
          }
        ]
      }
    }
  })
  |> Map.from_struct()

dbg(%{
  "data" => [profile_subscription_bulk_create_job]
})

KlaviyoApiClient.subscribe_profiles("", %{
  "data" => profile_subscription_bulk_create_job
})
