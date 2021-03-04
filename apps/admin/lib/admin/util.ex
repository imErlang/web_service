defmodule Ejabberd.Util do
  def get_default_host() do
    Application.get_env(:admin, :default_host, "startalk.tech")
  end

  def read_rsa_key(pembin) do
    [entry] = :public_key.pem_decode(pembin)
    :public_key.pem_entry_decode(entry)
  end

  def rsa_public_key() do
    Application.get_env(:admin, :rsa_public_key, "")
    |> read_rsa_key
  end

  def rsa_private_key() do
    Application.get_env(:admin, :rsa_private_key, "")
    |> read_rsa_key
  end

  def enc(plaintext) do
    :public_key.encrypt_public(plaintext, rsa_public_key())
  end

  def dec(ciphertext) do
    :public_key.decrypt_private(ciphertext, rsa_private_key())
  end

  def success(opts, data) do
    {:ok, ret} =
      Jason.encode(
        Map.merge(
          %{
            data: data,
            errcode: 0,
            errmsg: "",
            ret: true
          },
          opts
        )
      )

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
