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
    ULStringRef* = pointer
    JSStringRef* = pointer

    ULFaceWinding* {.size: sizeof(cint).} = enum
      fwClockwise
      fwCounterClockwise
    ULFontHinting* {.size: sizeof(cint).} = enum
      fhSmooth
      fhNormal
      fhMonochrome

    ULConfig* = pointer
    ULRenderer* = pointer
    ULSession* = pointer
    ULView* = distinct pointer
    ULBitmap* = distinct pointer
    ULBuffer* = pointer
    ULKeyEvent* = pointer
    ULMouseEvent* = pointer
    ULScrollEvent* = pointer
    ULSurface* = distinct pointer
    ULBitmapSurface* = ULSurface
    ULSettings* = pointer
    ULApp* = pointer
    ULWindow* = pointer
    ULMonitor* = distinct pointer
    ULOverlay* = distinct pointer

    JSContextGroupRef* = pointer
    JSContextRef* = pointer
    JSGlobalContextRef* = pointer
    JSClassRef* = pointer
    JSPropertyNameArrayRef* = pointer
    JSPropertyNameAccumulatorRef* = pointer
    JSValueRef* = pointer
    JSObjectRef* = pointer

    ULWindowFlags* {.size: sizeof(cuint).} = enum
      wfBorderless = 1 shl 0
      wfTitled = 1 shl 1
      wfResizable = 1 shl 2
      wfMaximizable = 1 shl 3

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
