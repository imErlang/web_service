## Protocol

### Login

```xml

received <<
{xmlstreamstart,<<>>,[{<<"xmlns">>,<<"jabber:client">>},{<<"xmlns:stream">>,<<"http://etherx.jabber.org/streams">>},{<<"to">>,<<"startalk.tech">>},{<<"version">>,<<"1.0">>},{<<"id">>,<<"3754522579">>},{<<"user">>,<<"chao.zhang">>},{<<"from">>,<<"startalk.tech">>},{<<"xml:lang">>,<<"en">>}]} 

received <<
{xmlstreamelement,{xmlel,<<"starttls">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-tls">>}],[]}}

received <<
{xmlstreamelement,{xmlel,<<"auth">>,[{<<"xmlns">>,<<"urn:ietf:params:xml:ns:xmpp-sasl">>},{<<"mechanism">>,<<"PLAIN">>},{<<"id">>,<<"PBMSG_290711614320651041">>}],[{xmlcdata,<<"AGNoYW8uemhhbmcAWGoyTEZxTTdqZHdOWlVuQmE1a2RXUVFsOTF5YTBMWVAyb3VtdjA0WXhhK0tjTytYQ1RieVlLY0V4Ky91bllLamVVcS9Qa2l1T1dZTzk1ZCszVHIvam9IRk8xcENuQlVBUGhjcDcrQ05JbGJ5cDZ2eVBWWnp2ZUdJS3dqM1RqT1U0T3FweUphM1RXVjBFNHhFUVNGZ3VJc1BheGVBek9lZmN1SndIeGk0YkY4PQ==">>}]}} 

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