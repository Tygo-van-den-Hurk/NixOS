## This function takes in the settings object, checks the settings object to make sure it is defined
#  it loops over all the attributes, and see if they are null, ensuring that no side effects occure.
{ lib, ... } : let # TODO : make the function work.

    validate-settings = {} : {
        ( lib.attrs ) : (
            assert (
                lib.allAttrsExist attrs &&
                lib.all (name: let value = attrs.${name}; in
                    lib.hasAttrs value && value != null
                ) (lib.attrNames attrs)
            ) "All attributes that are a string must not \"undefined\". Found attribute undefined."
        );
    };

in validate-settings