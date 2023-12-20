defmodule Figura2D do
  defstruct pontos: %{}

  def principal do
    loop(%Figura2D{})
  end

  def loop(figura) do
    IO.puts """
    Sistema de Figura 2D
    ====================
    1. Criar
    2. Listar
    3. Atualizar
    4. Excluir
    5. Translação
    6. Escala ("Zoom")
    7. Rotação
    8. Reflexão
    9. Sair
    """

    IO.puts "Entre com sua opção: "
    opcao = IO.gets("") |> String.trim |> String.to_integer()

    case opcao do
      1 -> criar(figura)
      2 -> listar(figura)
      3 -> atualizar(figura)
      4 -> excluir(figura)
      5 -> translacao(figura)
      6 -> escala(figura)
      7 -> rotacao(figura)
      8 -> reflexao(figura)
      9 -> sair()
      _ -> 
        IO.puts "Opção inválida. Tente novamente."
        loop(figura)
    end
  end

  def criar(figura) do
    IO.puts "Digite as coordenadas x e y do ponto (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        nova_figura = %Figura2D{figura | pontos: Map.put(figura.pontos, {x, y}, true)}
        IO.puts "Ponto criado com sucesso!"
        loop(nova_figura)
      _ ->
        IO.puts "Entrada inválida. Tente novamente."
        criar(figura)
    end
  end

  def listar(%Figura2D{pontos: pontos}) do
    IO.puts "Pontos cadastrados:"
    Enum.each(pontos, &exibir_ponto/1)
    loop(%Figura2D{pontos: pontos})
  end

  def atualizar(figura) do
    IO.puts "Digite as coordenadas x e y do ponto a ser atualizado (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        if Map.has_key?(figura.pontos, {x, y}) do
          IO.puts "Digite as novas coordenadas (separadas por espaço):"
          case IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1) do
            [novo_x, novo_y] ->
              nova_figura = %Figura2D{figura | pontos: Map.update(figura.pontos, {x, y}, true, fn _ -> {novo_x, novo_y} end)}
              IO.puts "Ponto atualizado com sucesso!"
              loop(nova_figura)
            _ ->
              IO.puts "Entrada inválida. Tente novamente."
              atualizar(figura)
          end
        else
          IO.puts "Ponto não encontrado. Tente novamente."
          atualizar(figura)
        end
      _ ->
        IO.puts "Entrada inválida."
        atualizar(figura)
    end
  end

  def excluir(figura) do
    IO.puts "Digite as coordenadas x e y do ponto a ser excluído (separadas por espaço): "
    entrada = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)

    case entrada do
      [x, y] ->
        if Map.has_key?(figura.pontos, {x, y}) do
          nova_figura = %Figura2D{figura | pontos: Map.delete(figura.pontos, {x, y})}
          IO.puts "Ponto excluído!"
          loop(nova_figura)
        else
          IO.puts "Ponto não encontrado."
          excluir(figura)
        end
      _ ->
        IO.puts "Entrada inválida."
        excluir(figura)
    end
  end

  def translacao(figura) do
    IO.puts "Digite o vetor de translação (separado por espaço, ex: 2 3): "
    translacao = obter_coordenadas()

    nova_figura = %Figura2D{figura | pontos: transladar_pontos(figura.pontos, translacao)}
    IO.puts "Translação realizada com sucesso!"
    loop(nova_figura)
  end

  def escala(figura) do
    IO.puts "Digite o fator de escala (separado por espaço, ex: 2 3): "
    fator_escala = obter_coordenadas()

    nova_figura = %Figura2D{figura | pontos: escalar_pontos(figura.pontos, fator_escala)}
    IO.puts "Escala realizada com sucesso!"
    loop(nova_figura)
  end
 # ta dando erro aki
 def rotacao(figura) do
  IO.puts "Digite o ângulo de rotação em graus: "
  case String.to_float(IO.gets("") |> String.trim()) do
    {:ok, angulo_rotacao} when is_float(angulo_rotacao) ->
      nova_figura = %Figura2D{figura | pontos: rotacionar_pontos(figura.pontos, angulo_rotacao)}
      IO.puts "Rotação realizada com sucesso!"
      Figura2D.loop(nova_figura)
    _ ->
      IO.puts "Entrada inválida. O ângulo deve ser um número válido."
      Figura2D.loop(figura)
  end
end


  def reflexao(figura) do
    IO.puts "Escolha o eixo de reflexão (X ou Y): "
    eixo = IO.gets("") |> String.trim |> String.upcase()

    nova_figura = %Figura2D{figura | pontos: refletir_pontos(figura.pontos, eixo)}
    IO.puts "Reflexão realizada com sucesso!"
    loop(nova_figura)
  end

  def sair do
    IO.puts "Sistema encerrado."
    :ok
  end

  defp obter_coordenadas do
     IO.puts "Formato esperado: x y"
     [x, y] = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)
    {x, y}
end

  defp transladar_pontos(pontos, translacao) do
     Map.keys(pontos)
     |> Enum.map(fn {x, y} -> {x + hd(translacao), y + tl(translacao)} end)
     |> Enum.zip(Map.values(pontos))
     |> Map.new()
  end

  defp escalar_pontos(pontos, fator_escala) do
    Map.keys(pontos)
    |> Enum.map(fn {x, y} -> {x * hd(fator_escala), y * tl(fator_escala)} end)
    |> Enum.zip(Map.values(pontos))
    |> Map.new()
  end

  defp rotacionar_pontos(pontos, angulo_rotacao) do
    angulo_rad = :math.radians(angulo_rotacao)
    Map.keys(pontos)
    |> Enum.map(fn {x, y} ->
      {round(x * :math.cos(angulo_rad) - y * :math.sin(angulo_rad)),
       round(x * :math.sin(angulo_rad) + y * :math.cos(angulo_rad))}
    end)
    |> Enum.zip(Map.values(pontos))
    |> Map.new()
  end

  defp refletir_pontos(pontos, "X") do
    Map.keys(pontos)
    |> Enum.map(fn {x, y} -> {x, -y} end)
    |> Enum.zip(Map.values(pontos))
    |> Map.new()
  end

  defp refletir_pontos(pontos, "Y") do
    Map.keys(pontos)
    |> Enum.map(fn {x, y} -> {-x, y} end)
    |> Enum.zip(Map.values(pontos))
    |> Map.new()
  end

  defp refletir_pontos(_, _) do
    IO.puts "Opção de eixo inválida. Tente novamente."
    %{}
  end

  defp exibir_ponto({x, y}) do
    IO.puts "Ponto:  {#{inspect x}, #{inspect y}}"
  end
end

Figura2D.principal()
