defmodule AppInfo do
  def name, do: config() |> Dict.get(:app)
  def version, do: config() |> Dict.get(:version)
  def distillery, do: deps() |> Dict.has_key?(:distillery)
  def phoenix, do: deps() |> Dict.has_key?(:phoenix)
  defp config, do: Mix.Project.config()
  defp deps, do: config() |> Dict.get(:deps)
end
