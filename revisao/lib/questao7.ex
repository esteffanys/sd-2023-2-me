defmodule Poligono do
  defstruct pontos: %{}

  def principal do
    loop(%Poligono{})
  end

  def loop(poligono) do
    IO.puts """
    Sistema Final
    =============
    1. Criar
    2. Listar
    3. Atualizar
    4. Excluir
    5. Sair
    """

    IO.puts "Entre com sua opção: "
    opcao = IO.gets("") |> String.trim |> String.to_integer()

    case opcao do
      1 -> criar(poligono)
      2 -> listar(poligono)
      3 -> atualizar(poligono)
      4 -> excluir(poligono)
      5 -> sair()
      _ -> 
        IO.puts "Opção inválida. Tente novamente."
        loop(poligono)
    end
  end

  def criar(poligono) do
    IO.puts "Digite as coordenadas x e y do ponto (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        novo_poligono = %Poligono{poligono | pontos: Map.put(poligono.pontos, {x, y}, true)}
        IO.puts "Ponto criado com sucesso!"
        loop(novo_poligono)
      _ ->
        IO.puts "Entrada inválida. Tente novamente."
        criar(poligono)
    end
  end

  def listar(%Poligono{pontos: pontos}) do
    IO.puts "Pontos cadastrados:"
    Enum.each(pontos, &exibir_ponto/1)
    loop(%Poligono{pontos: pontos})
  end

  def atualizar(poligono) do
    IO.puts "Digite as coordenadas x e y do ponto a ser atualizado (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        if Map.has_key?(poligono.pontos, {x, y}) do
          IO.puts "Digite as novas coordenadas (separadas por espaço):"
          case IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1) do
            [novo_x, novo_y] ->
              novo_poligono = %Poligono{poligono | pontos: Map.update(poligono.pontos, {x, y}, true, fn _ -> {novo_x, novo_y} end)}
              IO.puts "Ponto atualizado com sucesso!"
              loop(novo_poligono)
            _ ->
              IO.puts "Entrada inválida. Tente novamente."
              atualizar(poligono)
          end
        else
          IO.puts "Ponto não encontrado. Tente novamente."
          atualizar(poligono)
        end
      _ ->
        IO.puts "Entrada inválida."
        atualizar(poligono)
    end
  end

  def excluir(poligono) do
    IO.puts "Digite as coordenadas x e y do ponto a ser excluído (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        if Map.has_key?(poligono.pontos, {x, y}) do
          novo_poligono = %Poligono{poligono | pontos: Map.delete(poligono.pontos, {x, y})}
          IO.puts "Ponto excluído!"
          loop(novo_poligono)
        else
          IO.puts "Ponto não encontrado."
          excluir(poligono)
        end
      _ ->
        IO.puts "Entrada inválida."
        excluir(poligono)
    end
  end

  def sair do
    IO.puts "Sistema encerrado."
    :ok
  end

  defp exibir_ponto({x, y}) do
  IO.puts "Ponto: {#{inspect x}, #{inspect y}}"
end

end

# Inicie o programa chamando a função principal
#entre na pasta lib e escreva elixir questao7.ex
#deixe o comentario quando for usar o iex -S mix
#Poligono.principal()