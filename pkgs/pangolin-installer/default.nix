{
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
}
