{
  stdenv,
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
  makeWrapper,
  maintainers,
}:

buildGoModule rec {
  pname = "pangolin-install";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = "${version}";
    hash = "sha256-8YGDDUmA6q7DVt+TcyHLrzLrV6jLC0GZq85V+3STBRY=";
  };

  modRoot = "install";
  vendorHash = "sha256-VK704twd9Mvq2MQOud/dRrlrwtK0ImOF7jziyiGrT/U=";

  meta = {
    homepage = "https://github.com/fosrl/pangolin";
    changelog = "https://github.com/fosrl/pangolin/releases/tag/${version}";
    description = "Tunneled Reverse Proxy Server with Identity and Access Control and Dashboard UI";
    mainProgram = "installer";
    license = lib.licenses.agpl3Only;
    maintainers = [
      maintainers.socheat
    ];
  };
}
