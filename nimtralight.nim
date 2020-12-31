import nimtralight/[wrap, callback, string, config, settings]
export wrap, callback, string, config, settings

# {.passL: "-Wl,-rpath -Wl,. -L."}
{.passL: "-Lbuild".}
{.passL: "-lUltralight".}
{.passL: "-lUltralightCore".}
{.passL: "-lAppCore".}
{.passL: "-lWebCore".}
