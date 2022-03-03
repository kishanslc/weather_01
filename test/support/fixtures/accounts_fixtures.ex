defmodule Weather.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Weather.Accounts` context.
  """

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{

      })
      |> Weather.Accounts.create_report()

    report
  end
end
