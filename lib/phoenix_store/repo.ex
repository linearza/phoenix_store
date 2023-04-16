defmodule PhoenixStore.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_store,
    adapter: Ecto.Adapters.Postgres
end
