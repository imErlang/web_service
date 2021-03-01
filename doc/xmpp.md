## XMPP

### CONNECTION

```xml
Received XML on stream = <<"<?xml version='1.0'?><stream:stream xmlns=\"jabber:client\" version=\"1.0\" xmlns:stream=\"http://etherx.jabber.org/streams\" to=\"localhost\" xml:lang=\"en\">">>

Send XML on stream = <<"<?xml version='1.0'?><stream:stream id='10212680640301634411' version='1.0' xml:lang='en' xmlns:stream='http://etherx.jabber.org/streams' from='localhost' xmlns='jabber:client'>">>

Send XML on stream = <<"<stream:features><mechanisms xmlns='urn:ietf:params:xml:ns:xmpp-sasl'><mechanism>PLAIN</mechanism></mechanisms><register xmlns='http://jabber.org/features/iq-register'/></stream:features>">>

Received XML on stream = <<"<auth xmlns=\"urn:ietf:params:xml:ns:xmpp-sasl\" mechanism=\"PLAIN\">AGNoYW8AMQ==</auth>">>

Send XML on stream = <<"<success xmlns='urn:ietf:params:xml:ns:xmpp-sasl'>dj04QVJUSTMxalBuNnlROVI3SkRvVkV6NWMwdkkyNHdRK3FjbmNOd0ZObFhnPQ==</success>">>

Received XML on stream = <<"<?xml version='1.0'?><stream:stream xmlns=\"jabber:client\" version=\"1.0\" xmlns:stream=\"http://etherx.jabber.org/streams\" to=\"localhost\" xml:lang=\"en\">">>

Send XML on stream = <<"<?xml version='1.0'?><stream:stream id='17594223891155605277' version='1.0' xml:lang='en' xmlns:stream='http://etherx.jabber.org/streams' from='localhost' xmlns='jabber:client'>">>

Send XML on stream = <<"<stream:features><bind xmlns='urn:ietf:params:xml:ns:xmpp-bind'/><session xmlns='urn:ietf:params:xml:ns:xmpp-session'><optional/></session></stream:features>">>

Received XML on stream = <<"<iq xmlns=\"jabber:client\" type=\"set\" id=\"2d90dfee-9caa-49e3-9565-fc847a410134\"><bind xmlns=\"urn:ietf:params:xml:ns:xmpp-bind\"><resource>gajim.CIL15WMD</resource></bind></iq>">>
Send XML on stream = <<"<iq type='result' id='2d90dfee-9caa-49e3-9565-fc847a410134'><bind xmlns='urn:ietf:params:xml:ns:xmpp-bind'><jid>chao@localhost/gajim.CIL15WMD</jid></bind></iq>">>

Received XML on stream = <<"<presence xmlns=\"jabber:client\" id=\"b41f0a1d-9fff-4c0d-9bb2-10783e93539f\"><c xmlns=\"http://jabber.org/protocol/caps\" hash=\"sha-1\" node=\"https://gajim.org\" ver=\"BKmvC+SPyXdGhWABuqG9J5DdOJ0=\" /></presence>">>

Send XML on stream = <<"<presence xml:lang='en' to='chao@localhost/gajim.CIL15WMD' from='chao@localhost/gajim.CIL15WMD' id='b41f0a1d-9fff-4c0d-9bb2-10783e93539f'><c xmlns='http://jabber.org/protocol/caps' hash='sha-1' node='https://gajim.org' ver='BKmvC+SPyXdGhWABuqG9J5DdOJ0='/></presence>">>

Received XML on stream = <<"<presence xmlns=\"jabber:client\" type=\"unavailable\" id=\"a9917547-4073-471b-8483-0181c87bd2de\" /></stream:stream>">>

Send XML on stream = <<"</stream:stream>">>

```