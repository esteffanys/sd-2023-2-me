defmodule ArmazenarMatriculasNomes do

  def ler_e_armazenar do
    IO.puts "Digite o número de pares matrícula/nome a serem inseridos:"
    n = IO.gets("") |> String.trim() |> String.to_integer()

    mapa = ler_matriculas_nomes(%{}, n)

    IO.puts "Mapa armazenado:"
    IO.inspect mapa
  end

  defp ler_matriculas_nomes(mapa, 0), do: mapa
  defp ler_matriculas_nomes(mapa, n) do
    IO.puts "Digite a matrícula e o nome separados por vírgula:"
    entrada = IO.gets("") |> String.trim()

    case String.split(entrada, ",") do
      [matricula_str, nome] ->
        matricula = String.to_integer(matricula_str)
        novo_mapa = Map.put(mapa, matricula, nome)
        ler_matriculas_nomes(novo_mapa, n - 1)

      _ ->
        IO.puts "Entrada inválida. Tente novamente."
        ler_matriculas_nomes(mapa, n)
    end
  end
end

