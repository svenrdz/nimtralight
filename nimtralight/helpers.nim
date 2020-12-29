import wrap, converters

proc initConfig*: Config =
  result.useGpuRenderer = false
  result.deviceScale = 1.0
  result.faceWinding = fwCounterClockwise
  result.enableImages = true
  result.enableJavascript = true
  result.fontGamma = 1.8
  result.fontFamilyStandard = "Times New Roman"
  result.fontFamilyFixed = "Courier New"
  result.fontFamilySerif = "Times New Roman"
  result.fontFamilySansSerif = "Arial"
  result.userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " &
                     "AppleWebKit/608.3.10 (KHTML, like Gecko) " &
                     "Ultralight/1.2.0 Safari/608.3.10"
  result.forceRepaint = false
  result.animationTimerDelay = 1.0 / 60.0
  result.scrollTimerDelay = 1.0 / 60.0
  result.recycleDelay = 4.0
  result.memoryCacheSize = 64 * 1024 * 1024
  result.pageCacheSize = 0
  result.overrideRamSize = 0
  result.minLargeHeapSize = 32 * 1024 * 1024
  result.minSmallHeapSize = 1 * 1024 * 1024

proc initSettings*: Settings =
  result.developerName = "MyCompany"
  result.appName = "MyApp"
  result.fileSystemPath = "./assets/"
  result.loadShadersFromFileSystem = false
  result.forceCpuRenderer = false
