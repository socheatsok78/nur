{
  lib,
  buildGo124Module,
  fetchFromGitHub,
}:

buildGo124Module rec {
  pname = "fosrl-installer";
  version = "1.11.0";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = version;
    hash = "sha256-wCD2RqkIlPG/YaUhTccJ0Rr4VH280MuBi/KW1l+4v3c=";
  };

  modRoot = "install";
  vendorHash = "sha256-5m+ep9ArMli5Hc6zAltN0NjUsaphFMnpbCDVi5rAOy4=";

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
    maintainers = [ ];
  };
}
