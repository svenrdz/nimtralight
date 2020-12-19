import os, sequtils
import nimterop/[build, cimport]

const
  baseDir = currentSourcePath.parentDir()
  includeDir = baseDir / "include"
  libDir = baseDir / "sdk" / "bin"
  flags = "-C:cdecl -E:__,_ -F:__,_ -f:ast2"
  # flags = "-E:__,_ -F:__,_ -f:ast2"
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

static:
  cAddStdDir()
  cAddSearchDir(includeDir)
  cAddSearchDir(libDir)
cIncludeDir(includeDir)

when defined(macosx):
  cPassC("-mmacosx-version-min=10.12")
  cPassL("-mmacosx-version-min=10.12")
  cPassL("-rpath @executable_path")
elif defined(linux):
  cPassL("-rpath " & libDir)

cPassL(fmtLib"Ultralight")
cPassL(fmtLib"UltralightCore")
cPassL(fmtLib"AppCore")
cPassL(fmtLib"WebCore")
cImport(headers.map(fmtHeader), recurse = true, flags = flags)
