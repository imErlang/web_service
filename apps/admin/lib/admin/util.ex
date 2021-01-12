defmodule Ejabberd.Util do
  def success(opts, data) do
    {:ok, ret} =
      Jason.encode(Map.merge(%{
        data: data,
        errcode: 0,
        errmsg: "",
        ret: true
      }, opts))

    ret
  end

  def success(data \\ "") do
    success(%{}, data)
  end

  def fail(errmsg, errcode \\ 0, data \\ "") do
    {:ok, ret} =
      Jason.encode(%{
        data: data,
        errcode: errcode,
        errmsg: errmsg,
        ret: false
      })

    ret
  end
end
