import os, sequtils
import nimterop/[build, cimport]

const
  baseDir = currentSourcePath.parentDir()
  includeDir = baseDir / "include"
  libDir = baseDir / "sdk" / "bin"
  flags = "-f:ast2"
  headers = @["UltralightCAPI", "AppCoreCAPI", "JavaScriptCore/JSBase",
      "JavaScriptCore/JSContextRef", "JavaScriptCore/JSStringRef",
      "JavaScriptCore/JSObjectRef", "JavaScriptCore/JSTypedArray", "JavaScriptCore/JSValueRef"]

proc fmtLib(lib: string): string =
  when defined(windows):
    const
      prefix = ""
      suffix = ".dll"
  elif defined(macosx):
    const
      prefix = "lib"
      suffix = ".dylib"
  else:
    const
      prefix = "lib"
      suffix = ".so"
  libDir / (prefix & lib) & suffix

proc fmtHeader(hdr: string): string =
  includeDir / hdr & ".h"

static:
  if not libDir.dirExists:
    echo ""
    echo "You need to download the latest Ultralight release from:"
    echo "https://github.com/ultralight-ux/Ultralight/releases"
    echo "Place the file at the root of the repo in a folder name `sdk`,"
    echo "then extract its contents with 7z."
    echo ""
    quit(1)

cOverride:
  type
    ULConfig* = pointer
    ULRenderer* = pointer
    ULSession* = pointer
    ULView* = pointer
    ULBitmap* = pointer
    ULString* = pointer
    ULBuffer* = pointer
    ULKeyEvent* = pointer
    ULMouseEvent* = pointer
    ULScrollEvent* = pointer
    ULSurface* = pointer
    ULBitmapSurface* = pointer
    JSContextRef* = pointer

    ULChar16* = cushort
    JSChar* = cushort

    ULSettings* = pointer
    ULApp* = pointer
    ULWindow* = pointer
    ULMonitor* = pointer
    ULOverlay* = pointer

    OpaqueJSValue* = pointer
    OpaqueJSClass* = pointer
    OpaqueJSString* = pointer
    OpaqueJSContext* = pointer
    OpaqueJSContextGroup* = pointer
    OpaqueJSPropertyNameArray* = pointer
    OpaqueJSPropertyNameAccumulator* = pointer

cPlugin:
  import strutils, sugar

  proc stripIt(input: var string, chars: set[char]) =
    input = input.strip(chars = chars)

  proc stripIt(input: var string, sub: string) =
    if input.startsWith(sub):
      input = input[sub.len..^1]

  proc replaceIt(input: var string, sub, by: string) =
    input = input.replace(sub, by)

  proc camelCaseIt(input: var string) =
    input[0] = input[0].toLowerAscii

  proc nepIt(input: var string) =
    if '_' in input:
      var result = ""
      var upperNext = false
      for ch in input:
        if ch == '_':
          upperNext = true
          continue
        else:
          if upperNext:
            result.add ch.toUpperAscii
            upperNext = false
          else:
            result.add ch
      input = result

  proc onSymbol*(sym: var Symbol) {.exportc, dynlib.} =
    sym.name.stripIt({'_'})
    if sym.kind == nskProc and sym.name.startsWith("ul"):
      sym.name = sym.name.dup:
        replaceIt("ulCreate", "newUL")
        stripIt("ulConfig")
        stripIt("ulRenderer")
        stripIt("ulSession")
        stripIt("ulView")
        stripIt("ulBitmapSurface")
        stripIt("ulBitmap")
        stripIt("ulString")
        stripIt("ulBuffer")
        stripIt("ulSurface")
        stripIt("ulRect")
        stripIt("ulIntRect")
        stripIt("ulRenderTarget")
        stripIt("ulSettings")
        stripIt("ulApp")
        stripIt("ulWindow")
        stripIt("ulMonitor")
        stripIt("ulOverlay")
        stripIt("ul")
        nepIt()
        camelCaseIt()
    if sym.kind == nskParam:
      sym.name.nepIt()

static:
  cAddStdDir()
  cAddSearchDir(includeDir)
  cAddSearchDir(libDir)
cIncludeDir(includeDir)

when defined(macosx):
  cPassC("-mmacosx-version-min=10.11")
  cPassL("-mmacosx-version-min=10.11")
  cPassL("-rpath @executable_path")
  # cPassL("-std osx-metal1.1")
  # cPassL("-framework Metal")
  # cPassL("-lc++")
elif defined(linux):
  cPassL("-rpath " & libDir)

cPassL(fmtLib"Ultralight")
cPassL(fmtLib"UltralightCore")
cPassL(fmtLib"AppCore")
cPassL(fmtLib"WebCore")
cImport(headers.map(fmtHeader), recurse = true, flags = flags)
