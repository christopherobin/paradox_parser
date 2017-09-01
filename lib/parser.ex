defmodule ParadoxParser do
  def read_file(file) do
    # Paradox files are written in european ISO, convert them
    with {:ok, content}    <- Codepagex.to_string(File.read!(file), :iso_8859_1),
         {:ok, tokens, _}  <- lex(to_charlist(content)),
         {:ok, [data | _]} <- parse(tokens),
         do: {:ok, Enum.reduce(data, %{}, &parse_list/2)}
  end

  def read_file!(file) do
    {:ok, data} = read_file(file)
    data
  end

  def read_string(content) do
    with {:ok, tokens, _}  <- lex(to_charlist(content)),
         {:ok, [data | _]} <- parse(tokens),
         do: {:ok, Enum.reduce(data, %{}, &parse_list/2)}
  end

  def read_string!(content) do
      {:ok, data} = read_string(content)
      data
    end

  defp lex(data) do
    data
      |> :paradox_lexer.string
  end

  defp parse(tokens) do
    :paradox_parser.parse(tokens)
  end

  def parse_list([:scalar, key, val], struct) do
    store(struct, key, val)
  end

  def parse_list([:vector, key, x, y, z], struct) do
    store(struct, key, {x, y, z})
  end

  def parse_list([:range, key, x, y], struct) do
    store(struct, key, x..y)
  end

  def parse_list([:stringlist, key, strings], struct) do
    store(struct, key, strings)
  end

  def parse_list([:numberlist, key, numbers], struct) do
    store(struct, key, numbers)
  end

  def parse_list([:empty, key], struct) do
    store(struct, key, %{})
  end

  def parse_list([:block, key, block], struct) do
    store(struct, key, Enum.reduce(block, %{}, &parse_list/2))
  end

  defp store(struct, key, value) do
    Map.update(struct, key, value, &[value | List.wrap(&1)])
  end
end
