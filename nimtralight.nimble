# Package
import os, strutils, strformat

version = "0.1.0"
author = "svenrdz"
description = "Low level Ultralight wrapper for Nim"
license = "MIT"

srcDir = "."
skipDirs = @["build", "samples"]

# Dependencies

requires "nim >= 1.4.2", "nimterop >= 0.6.13"

const lang = "c"

proc ext(): string =
  when defined(windows):
    result = ".exe"

proc sampleCmd(name: string): string =
  let outFile = fmt"build/{name & ext()}"
  let src = fmt"samples/{name}/main"
  switch("out", outFile)
  switch("path", "../..")
  switch("run")
  src

task png, "Build render to png":
  setCommand lang, sampleCmd("render_to_png")

task basic, "Build basic app":
  setCommand lang, sampleCmd("basic_app")

task intro, "Build intro to c api":
  setCommand lang, sampleCmd("intro_to_c_api")

before install:
  if not dirExists("build"):
    mkDir("build")
  exec fmt"nim c -r -o:build/genwrap{ext()} nimtralight/genwrap"
