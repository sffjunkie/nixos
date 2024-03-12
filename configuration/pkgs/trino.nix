{
  lib,
  fetchurl,
  jre,
  makeWrapper,
  stdenv,
  ...
}:
stdenv.mkDerivation rec {
  pname = "trino-server";
  version = "440";

  src = fetchurl {
    url = "https://repo1.maven.org/maven2/io/trino/trino-server/440/trino-server-440.tar.gz";
    hash = "sha256-dwrG+p3/acx+wsYysrJ5uAJVY5jHolVh1tIKPtXxVyk=";
  };

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    mkdir -p $out/bin $out/share/${pname}
    install -Dm644 ${pname}/target/${pname}.jar $out/share/${pname}

    #   makeWrapper ${jre}/bin/java $out/bin/${pname} \
    #     --add-flags "-jar $out/share/${pname}/${pname}.jar"
  '';

  meta = with lib; {
    description = "Apache trino";
    homepage = "https://github.com/trinodb/trino";
    license = licenses.asl20;
    # maintainers = with maintainers; [ majiir ];
  };
}
