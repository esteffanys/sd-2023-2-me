# Leia um nome e exiba: “Olá <nome>!”;
defmodule Saudacao do
  def exibir_saudacao do
    IO.puts "Digite o nome:"
    nome = IO.gets("") |> String.trim()

    IO.puts "Olá, #{nome}!"
  end
end

