defmodule ElixirFiretruck.SensuIncident do
	@derive [Poison.Encoder]
	defstruct [:check, :client, :dc, :last_execution, :last_result]
end