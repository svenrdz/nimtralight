import nimtralight/[wrap, converters, helpers, callback, string]
export wrap, converters, helpers, callback, string

# {.passL: "-Wl,-rpath -Wl,. -L."}
{.passL: "-lUltralight".}
{.passL: "-lUltralightCore".}
{.passL: "-lAppCore".}
{.passL: "-lWebCore".}
