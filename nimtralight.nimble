# Package
import os, strutils

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

proc setupBuildDir() =
  if dirExists("build"):
    rmDir("build")
  mkDir("build")

proc sampleCmd(name: string): string =
  setupBuildDir()
  let outFile = "build" / name & ext()
  let src = "samples" / name / "main"
  # join([outFile, src], " ")
  switch("out", outFile)
  switch("path", ".." / "..")
  switch("run")
  src

task png, "Build render to png":
  setCommand lang, sampleCmd("render_to_png")

task basic, "Build basic app":
  setCommand lang, sampleCmd("basic_app")

task intro, "Build intro to c api":
  setCommand lang, sampleCmd("intro_to_c_api")

task wrap, "Generate wrap":
  setupBuildDir()
  switch("run")
  switch("out", "build/genwrap" & ext())
  switch("forceBuild", "on")
  setCommand lang, "nimtralight/genwrap"
