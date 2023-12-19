defmodule SistemaPontos2D do
  defstruct x: 0, y: 0

  def main do
    IO.puts("Bem-vindo ao Sistema de Gerenciamento de Pontos 2D!")
    exibir_menu([])
  end

  def exibir_menu(banco_dados) do
    IO.puts("Escolha uma opção:")
    IO.puts("1. Criar ponto")
    IO.puts("2. Listar pontos")
    IO.puts("3. Atualizar ponto")
    IO.puts("4. Excluir ponto")
    IO.puts("5. Sair")

    escolher_opcao(banco_dados)
  end

  def escolher_opcao(banco_dados) do
    case IO.read(:line) |> String.trim() do
      "1" -> criar(banco_dados)
      "2" -> listar(banco_dados)
      "3" -> atualizar(banco_dados)
      "4" -> excluir(banco_dados)
      "5" -> sair()
      _ -> 
        IO.puts("Opção inválida. Tente novamente.")
        exibir_menu(banco_dados)
    end
  end

  def criar(banco_dados) do
    IO.puts("Digite as coordenadas (X Y):")
    {x, y} = ler_coordenadas()

    ponto = %SistemaPontos2D{x: x, y: y}
    novo_banco_dados = [ponto | banco_dados]

    IO.puts("Ponto criado com sucesso!")
    exibir_menu(novo_banco_dados)
  end

  defp listar_pontos([]) do
    IO.puts("Nenhum ponto cadastrado.")
    exibir_menu([])
  end

  defp listar_pontos([ponto | resto]) do
    IO.puts("X: #{ponto.x}, Y: #{ponto.y}")
    listar_pontos(resto)
  end

  def listar(banco_dados) do
    IO.puts("Pontos cadastrados:")
    listar_pontos(banco_dados)
  end

 def atualizar(banco_dados) do
  IO.puts("Pontos cadastrados:")
  listar_pontos(banco_dados)
  IO.puts("Digite o índice do ponto a ser atualizado:")
  
  case IO.read(:line) |> String.trim() |> String.to_integer() |> ponto_valido?(banco_dados) do
    {:ok, indice} ->
      IO.puts("Digite as novas coordenadas (X Y):")
      {x, y} = ler_coordenadas()
      
      ponto_atualizado = %SistemaPontos2D{x: x, y: y}
      lista_atualizada = List.replace_at(banco_dados, indice, ponto_atualizado)

      IO.puts("Ponto atualizado com sucesso!")
      exibir_menu(lista_atualizada)

    {:error, _} ->
      IO.puts("Índice inválido. Tente novamente.")
      atualizar(banco_dados)
  end
end

defp ponto_valido?(indice, banco_dados) do
  if indice > 0 && indice <= length(banco_dados) do
    {:ok, indice - 1}
  else
    {:error, indice}
  end
end

  def excluir(banco_dados) do
    IO.puts("Pontos cadastrados:")
    listar_pontos(banco_dados)
    IO.puts("Digite o índice do ponto a ser excluído:")
    indice = IO.read(:line) |> String.trim() |> String.to_integer()

    lista_atualizada = List.delete_at(banco_dados, indice - 1)

    IO.puts("Ponto excluído com sucesso!")
    exibir_menu(lista_atualizada)
  end

  defp sair do
    IO.puts("Sistema encerrado. Adeus!")
    :ok
  end

  defp ler_coordenadas do
    [x, y] =
      IO.read(:line)
      |> String.trim()
      |> String.split(~r/\s+/)
      |> Enum.map(&String.to_integer/1)

    {x, y}
  end
end

