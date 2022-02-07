defmodule Counselor.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CounselorDiscord.Consumer
    ]

    opts = [strategy: :one_for_one, name: Counselor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
