defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension("bmp"), do: "image/bmp"
  def type_from_extension("png"), do: "image/png"
  def type_from_extension("jpg"), do: "image/jpg"
  def type_from_extension("gif"), do: "image/gif"
  def type_from_extension(_extension), do: nil

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: "application/octet-stream"
  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: "image/bmp"

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: "image/png"

  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: "image/jpg"
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: "image/gif"
  def type_from_binary(_signature), do: nil

  def verify(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>, "exe"), do: {:ok, "application/octet-stream"}
  def verify(<<0x42, 0x4D, _::binary>>, "bmp"), do: {:ok, "image/bmp"}

  def verify(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>, "png"),
    do: {:ok, "image/png"}

  def verify(<<0xFF, 0xD8, 0xFF, _::binary>>, "jpg"), do: {:ok, "image/jpg"}
  def verify(<<0x47, 0x49, 0x46, _::binary>>, "gif"), do: {:ok, "image/gif"}

  def verify(_file_binary, _extension),
    do: {:error, "Warning, file format and file extension do not match."}
end
