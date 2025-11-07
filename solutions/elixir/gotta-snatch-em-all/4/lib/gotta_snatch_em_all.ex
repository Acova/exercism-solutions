defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {
      MapSet.member?(collection, card),
      MapSet.put(collection, card)
    }
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    {
      MapSet.member?(collection, your_card) && !MapSet.member?(collection, their_card),
      MapSet.put(MapSet.delete(collection, your_card), their_card)
    }
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    your_collection
    |> MapSet.difference(their_collection)
    |> MapSet.size()
  end

  def boring_cards([]), do: []
  @spec boring_cards([collection()]) :: [card()]
  def boring_cards(collections) do
    collections
    |> Enum.reduce(fn collection, acc ->
      MapSet.intersection(acc, collection)
    end)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards(collections) do
    collections
    |> Enum.reduce(MapSet.new(), fn collection, acc ->
      MapSet.union(acc, collection)
    end)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    collection
    |> MapSet.to_list()
    |> Enum.split_with(fn card_name -> String.starts_with?(card_name, "Shiny") end)
  end
end
