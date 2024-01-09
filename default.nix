{
  buildNpmPackage,
  lib,
}:
buildNpmPackage {
  pname = "gql-api";
  version = "1.0.0";

  src = lib.cleanSource ./.;

  npmDepsHash = "sha256-zsGY8Ik4ualF9dNrh4JGyQzLyLcB710SNPof0oxf3Ko=";

  npmPackFlags = [ "--ignore-scripts" ];
}
