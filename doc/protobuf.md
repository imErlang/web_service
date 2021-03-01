## Protocol

### Login

```xml

received <<
{xmlstreamstart,<<>>,[{<<"xmlns">>,<<"jabber:client">>},{<<"xmlns:stream">>,<<"http://etherx.jabber.org/streams">>},{<<"to">>,<<"startalk.tech">>},{<<"version">>,<<"1.0">>},{<<"id">>,<<"3754522579">>},{<<"user">>,<<"chao.zhang">>},{<<"from">>,<<"startalk.tech">>},{<<"xml:lang">>,<<"en">>}]} 

send >> welcome data
{<<"chao.zhang">>,<<"startalk.tech">>,<<"1.0">>,<<"TLS">>}

received <<
{xmlstreamelement,{xmlel,<<"starttls">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-tls">>}],[]}}

send >> startatls data
{<<>>,<<"startalk.tech">>}

received <<
{xmlstreamelement,{xmlel,<<"auth">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-sasl">>},{<<"mechanism">>,<<"PLAIN">>},{<<"id">>,<<"PBMSG_290711614320651041">>}],[{xmlcdata,<<"AGNoYW8uemhhbmcAWGoyTEZxTTdqZHdOWlVuQmE1a2RXUVFsOTF5YTBMWVAyb3VtdjA0WXhhK0tjTytYQ1RieVlLY0V4Ky91bllLamVVcS9Qa2l1T1dZTzk1ZCszVHIvam9IRk8xcENuQlVBUGhjcDcrQ05JbGJ5cDZ2eVBWWnp2ZUdJS3dqM1RqT1U0T3FweUphM1RXVjBFNHhFUVNGZ3VJc1BheGVBek9lZmN1SndIeGk0YkY4PQ==">>}]}} 

send >> login response succ
{<<"chao.zhang">>,<<"startalk.tech">>,<<"PBMSG_290711614599258867">>,<<>>}

received <<
{xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"9c5f88670df04730b4654e368f2461c7">>},{<<"type">>,<<"set">>}],[{xmlel,<<"bind">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-bind">>}],[{xmlel,<<"resource">>,[],[{xmlcdata,<<"V[200012]_P[PC64]_ID[e85cbbb43c7f4a87acc919ba29c19a5e]_C[1]_PB">>}]}]}]}}

send >>
{xmlel,<<"iq">>,[{<<"id">>,<<"9c5f88670df04730b4654e368f2461c7">>},{<<"type">>,<<"result">>}],[{xmlel,<<"bind">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-bind">>}],[{xmlel,<<"jid">>,[],[{xmlcdata,<<"chao.zhang@startalk.tech/V[200012]_P[PC64]_ID[e85cbbb43c7f4a87acc919ba29c19a5e]_C[1]_PB">>}]}]}]} 

send >> 
{xmlel,<<"presence">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[PC64]_ID[e85cbbb43c7f4a87acc919ba29c19a5e]_C[1]_PB">>},{<<"category">>,<<"3">>},{<<"data">>,<<"{\"navversion\":\"10000\"}">>},{<<"type">>,<<"notify">>}],[{xmlel,<<"notify">>,[{<<"xmlns">>,<<"jabber:x:presence_notify">>}],[]}]} 

received <<
{xmlstreamelement,{xmlel,<<"presence">>,[],[{xmlel,<<"priority">>,[],[{xmlcdata,<<"5">>}]}]}}

send >> 
{xmlel,<<"presence">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[PC64]_ID[e85cbbb43c7f4a87acc919ba29c19a5e]_C[1]_PB">>},{<<"category">>,<<"9">>},{<<"data">>,<<"[\"P[PC64]\"]">>},{<<"type">>,<<"notify">>}],[{xmlel,<<"notify">>,[{<<"xmlns">>,<<"jabber:x:presence_notify">>}],[]}]} 

received <<
{xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"e1c3d38ade11471ea4ffc7f8d1972043">>},{<<"type">>,<<"get">>}],[{xmlel,<<"ping">>,[{<<"xmlns">>,<<"urn:xmpp:ping">>}],[]}]}}

send >> {xmlel,<<"iq">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[PC64]_ID[e85cbbb43c7f4a87acc919ba29c19a5e]_C[1]_PB">>},{<<"id">>,<<"e1c3d38ade11471ea4ffc7f8d1972043">>},{<<"type">>,<<"result">>}],[]}

```


