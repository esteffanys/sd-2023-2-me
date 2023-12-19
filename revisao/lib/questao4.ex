# Leia nome, peso em Kg e altura e centímetros e exiba:

defmodule InformacoesPessoa do
  def exibir_informacoes do
    IO.puts "Digite o nome:"
    nome = IO.gets("") |> String.trim()

    IO.puts "Digite o peso em Kg:"
    peso_str = IO.gets("") |> String.trim()
    peso = String.to_float(peso_str)

    IO.puts "Digite a altura em centímetros:"
    altura_cm = IO.gets("") |> String.trim() |> String.to_float()

    altura_m = altura_cm / 100.0

    imc = peso / (altura_m * altura_m)

    IO.puts "Nome: #{nome}"
    IO.puts "Peso: #{peso} Kg"
    IO.puts "Altura: #{altura_m} metros"
    IO.puts "IMC: #{imc}"
  end
end



# obs os numeros tem que ser escritos assim "68.1" e não interio