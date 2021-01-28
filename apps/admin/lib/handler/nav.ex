defmodule Handler.Nav do
  def getNav(scheme, ip, domain, port) do
    %{
      Login: %{loginType: "password"},
      baseaddess: %{
        domain: domain,
        videourl: "#{scheme}://#{ip}:#{port}/room/",
        fileurl: "#{scheme}://#{ip}:#{port}",
        appWeb: "#{scheme}://#{ip}:#{port}/appWeb",
        shareurl: "#{scheme}://#{ip}:#{port}/py/sharemsg",
        resetPwdUrl: "#{scheme}://#{ip}:#{port}/static/reterievepassword.html",
        httpurl: "#{scheme}://#{ip}:#{port}/newapi",
        protobufPcPort: 5202,
        socketurl: "ws://#{ip}:#{port}/websocket/",
        pubkey: "rsa_public_key",
        xmppmport: 5222,
        xmppport: 5222,
        domainhost: ip,
        simpleapiurl: "#{scheme}://#{ip}:#{port}",
        payurl: "#{scheme}://#{ip}:#{port}/api",
        apiurl: "#{scheme}://#{ip}:#{port}/api",
        javaurl: "#{scheme}://#{ip}:#{port}/package",
        xmpp: ip,
        protobufPort: 5202
      },
      imConfig: %{
        RsaEncodeType: 1,
        mail: domain,
        isToC: false,
        showOrganizational: true,
        uploadLog: "#{scheme}://#{ip}:#{port}/startalk/management/startalk/log/upload",
        foundConfigUrl: "#{scheme}://#{ip}:#{port}//startalk/management/find/get/navigation"
      },
      ability: %{
        searchurl: "#{scheme}://#{ip}:#{port}/py/search",
        new_searchurl: "#{scheme}://#{ip}:#{port}/py/search",
        showmsgstat: true
      },
      RNAndroidAbility: %{
        RNMineView: true,
        RNGroupCardView: true,
        RNPublicNumberListView: false,
        RNAboutView: false,
        RNGroupListView: false,
        RNContactView: true,
        RNSettingView: true,
        RNUserCardView: true
      },
      RNAbility: %{
        RNMineView: true,
        RNGroupCardView: true,
        RNPublicNumberListView: true,
        RNAboutView: false,
        RNGroupListView: true,
        RNContactView: true,
        RNSettingView: true,
        RNUserCardView: true
      },
      version: 1
    }
  end
end
