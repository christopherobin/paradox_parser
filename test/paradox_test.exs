defmodule MinmaxTest do
  use ExUnit.Case
  doctest ParadoxParser

  test "can parse a basic eu4 save" do
    {:ok, save_data} = ParadoxParser.read_file "test/test.eu4"
    assert 'Ottomans1447_02_14_2.eu4' == save_data['save_game']
    assert 'TUR'                      == save_data['player']
    assert 668                        == length(save_data['rebel_faction'])
  end
end
