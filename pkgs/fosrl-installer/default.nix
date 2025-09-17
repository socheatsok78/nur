{
  lib,
  buildGo124Module,
  fetchFromGitHub,
}:

buildGo124Module rec {
  pname = "fosrl-installer";
  version = "1.9.3";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = version;
    hash = "sha256-E0useOuRq9YVWPC8JvsB1u29hqBmKqnhIx1u3KvjqBo=";
  };

  modRoot = "install";
  vendorHash = "sha256-ib38CI4V1sg54hwQ+a19ykZoZKKj0zRn9Rm7nxsCfnI=";

  doCheck = false;

  postInstall = ''
    mv $out/bin/installer $out/bin/${pname}
  '';

  meta = with lib; {
    homepage = "https://fossorial.io/";
    description = "Tunneled Reverse Proxy Server with Identity and Access Control and Dashboard UI";
    changelog = "https://github.com/fosrl/pangolin/releases/tag/${version}";
    license = licenses.agpl3Only;
    mainProgram = "fosrl-installer";
    maintainers = [];
  };
}
