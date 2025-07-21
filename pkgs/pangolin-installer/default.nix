{
  lib,
  maintainer,
  buildGo123Module,
  fetchFromGitHub,
}:

buildGo123Module rec {
  pname = "pangolin-installer";
  version = "1.7.3";

  src = fetchFromGitHub {
    owner = "fosrl";
    repo = "pangolin";
    rev = version;
    hash = "sha256-w4IyLdah/MdFrk8kjGpg4ci+LEDCCYRsy1VPdDyNyXI=";
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
