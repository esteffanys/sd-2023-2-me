# Leia um nome e ano de nascimento e exiba: “Olá <nome>, você tem <idade> anos.”;
defmodule SaudacaoComIdade do
  def exibir_saudacao_com_idade do
    IO.puts "Digite o nome:"
    nome = IO.gets("") |> String.trim()

    IO.puts "Digite o ano de nascimento:"
    ano_nascimento = IO.gets("") |> String.trim() |> String.to_integer()

    idade = Date.utc_today().year() - ano_nascimento

    IO.puts "Olá, #{nome}, você tem #{idade} anos."
  end
end
