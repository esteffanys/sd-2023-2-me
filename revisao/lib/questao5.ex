# Leia uma sequência de n números inteiros e exiba-os na ordem inversa à da leitura;

defmodule InversorSequencia do
  def ler_e_exibir_inverso do
    IO.puts "Digite a sequência de números inteiros separados por espaço:"
    sequencia = IO.gets("") |> String.trim() |> String.split(~r/\s+/, trim: true) |> Enum.reverse()

    IO.puts "Sequência na ordem inversa:"
    Enum.each(sequencia, &IO.puts/1)
  end
end

