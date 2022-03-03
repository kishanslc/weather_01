defmodule WeatherWeb.ReportController do
  use WeatherWeb, :controller

  alias Weather.Accounts
  alias Weather.Accounts.Report

  action_fallback WeatherWeb.FallbackController

  def index(conn, _params) do
    reports = Accounts.list_reports()
    render(conn, "index.json", reports: reports)
  end

  def create(conn, %{"report" => report_params}) do
    with {:ok, %Report{} = report} <- Accounts.create_report(report_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.report_path(conn, :show, report))
      |> render("show.json", report: report)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Accounts.get_report!(id)
    render(conn, "show.json", report: report)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Accounts.get_report!(id)

    with {:ok, %Report{} = report} <- Accounts.update_report(report, report_params) do
      render(conn, "show.json", report: report)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Accounts.get_report!(id)

    with {:ok, %Report{}} <- Accounts.delete_report(report) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_weather(conn, %{"city" => city} = params) do
    query = Map.get(params, "query")

    result =
      Accounts.url_data(
        "api.openweathermap.org/data/2.5/weather?q=#{city}&appid=72b09714045566e07756f19a290c4457"
      )
      |> Jason.decode!()

    report =
      case query do
        nil ->
          result

        _ ->
          Map.get(result, query)
      end

    IO.inspect(query, label: "query============")

    # case HTTPoison.get(
    #        "api.openweathermap.org/data/2.5/weather?q=#{city}&appid=72b09714045566e07756f19a290c4457"
    #      ) do
    #   {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    #     IO.puts(body)

    #     body
    #     |> Jason.decode!()
    #     |> Map.get(query)
    #     |> IO.inspect(label: "result==============")

    #   {:ok, %HTTPoison.Response{status_code: 404}} ->
    #     IO.puts("Not found :(")
    #     :error

    #   {:error, %HTTPoison.Error{reason: reason}} ->
    #     IO.inspect(reason)
    #     reason
    # end

    render(conn, "show.json", report: report)
  end
end
