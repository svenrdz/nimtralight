import os, sequtils
import nimterop/[build, cimport]

const
  baseDir = currentSourcePath.parentDir()
  includeDir = baseDir / "include"
  libDir = baseDir / "sdk" / "bin"
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
    ULConfig* = distinct pointer
    ULRenderer* = distinct pointer
    ULSession* = distinct pointer
    ULView* = distinct pointer
    ULBitmap* = distinct pointer
    ULString* = distinct pointer
    ULBuffer* = distinct pointer
    ULKeyEvent* = distinct pointer
    ULMouseEvent* = distinct pointer
    ULScrollEvent* = distinct pointer
    ULSurface* = distinct pointer
    ULBitmapSurface* = ULSurface
    JSContextRef* = distinct pointer

    ULChar16* = cushort
    JSChar* = cushort

    ULSettings* = distinct pointer
    ULApp* = distinct pointer
    ULWindow* = distinct pointer
    ULMonitor* = distinct pointer
    ULOverlay* = distinct pointer

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
    input.camelCaseIt

  proc onSymbol*(sym: var Symbol) {.exportc, dynlib.} =
    sym.name.stripIt({'_'})
    if sym.kind == nskProc and sym.name.startsWith("ul"):
      sym.name = sym.name.dup:
        stripIt("ulConfig")
        stripIt("ulRenderer")
        stripIt("ulSession")
        stripIt("ulView")
        stripIt("ulBitmapSurface")
        stripIt("ulBitmap")
        stripIt("ulString")
        stripIt("ulBuffer")
        stripIt("ulSurface")
        # stripIt("ulRect")
        # stripIt("ulIntRect")
        stripIt("ulRenderTarget")
        stripIt("ulSettings")
        stripIt("ulApp")
        stripIt("ulWindow")
        stripIt("ulMonitor")
        stripIt("ulOverlay")
        stripIt("ul")
        camelCaseIt()
    if sym.kind in {nskParam, nskField}:
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
cImport(headers.map(fmtHeader), recurse = true, flags = "-f:ast2")
