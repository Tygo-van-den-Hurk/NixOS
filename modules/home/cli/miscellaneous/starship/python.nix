{
  lib,
  config,
  ...
}:
with lib;
let
  namespace = "self";
  type = "cli";
  category = "miscellaneous";
  program = "starship";
  cfg = config.${namespace}.${type}.${category}.${program};
in
{
  config.programs.${program}.settings."python" = mkIf cfg.enable {
    disabled = false;
    format = "using [\${symbol} \${version}]($style)";
    symbol = "Python";
    version_format = "v\${raw}";
    style = "yellow bold";
    pyenv_version_name = false;
    pyenv_prefix = "virtual env";

    python_binary = [
      [ "python" ]
      [ "python3" ]
      [ "python2" ]
    ];

    detect_extensions = [
      "py"
      "ipynb"
    ];

    detect_files = [
      "requirements.txt"
      ".python-version"
      "pyproject.toml"
      "Pipfile"
      "tox.ini"
      "setup.py"
      "__init__.py"
    ];

    detect_folders = [ ];
    detect_env_vars = [ "VIRTUAL_ENV" ];
  };
}
