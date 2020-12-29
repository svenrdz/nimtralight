import os, sequtils, macros
import nimterop/cimport

const
  baseDir = currentSourcePath.parentDir()
  includeDir = baseDir.parentDir / "include"
  headers = @["UltralightCAPI", "AppCoreCAPI", "JavaScriptCore/JSBase",
      "JavaScriptCore/JSContextRef", "JavaScriptCore/JSStringRef",
      "JavaScriptCore/JSObjectRef", "JavaScriptCore/JSTypedArray", "JavaScriptCore/JSValueRef"]
  nimFile = baseDir / "wrap.nim"
  missingFile = baseDir / "missing.nim"


proc fmtHeader(hdr: string): string =
  includeDir / hdr & ".h"

cIncludeDir(includeDir)

cOverride:
  const ULInvalidFileHandle* = -1.cint

  type
    Char16* = cushort
    ULChar16* = Char16
    JSChar* = Char16
    String16* = object
      data*: ptr Char16
      length*: uint
    ULStringRef* = pointer
    JSStringRef* = pointer

    ULFaceWinding* {.size: sizeof(cint).} = enum
      fwClockwise
      fwCounterClockwise
    ULFontHinting* {.size: sizeof(cint).} = enum
      fhSmooth
      fhNormal
      fhMonochrome
    Config* = ref object
      resourcePath*, cachePath*: String16
      useGpuRenderer*: bool
      deviceScale*: cdouble
      faceWinding*: ULFaceWinding
      enableImages*: bool
      enableJavascript*: bool
      fontHinting*: ULFontHinting
      fontGamma*: cdouble
      fontFamilyStandard*: String16
      fontFamilyFixed*: String16
      fontFamilySerif*: String16
      fontFamilySansSerif*: String16
      userAgent*: String16
      userStylesheet*: String16
      forceRepaint*: bool
      animationTimerDelay*: cdouble
      scrollTimerDelay*: cdouble
      recycleDelay*: cdouble
      memoryCacheSize*: uint32
      pageCacheSize*: uint32
      overrideRamSize*: uint32
      minLargeHeapSize*: uint32
      minSmallHeapSize*: uint32
    ULConfig* = ref object
      val*: Config

    ULRenderer* = distinct pointer
    ULSession* = distinct pointer
    ULView* = distinct pointer
    ULBitmap* = distinct pointer
    ULBuffer* = distinct pointer
    ULKeyEvent* = distinct pointer
    ULMouseEvent* = distinct pointer
    ULScrollEvent* = distinct pointer
    ULSurface* = distinct pointer
    ULBitmapSurface* = ULSurface

    Settings* = object
      developerName*: String16
      appName*: String16
      fileSystemPath*: String16
      loadShadersFromFileSystem*: bool
      forceCpuRenderer*: bool
    ULSettings* = ref object
      val*: Settings

    ULWindowFlags* {.size: sizeof(cuint).} = enum
      wfBorderless = 1 shl 0
      wfTitled = 1 shl 1
      wfResizable = 1 shl 2
      wfMaximizable = 1 shl 3

    CApp* = object
    ULApp* = ptr CApp

    CWindow* = object
    ULWindow* = ptr CWindow

    CMonitor* = object
    ULMonitor* = ptr CMonitor

    COverlay* = object
    ULOverlay* = ptr COverlay

    # WTFStringImpl*  = object
    #   data* {.importc: "m_data16".}: ref UncheckedArray[JSChar]
    #   len* {.importc: "m_length".}: cuint
    # WTFString* = object
    #   data* {.importc: "m_impl".}: ref WTFStringImpl
    # OpaqueJSString* = object
      # data* {.importc: "m_string".}: WTFString
    # JSStringRef* = pointer

    OpaqueJSContextGroup* = object
    JSContextGroupRef* = ptr OpaqueJSContextGroup

    OpaqueJSContext* = object
    JSContextRef* = ptr OpaqueJSContext
    JSGlobalContextRef* = ptr OpaqueJSContext

    OpaqueJSClass* = object
    JSClassRef* = ptr OpaqueJSClass

    OpaqueJSPropertyNameArray* = object
    JSPropertyNameArrayRef* = ptr OpaqueJSPropertyNameArray

    OpaqueJSPropertyNameAccumulator* = object
    JSPropertyNameAccumulatorRef* = ptr OpaqueJSPropertyNameAccumulator

    OpaqueJSValue* = object
    JSValueRef* = ptr OpaqueJSValue
    JSObjectRef* = ptr OpaqueJSValue

cPlugin:
  import strutils, sugar

  proc camelCase(input: var string) =
    if input.len > 0: input[0] = input[0].toLowerAscii

  proc onSymbol*(sym: var Symbol) {.exportc, dynlib.} =
    sym.name = sym.name.strip(chars = {'_'})
    if sym.kind == nskType and sym.name == "ULString":
      sym.name = "ULStringRef"
    if sym.kind == nskProc and sym.name.startsWith("ul"):
      sym.name = sym.name.dup:
        removePrefix("ulConfig")
        removePrefix("ulRenderer")
        removePrefix("ulSession")
        removePrefix("ulView")
        removePrefix("ulBitmapSurface")
        removePrefix("ulBitmap")
        removePrefix("ulString")
        removePrefix("ulBuffer")
        removePrefix("ulSurface")
        removePrefix("ulSettings")
        removePrefix("ulApp")
        removePrefix("ulWindow")
        removePrefix("ulMonitor")
        removePrefix("ulOverlay")
        removePrefix("ul")
        removeSuffix("Resize")
        removeSuffix("Width")
        removeSuffix("Height")
        removeSuffix("Resize")
        camelCase()

# when defined(macosx):
#   cPassC("-mmacosx-version-min=10.11")
#   cPassL("-mmacosx-version-min=10.11")
#   cPassL("-rpath @executable_path")
#   # cPassL("-std osx-metal1.1")
#   # cPassL("-framework Metal")
#   # cPassL("-lc++")
# elif defined(linux):
#   cPassL("-rpath " & libDir)

cImport(headers.map(fmtHeader), recurse = true, nimFile = nimFile,
    flags = "-f:ast2 -H")

let wrapped = nimFile.readFile.string
let missing = missingFile.readFile.string
nimFile.open(fmWrite).write("import strutils\n" & wrapped & "\n" & missing)
