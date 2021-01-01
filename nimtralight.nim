import nimtralight/[wrap, callback, string, config, settings]
export wrap, callback, string, config, settings

{.passL: "-Lbuild".}
when defined(macosx):
  {.passL: "-rpath build".}
elif defined(linux):
  {.passL: "-Wl,-rpath,build".}
{.passL: "-lUltralight".}
{.passL: "-lUltralightCore".}
{.passL: "-lAppCore".}
{.passL: "-lWebCore".}
