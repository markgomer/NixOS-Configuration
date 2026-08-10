{ self, inputs, ... }:
{
    perSystem = { pkgs-unstable, ... }:
    {
        packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia.wrap
        {
            inherit pkgs-unstable;
            settings =
                (builtins.fromJSON
                    (builtins.readFile ./noctalia.json)).settings;
        };
    };
}
