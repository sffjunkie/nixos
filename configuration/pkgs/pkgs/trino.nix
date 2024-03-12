{
  lib,
  fetchFromGitHub,
  jre,
  makeWrapper,
  maven,
}:
maven.buildMavenPackage rec {
  pname = "trino";
  version = "440";

  src = fetchFromGitHub {
    owner = "trinodb";
    repo = pname;
    rev = "${pname}-${version}";
    hash = "sha256-rRttA5H0A0c44loBzbKH7Waoted3IsOgxGCD2VM0U/Q=";
  };

  mvnHash = "sha256-kLpjMj05uC94/5vGMwMlFzLKNFOKeyNvq/vmB6pHTAo=";

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin $out/share/${pname}
    install -Dm644 jd-cli/target/${pname}.jar $out/share/${pname}

    makeWrapper ${jre}/bin/java $out/bin/${pname} \
      --add-flags "-jar $out/share/${pname}/${pname}.jar"
  '';

  meta = with lib; {
    description = "Apache trino";
    homepage = "https://github.com/trinodb/trino";
    license = licenses.asl20;
    # maintainers = with maintainers; [ majiir ];
  };
}
