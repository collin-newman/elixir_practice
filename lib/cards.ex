defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling hands of cards

  """

  @doc """
    Creates a list of strings to represent a deck
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Clubs", "Hearts", "Spades", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards will be in the hand.

  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.shuffle(deck, 2)
        iex> hand
        ["Ace of Spades", "King of Spades"]
  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
