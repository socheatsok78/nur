{
  lib,
  maintainer,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "certstrap";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "socheatsok78";
    repo = "certstrap";
    rev = "v${version}";
    sha256 = "sha256-mbZtomR8nnawXr3nGVSEuVObe79M1CqTlYN/aEpKmcU=";
  };

  env = {
    CGO_ENABLED = "0";
  };

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;
  vendorHash = "sha256-r7iYhTmFKTjfv11fEerC72M7JBp64rWfbkoTKzObNqM=";

  meta = with lib; {
    homepage = "https://github.com/square/certstrap";
    description = "Tools to bootstrap CAs, certificate requests, and signed certificates.";
    changelog = "https://github.com/square/certstrap/releases/tag/v${version}";
    license = licenses.asl20;
    mainProgram = "certstrap";
    maintainers = [
      maintainer.socheatsok78
    ];
  };
}
