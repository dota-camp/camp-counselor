defmodule Counselor.Repo do
  use Ecto.Repo,
    otp_app: :counselor,
    adapter: Ecto.Adapters.Postgres
end
