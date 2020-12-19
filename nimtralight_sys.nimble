# Package
import os, strutils

version = "0.1.0"
author = "svenrdz"
description = "Low level Ultralight wrapper for Nim"
license = "MIT"

skipDirs = @["build"]

# Dependencies

requires "nim >= 1.4.2", "nimterop >= 0.6.13"

proc sampleCmd(name: string): string =
  if not dirExists("build"): mkDir("build")
  exec "cp -r sdk/bin/* build/"
  let outFile = "-o:build" / name
  let src = "samples" / name / "main"
  join(["nim c", outFile, src], " ")

task png, "Build render to png":
  exec sampleCmd("render_to_png")

task basic, "Build basic app":
  exec sampleCmd("basic_app")