### full
```
2021-03-01 19:47:38.856 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,5,50,36,12,203,228,211,10,147,50,145,106,190,165,249,142,234,198,197,91,49,80,38,89,230,187,15,59,62,135,75,140,232,156,182,104,97,110,103>>  Elixir Data {xmlstreamstart,<<>>,[{<<"xmlns">>,<<"jabber:client">>},{<<"xmlns:stream">>,<<"http://etherx.jabber.org/streams">>},{<<"to">>,<<"startalk.tech">>},{<<"version">>,<<"1.0">>},{<<"id">>,<<"3754522579">>},{<<"user">>,<<"chao.zhang">>},{<<"from">>,<<"startalk.tech">>},{<<"xml:lang">>,<<"en">>}]} Stream {xmlstreamstart,<<>>,[{<<"xmlns">>,<<"jabber:client">>},{<<"xmlns:stream">>,<<"http://etherx.jabber.org/streams">>},{<<"to">>,<<"startalk.tech">>},{<<"version">>,<<"1.0">>},{<<"id">>,<<"3754522579">>},{<<"user">>,<<"chao.zhang">>},{<<"from">>,<<"startalk.tech">>},{<<"xml:lang">>,<<"en">>}]}
2021-03-01 19:47:38.856 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_welcome_msg:3475 send protobuf msg send welcome msg {<<"chao.zhang">>,<<"startalk.tech">>,<<"1.0">>,<<"TLS">>}
2021-03-01 19:47:38.856 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,5,50,4,16,106,42,0>>  Elixir Data {xmlstreamelement,{xmlel,<<"starttls">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-tls">>}],[]}} Stream {xmlstreamelement,{xmlel,<<"starttls">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-tls">>}],[]}}
2021-03-01 19:47:38.857 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_startTLS:3482 send protobuf msg send_startTLS msg {<<>>,<<"startalk.tech">>}
2021-03-01 19:47:38.867 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,1,50,200,2,31,139,8,0,0,0,0,0,0,19,13,196,187,79,131,64,28,0,224,104,226,226,228,236,232,104,98,229,120,21,134,38,150,150,131,162,92,121,148,31,175,52,205,113,156,146,2,109,67,177,15,70,255,106,71,253,134,239,225,229,17,88,69,247,163,161,162,187,175,183,99,79,187,158,54,245,168,231,172,122,133,92,20,4,1,137,235,141,151,187,148,173,55,139,121,142,16,251,84,199,76,16,85,89,148,101,62,166,154,44,114,69,87,62,85,46,106,133,138,214,155,89,254,159,103,60,255,220,222,223,121,31,211,5,121,250,189,153,90,100,159,198,218,55,111,171,170,104,217,180,176,240,28,164,108,198,77,226,199,128,123,210,162,128,183,251,115,217,84,231,40,86,142,100,75,218,112,23,0,25,26,165,104,155,139,187,45,59,58,95,40,52,86,148,18,154,229,170,213,123,58,212,103,14,85,10,59,216,134,17,78,161,206,16,195,135,35,53,133,174,180,29,76,192,64,97,125,80,223,37,167,226,22,17,82,9,219,180,213,174,5,62,216,133,196,78,171,80,79,98,32,64,144,145,148,117,224,46,19,231,84,216,144,101,3,166,169,168,15,84,76,17,75,74,139,154,254,53,136,81,13,3,185,150,141,51,148,16,117,133,169,117,174,133,141,52,38,174,63,4,56,6,64,174,213,184,89,164,171,161,13,70,100,93,50,207,159,76,254,0,24,244,224,191,95,1,0,0>>  Elixir Data {xmlstreamelement,{xmlel,<<"auth">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-sasl">>},{<<"mechanism">>,<<"PLAIN">>},{<<"id">>,<<"PBMSG_290711614599258867">>}],[{xmlcdata,<<"AGNoYW8uemhhbmcAbGFDV3ZCeENQWVFtNm1RemowdlhwUW5sNjNmSnRVNzl5bmlxMjdraDI5aW55dVlOTm9tazkweVhYVnVjSUFYVkZ1cFpsaE0rdHJFNVB1Skp6K3JheGN0Y3FHam8ybFpHb3cvTS9XWVNVN1BXdkRMOXJvbHVZZzFaY29za2Y1cXdGaEQyRW1kVzNydlJzdVUrbE8rMGFBYWNMQzRFWVV1MGlMZU96SHVBUGxZPQ==">>}]}} Stream {xmlstreamelement,{xmlel,<<"auth">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-sasl">>},{<<"mechanism">>,<<"PLAIN">>},{<<"id">>,<<"PBMSG_473861614599258867">>}],[{xmlcdata,<<"AGNoYW8uemhhbmcAbGFDV3ZCeENQWVFtNm1RemowdlhwUW5sNjNmSnRVNzl5bmlxMjdraDI5aW55dVlOTm9tazkweVhYVnVjSUFYVkZ1cFpsaE0rdHJFNVB1Skp6K3JheGN0Y3FHam8ybFpHb3cvTS9XWVNVN1BXdkRMOXJvbHVZZzFaY29za2Y1cXdGaEQyRW1kVzNydlJzdVUrbE8rMGFBYWNMQzRFWVV1MGlMZU96SHVBUGxZPQ==">>}]}}
2021-03-01 19:47:38.875 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_auth_login_response_sucess:3495 send protobuf msg send send_auth_login_response_sucess msg {<<"chao.zhang">>,<<"startalk.tech">>,<<"PBMSG_290711614599258867">>,<<>>}
2021-03-01 19:47:38.973 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,5,50,195,1,127,209,113,15,250,64,124,244,245,226,7,1,207,174,21,79,203,37,82,18,185,167,206,105,77,1,109,191,226,60,151,207,238,39,133,198,159,58,163,92,70,222,107,114,174,158,49,251,116,163,110,150,208,195,97,51,139,146,153,93,119,229,54,70,244,31,168,202,94,20,182,16,18,237,192,148,112,100,206,235,72,92,212,161,112,133,48,9,49,1,244,220,63,11,11,177,120,176,156,164,90,57,194,183,194,113,90,210,175,166,164,245,163,12,125,2,20,149,15,171,15,54,205,85,160,99,200,140,221,37,115,176,223,29,41,120,101,77,243,62,198,120,165,143,162,175,81,110,199,22,255,243,149,212,103,23,153,254,192,143,212,35,19,132,117,80,112,7,207,140,172,251,12,245,35,190,146,250,173,13,124,84,54,13,213,28,2,149,46,221,47,210,100,57,57>>  Elixir Data {xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"0585c17d30c84247b81d8fb86ad1bd99">>},{<<"type">>,<<"set">>}],[{xmlel,<<"bind">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-bind">>}],[{xmlel,<<"resource">>,[],[{xmlcdata,<<"V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>}]}]}]}} Stream {xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"0585c17d30c84247b81d8fb86ad1bd99">>},{<<"type">>,<<"set">>}],[{xmlel,<<"bind">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-bind">>}],[{xmlel,<<"resource">>,[],[{xmlcdata,<<"V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>}]}]}]}}
2021-03-01 19:47:38.989 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_probuf_msg:3365 send protobuf msg send elixir packet: {xmlel,<<"iq">>,[{<<"id">>,<<"0585c17d30c84247b81d8fb86ad1bd99">>},{<<"type">>,<<"result">>}],[{xmlel,<<"bind">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-bind">>}],[{xmlel,<<"jid">>,[],[{xmlcdata,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>}]}]}]}
2021-03-01 19:47:38.991 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_probuf_msg:3365 send protobuf msg send elixir packet: {xmlel,<<"presence">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>},{<<"category">>,<<"3">>},{<<"data">>,<<"{\"navversion\":\"10000\"}">>},{<<"type">>,<<"notify">>}],[{xmlel,<<"notify">>,[{<<"xmlns">>,<<"jabber:x:presence_notify">>}],[]}]}
2021-03-01 19:47:39.188 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,5,50,107,218,131,186,212,138,208,33,171,245,226,7,1,207,174,21,79,203,37,82,18,185,167,206,105,77,1,109,191,226,60,151,207,238,39,133,198,159,58,163,92,70,222,107,114,174,158,49,251,116,163,110,150,208,195,97,51,139,146,153,93,119,229,54,70,244,31,168,202,94,20,182,16,18,237,192,148,112,100,206,235,72,92,212,161,112,133,48,9,88,50,218,168,112,99,230,123,239,99,8,85,236,16,82,135,53,88,1>>  Elixir Data {xmlstreamelement,{xmlel,<<"presence">>,[],[{xmlel,<<"priority">>,[],[{xmlcdata,<<"5">>}]}]}} Stream {xmlstreamelement,{xmlel,<<"presence">>,[],[{xmlel,<<"priority">>,[],[{xmlcdata,<<"5">>}]}]}}
2021-03-01 19:47:39.204 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_probuf_msg:3365 send protobuf msg send elixir packet: {xmlel,<<"presence">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>},{<<"category">>,<<"9">>},{<<"data">>,<<"[\"P[Mac]\"]">>},{<<"type">>,<<"notify">>}],[{xmlel,<<"notify">>,[{<<"xmlns">>,<<"jabber:x:presence_notify">>}],[]}]}
2021-03-01 19:47:39.206 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_probuf_msg:3365 send protobuf msg send elixir packet: {xmlel,<<"presence">>,[{<<"from">>,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>},{<<"xml:lang">>,<<"en">>}],[{xmlel,<<"priority">>,[],[{xmlcdata,<<"5">>}]}]}
2021-03-01 19:47:39.691 [debug] <0.17421.0>@ejabberd_protobuf_receiver:decode_pb_message:571 send protobuf msg Elixir Dt <<16,5,50,134,1,127,209,113,15,250,64,124,244,245,226,7,1,207,174,21,79,203,37,82,18,185,167,206,105,77,1,109,191,226,60,151,207,238,39,133,198,159,58,163,92,70,222,107,114,174,158,49,251,116,163,110,150,208,195,97,51,139,146,153,93,119,229,54,70,244,31,168,202,94,20,182,16,18,237,192,148,112,100,206,235,72,92,212,161,112,133,48,9,151,211,210,204,170,69,111,255,250,238,5,15,65,136,121,99,108,69,233,252,247,172,42,150,231,192,148,178,53,195,79,192,51,128,84,59,57,102,90,174,98,102,55,55,88,50>>  Elixir Data {xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"dd401c282d824e8eb8709500cfc5bf77">>},{<<"type">>,<<"get">>}],[{xmlel,<<"ping">>,[{<<"xmlns">>,<<"urn:xmpp:ping">>}],[]}]}} Stream {xmlstreamelement,{xmlel,<<"iq">>,[{<<"id">>,<<"dd401c282d824e8eb8709500cfc5bf77">>},{<<"type">>,<<"get">>}],[{xmlel,<<"ping">>,[{<<"xmlns">>,<<"urn:xmpp:ping">>}],[]}]}}
2021-03-01 19:47:39.701 [error] <0.17422.0>@ejabberd_protobuf_c2s:send_probuf_msg:3365 send protobuf msg send elixir packet: {xmlel,<<"iq">>,[{<<"from">>,<<"chao.zhang@startalk.tech">>},{<<"to">>,<<"chao.zhang@startalk.tech/V[200012]_P[Mac]_ID[11cf67c0264244e7a842e595f6e28b61]_C[1]_PB">>},{<<"id">>,<<"dd401c282d824e8eb8709500cfc5bf77">>},{<<"type">>,<<"result">>}],[]}
```