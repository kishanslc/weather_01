defmodule Weather.Weather do
  def get_weather(city) do
    HTTPoison.get(
      "api.openweathermap.org/data/2.5/weather?q=#{city}&appid=72b09714045566e07756f19a290c4457"
    )
    |> IO.inspect(label: "kishan")

    case HTTPoison.get(
           "api.openweathermap.org/data/2.5/weather?q=#{city}&appid=72b09714045566e07756f19a290c4457"
         ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
