defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000
  def encode_nucleotide(_code_point), do: nil

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T
  def decode_nucleotide(_encoded_code), do: nil

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  defp do_encode([], accumulator), do: accumulator

  defp do_encode([head | tail], accumulator) do
    encoded = encode_nucleotide(head)
    do_encode(tail, <<accumulator::bitstring, encoded::size(4)>>)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_decode(<<>>, accumulator), do: accumulator

  defp do_decode(<<encoded::size(4), rest::bitstring>>, accumulator) do
    decoded = decode_nucleotide(encoded)
    do_decode(rest, accumulator ++ [decoded])
  end
end
