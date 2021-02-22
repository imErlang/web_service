# WebService

server for talk

## 开发环境

### 安装erlang

```
$ cd /startalk/download
$ wget http://erlang.org/download/otp_src_21.3.tar.gz
$ tar -zxvf otp_src_21.3.tar.gz
$ cd otp_src_21.3
$ ./configure --prefix=/startalk/erlang2103
$ make
$ make install

添加PATH
$ vim ~/.bash_profile
 
----------------------------------
# User specific environment and startup programs
ERLANGPATH=/startalk/erlang2103
PATH=$PATH:$HOME/bin:$ERLANGPATH/bin
----------------------------------
 
$ . ~/.bash_profile

确认erlang安装成功
$ erl
```

### 安装elixir

```
$ wget https://codeload.github.com/elixir-lang/elixir/tar.gz/v1.11.3
$ tar zxvf elixir-1.11.3.tar.gz
$ mv elixir-1.11.3 /startalk/elixir1113
$ cd /startalk/elixir1113
$ make
$ mv 

添加PATH
$ vim ~/.bash_profile
 
----------------------------------
# User specific environment and startup programs
ELIXIRPATH=/startalk/elixir1113
PATH=$PATH:$HOME/bin:$ELIXIRPATH/bin
----------------------------------
 
$ . ~/.bash_profile

确认elixir安装成功
$ iex
```
### 编译运行

```shell

git clone https://github.com/imErlang/web_service.git

cd web_service

MIX_ENV=prod mix do distillery.release

 REPLACE_OS_VARS=true  _build/prod/rel/web_service/bin/web_service console
```
