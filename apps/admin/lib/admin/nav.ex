defmodule Admin.Router.NavHandler do
  def getNav(scheme, ip, domain, port) do
    %{
      Login: %{loginType: "password"},
      baseaddess: %{
        simpleapiurl: "#{scheme}://#{ip}:#{port}",
        fileurl: "#{scheme}://#{ip}:#{port}",
        domain: domain,
        javaurl: "#{scheme}://#{ip}:#{port}/package",
        protobufPcPort: 5202,
        xmpp: ip,
        xmppport: 5222,
        protobufPort: 5202,
        pubkey: "rsa_public_key",
        xmppmport: 5222,
        httpurl: "#{scheme}://#{ip}:#{port}/newapi",
        apiurl: "#{scheme}://#{ip}:#{port}/api",
        shareurl: "#{scheme}://#{ip}:#{port}/py/sharemsg",
        domainhost: ip,
        resetPwdUrl: "#{scheme}://#{ip}:#{port}/static/reterievepassword.html"
      },
      imConfig: %{
        RsaEncodeType: 1,
        showOrganizational: true,
        mail: domain,
        foundConfigUrl: "#{scheme}://#{ip}:#{port}//startalk/management/find/get/navigation"
      },
      ability: %{
        searchurl: "#{scheme}://#{ip}:#{port}/py/search",
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
