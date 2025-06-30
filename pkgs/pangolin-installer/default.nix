{
  lib,
  maintainer,
  buildGo123Module,
  fetchFromGitHub,
}:

buildGo123Module rec {
  pname = "pangolin-installer";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = version;
    hash = "sha256-8YGDDUmA6q7DVt+TcyHLrzLrV6jLC0GZq85V+3STBRY=";
  };

  modRoot = "install";
  vendorHash = "sha256-VK704twd9Mvq2MQOud/dRrlrwtK0ImOF7jziyiGrT/U=";

  doCheck = false;

  postInstall = ''
    mv $out/bin/installer $out/bin/${pname}
  '';

  meta = with lib; {
    homepage = "https://fossorial.io/";
    description = "Tunneled Reverse Proxy Server with Identity and Access Control and Dashboard UI";
    changelog = "https://github.com/fosrl/pangolin/releases/tag/${version}";
    license = licenses.agpl3Only;
    mainProgram = "pangolin-installer";
    maintainers = [
      maintainer.socheatsok78
    ];
  };
}
