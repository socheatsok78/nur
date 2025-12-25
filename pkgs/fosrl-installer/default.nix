{
  lib,
  buildGo124Module,
  fetchFromGitHub,
}:

buildGo124Module rec {
  pname = "fosrl-installer";
  version = "1.14.1";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = version;
    hash = "sha256-Lblxkldmg8MQsaP8ACnXjMUtJhEx7McWOqOegyAFi9Q=";
  };

  modRoot = "install";
  vendorHash = "sha256-/vJwa1qRDLV4sfNiCc7a7TICp8R9d3iLJFFm0lbqKKE=";

  doCheck = false;

  GERBIL_VERSION = "1.3.0";
  BADGER_VERSION = "v1.3.1";

  preconfigurePhase = ''
    substituteInPlace main.go --replace "config.PangolinVersion = \"replaceme\"" "config.PangolinVersion = \"${version}\""
    substituteInPlace main.go --replace "config.GerbilVersion = \"replaceme\"" "config.GerbilVersion = \"${GERBIL_VERSION}\""
    substituteInPlace main.go --replace "config.BadgerVersion = \"replaceme\"" "config.BadgerVersion = \"${BADGER_VERSION}\""
  '';

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
