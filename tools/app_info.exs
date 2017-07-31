defmodule AppInfo do
  def name, do: config() |> Keyword.get(:app)
  def version, do: config() |> Keyword.get(:version)
  def distillery, do: deps() |> Keyword.has_key?(:distillery)
  def phoenix, do: deps() |> Keyword.has_key?(:phoenix)
  def phoenix_1_3 do
   deps()
   |> Keyword.get(:phoenix)
   |> elem(1)
   |> Version.match?(">= 1.3-a")
 end

  defp config, do: Mix.Project.config()
  defp deps, do: config() |> Keyword.get(:deps)

end
