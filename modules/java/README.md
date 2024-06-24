# Java 
Java is a programming language and computing platform first released by Sun Microsystems in 1995. It has evolved from humble beginnings to power a large share of today’s digital world, by providing the reliable platform upon which many services and applications are built. New, innovative products and digital services designed for the future continue to rely on Java, as well.

## Settings
This is what the options look like you can add to your machine-settings:
```NIX
{
    modules = {
        java  = "string";
    };
}
```

## Note
This module will become deprecated soon, as if you need a version of java it should be installed using `shell.nix`. This ways, you can pin a specific version of `Java` to the application you're developing.
