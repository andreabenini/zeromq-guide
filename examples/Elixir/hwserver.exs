defmodule Hwserver do
  @moduledoc """
  Generated by erl2ex (http://github.com/dazuma/erl2ex)
  From Erlang source: (Unknown source file)
  At: 2019-12-20 13:57:24

  """

  def main(_) do
    IO.puts("hwserver starting")
    {:ok, context} = :erlzmq.context()
    {:ok, responder} = :erlzmq.socket(context, :rep)
    :ok = :erlzmq.bind(responder, 'tcp://*:5555')
    loop(responder)
    :ok = :erlzmq.close(responder)
    :ok = :erlzmq.term(context)
  end


  def loop(responder) do
    {:ok, msg} = :erlzmq.recv(responder)
    :io.format('Received ~s~n', [msg])
    :timer.sleep(1000)
    :ok = :erlzmq.send(responder, "World")
    loop(responder)
  end

end

Hwserver.main(:ok)
