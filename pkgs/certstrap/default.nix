{
  lib,
  buildGo127Module,
  fetchFromGitHub,
}:
let
  buildGoModule = buildGo127Module;
in
buildGoModule rec {
  pname = "certstrap";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "socheatsok78";
    repo = "certstrap";
    rev = "v${version}";
    sha256 = "sha256-5w79prxZrmB7KazOagmdJH9e5GM7iybQy8ttWxVNTMU=";
  };

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;
  vendorHash = "sha256-wIEr8du0aQvcvQ4VXL6VdhtNUMo/bWVH32gaRQktSA0=";

  meta = with lib; {
    homepage = "https://github.com/square/certstrap";
    description = "Tools to bootstrap CAs, certificate requests, and signed certificates.";
    changelog = "https://github.com/square/certstrap/releases/tag/v${version}";
    license = licenses.asl20;
    mainProgram = "certstrap";
    maintainers = [ ];
  };
}
