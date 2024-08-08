{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchpatch2,
  pythonOlder,
  poetry-core,
  aiohttp,
  sensor-state-data,
  pytestCheckHook,
  pytest-asyncio,
  pytest-cov-stub,
}:

buildPythonPackage rec {
  pname = "anova-wifi";
  version = "0.17.0";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "Lash-L";
    repo = "anova_wifi";
    rev = "refs/tags/v${version}";
    hash = "sha256-F/bd5BtHpF3778eoK0QBaSmdTOpLlz+fixCYR74BRZw=";
  };

  patches = [
    (fetchpatch2 {
      # https://github.com/Lash-L/anova_wifi/pull/60
      name = "aiohttp-3.10-compat.patch";
      url = "https://github.com/Lash-L/anova_wifi/commit/0d7cbc756fb07241aebb99d5dd2b7d5cfd10581d.patch";
      hash = "sha256-pfj5vKvI+aTkRV2UZT3E/Dgv0FetSUfDYhTKAq1p6uc=";
    })
  ];

  build-system = [ poetry-core ];

  dependencies = [
    aiohttp
    sensor-state-data
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-asyncio
    pytest-cov-stub
  ];

  disabledTests = [
    # Makes network calls
    "test_async_data_1"
  ];

  pythonImportsCheck = [ "anova_wifi" ];

  meta = with lib; {
    description = "Python package for reading anova sous vide api data";
    homepage = "https://github.com/Lash-L/anova_wifi";
    changelog = "https://github.com/Lash-L/anova_wifi/releases/tag/v${version}";
    maintainers = with maintainers; [ jamiemagee ];
    license = licenses.mit;
  };
}
