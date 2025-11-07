defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.filter(fn line -> String.trim(line) != "" end)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log_file = open_log(log_path)

    Enum.each(emails, fn mail -> if send_fun.(mail) == :ok, do: log_sent_email(log_file, mail) end)

    close_log(log_file)
  end
end
