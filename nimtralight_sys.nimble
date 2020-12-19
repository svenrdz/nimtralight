# Package
import os, strutils

version = "0.1.0"
author = "svenrdz"
description = "Low level Ultralight wrapper for Nim"
license = "MIT"

skipDirs = @["build"]

# Dependencies

requires "nim >= 1.4.2", "nimterop >= 0.6.13"

when defined(windows):
  const ext = ".exe"
else:
  const ext = ""

proc sampleCmd(name: string): string =
  if dirExists("build"):
    rmDir("build")
  mkDir("build")
  for kind, file in os.walkDir("sdk/bin"):
    case kind
    of pcDir: cpDir(file, "build" / file.extractFilename)
    of pcFile: cpFile(file, "build" / file.extractFilename)
    else: discard
  let outFile = "-o:build" / name & ext
  let src = "samples" / name / "main"
  join(["nim c", outFile, src], " ")

task png, "Build render to png":
  exec sampleCmd("render_to_png")

task basic, "Build basic app":
  exec sampleCmd("basic_app")
