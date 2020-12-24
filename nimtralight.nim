import nimtralight/[wrap, converters, helpers, callback]
export wrap, converters, helpers, callback

# {.passL: "-Wl,-rpath -Wl,. -L."}
{.passL: "-lUltralight".}
# {.passL: "-lUltralightCore".}
{.passL: "-lAppCore".}
{.passL: "-lWebCore".}
