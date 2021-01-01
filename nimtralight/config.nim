import wrap, string

type
  Config* = object
    p*: ULConfig

proc initConfig*: Config =
  result.p = createConfig()

proc `=destroy`*(c: var Config) =
  c.p.destroyConfig

proc `resourcePath=`*(c: Config, resourcePath: string) =
  c.p.setResourcePath resourcePath.ul

proc `cachePath=`*(c: Config, cachePath: string) =
  c.p.setCachePath cachePath.ul

proc `useGpuRenderer=`*(c: Config, useGpuRenderer: bool) =
  c.p.setUseGPURenderer useGpuRenderer

proc `deviceScale=`*(c: Config, deviceScale: cdouble) =
  c.p.setDeviceScale deviceScale

proc `faceWinding=`*(c: Config, faceWinding: ULFaceWinding) =
  c.p.setFaceWinding faceWinding

proc `enableImages=`*(c: Config, enableImages: bool) =
  c.p.setEnableImages enableImages

proc `enableJavascript=`*(c: Config, enableJavascript: bool) =
  c.p.setEnableJavaScript enableJavascript

proc `fontHinting=`*(c: Config, fontHinting: ULFontHinting) =
  c.p.setFontHinting fontHinting

proc `fontGamma=`*(c: Config, fontGamma: cdouble) =
  c.p.setFontGamma fontGamma

proc `fontFamilyStandard=`*(c: Config, fontFamilyStandard: string) =
  c.p.setFontFamilyStandard fontFamilyStandard.ul

proc `fontFamilyFixed=`*(c: Config, fontFamilyFixed: string) =
  c.p.setFontFamilyFixed fontFamilyFixed.ul

proc `fontFamilySerif=`*(c: Config, fontFamilySerif: string) =
  c.p.setFontFamilySerif fontFamilySerif.ul

proc `fontFamilySansSerif=`*(c: Config, fontFamilySansSerif: string) =
  c.p.setFontFamilySansSerif fontFamilySansSerif.ul

proc `userAgent=`*(c: Config, userAgent: string) =
  c.p.setUserAgent userAgent.ul

proc `userStylesheet=`*(c: Config, userStylesheet: string) =
  c.p.setUserStylesheet userStylesheet.ul

proc `forceRepaint=`*(c: Config, forceRepaint: bool) =
  c.p.setForceRepaint forceRepaint

proc `animationTimerDelay=`*(c: Config, animationTimerDelay: cdouble) =
  c.p.setAnimationTimerDelay animationTimerDelay

proc `scrollTimerDelay=`*(c: Config, scrollTimerDelay: cdouble) =
  c.p.setScrollTimerDelay scrollTimerDelay

proc `recycleDelay=`*(c: Config, recycleDelay: cdouble) =
  c.p.setRecycleDelay recycleDelay

proc `memoryCacheSize=`*(c: Config, memoryCacheSize: uint32) =
  c.p.setMemoryCacheSize memoryCacheSize

proc `pageCacheSize=`*(c: Config, pageCacheSize: uint32) =
  c.p.setPageCacheSize pageCacheSize

proc `overrideRamSize=`*(c: Config, overrideRamSize: uint32) =
  c.p.setOverrideRamSize overrideRamSize

proc `minLargeHeapSize=`*(c: Config, minLargeHeapSize: uint32) =
  c.p.setMinLargeHeapSize minLargeHeapSize

proc `minSmallHeapSize=`*(c: Config, minSmallHeapSize: uint32) =
  c.p.setMinSmallHeapSize minSmallHeapSize

converter toULConfig*(c: Config): ULConfig =
  c.p

# Defaults
# useGpuRenderer = false
# deviceScale = 1.0
# faceWinding = fwCounterClockwise
# enableImages = true
# enableJavascript = true
# fontGamma = 1.8
# fontFamilyStandard = "Times New Roman"
# fontFamilyFixed = "Courier New"
# fontFamilySerif = "Times New Roman"
# fontFamilySansSerif = "Arial"
# userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) " &
#             "AppleWebKit/608.3.10 (KHTML, like Gecko) " &
#             "Ultralight/1.2.0 Safari/608.3.10"
# forceRepaint = false
# animationTimerDelay = 1.0 / 60.0
# scrollTimerDelay = 1.0 / 60.0
# recycleDelay = 4.0
# memoryCacheSize = 64 * 1024 * 1024
# pageCacheSize = 0
# overrideRamSize = 0
# minLargeHeapSize = 32 * 1024 * 1024
# minSmallHeapSize = 1 * 1024 * 1024
