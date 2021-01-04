defmodule Ejabberd.Util do
  def success(data \\ "") do
    {:ok, ret} =
      Jason.encode(%{
        data: data,
        errcode: 0,
        errmsg: "",
        ret: true
      })

    ret
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
