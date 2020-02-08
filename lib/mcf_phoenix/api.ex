defmodule McfPhoenix.Api do
  @moduledoc false

  @headers [{ "X-User-ID", "2" }]

  def bins do
    url = "http://localhost:8080/api/v1/bins"
    do_request url
  end

  def move_tickets do
    url = "http://localhost:8080/api/v1/move-tickets"
    do_request url
  end

  def work_orders do
    url = "http://localhost:8080/api/v1/work-orders"
    do_request url
  end

  def users do
    url = "http://localhost:8080/api/v1/users"
    do_request url
  end

  def plants do
    url = "http://localhost:8080/api/v1/plants"
    do_request url
  end

  defp do_request(url) do
    response = HTTPoison.get!(url, @headers)
    Poison.decode!(response.body)
  end
end
