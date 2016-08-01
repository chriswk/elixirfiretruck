defmodule ElixirFiretruck.SensuParser do
	alias ElixirFiretruck.SensuIncident, as: Incident
	alias ElixirFiretruck.SensuResult, as: Result
	def parse(jsonString) do
		Poison.decode!(jsonString, as: %Incident{last_result: %Result{}})
	end

end