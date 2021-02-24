-module(ejabberd_protobuf).

-export([uint32_pack/2, process_data_len/1]).

uint32_pack(Size,Data) ->
    <<D/bitstring>> = Data,
    if Size > 127 ->
        T1 = Size bor 16#80,
        S1 = Size bsr 7,
        if S1 > 127 ->
            T2 = S1 bor 16#80,
            S2  = S1 bsr 7,
            if S2 > 127 ->
   	        T3 = S2 bor 16#80,
   	        S3  = S2 bsr 7,
   	        if  S3 > 127 ->
   	            T4 = S3 bor 16#80,
                    S4  = S3 bsr 7,
                    <<T1,T2,T3,T4,S4,D/bitstring>>;
                true -> <<T1,T2,T3,S3,D/bitstring>>
                end;
            true -> <<T1,T2,S2,D/bitstring>>
            end;
        true -> <<T1,S1,D/bitstring>>
    	end;
    true -> <<Size,D/bitstring>>
    end.

process_data_len(Data) ->
    process_data_len(Data, 0, 0).

%% process_data_len(Data, Length, Weight, Count)
%% Data: 处理的数据
%% Length：累加的长度
%% Count: 表示长度的字节数
process_data_len(_, _, 4) ->
    false;
process_data_len(<<>>, _, _) ->
    continue;
process_data_len(<<0:1, H:7, R/binary>>, Base, Count) ->
    {Base + (H bsl (Count * 7)), R};
process_data_len(<<1:1, H:7, R/binary>>, Base, Count) ->
    process_data_len(R, Base + (H bsl (Count * 7)), Count + 1).