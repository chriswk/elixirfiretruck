defmodule ElixirFiretruck.SensuResult do
	@derive [Poison.Encoder]
	defstruct [:action, :command, :duration, :executed, :finn_app, :finn_env, :output, :teams, :tags]
end