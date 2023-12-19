defmodule Revisao do
  @moduledoc """
  Documentation for Revisao.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Revisao.hello()
      :world

  """
  def hello do
    :world
  end
end

# gerar nome 
defmodule GeradorMatriculasNomes do
  def gerar_matriculas_nomes(n) do
    dados_exemplo =
      Enum.map(1..n, fn _ ->
        matricula = gerar_matricula()
        nome = gerar_nome()
        "#{matricula},#{nome}"
      end)

    IO.puts Enum.join(dados_exemplo, "\n")
  end

  defp gerar_matricula() do
    :rand.uniform(9000) + 1000
  end

  defp gerar_nome() do
    Enum.random(["João", "Maria", "Carlos", "Ana", "Pedro", "Laura"])
  end
end

# Gere 5 pares de matrícula/nome como exemplo e exiba-os separados por vírgula
GeradorMatriculasNomes.gerar_matriculas_nomes(5)