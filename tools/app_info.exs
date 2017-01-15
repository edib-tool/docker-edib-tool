defmodule AppInfo do
  def name, do: config() |> Keyword.get(:app)
  def version, do: config() |> Keyword.get(:version)
  def distillery, do: deps() |> Keyword.has_key?(:distillery)
  def phoenix, do: deps() |> Keyword.has_key?(:phoenix)
  defp config, do: Mix.Project.config()
  defp deps, do: config() |> Keyword.get(:deps)
end
