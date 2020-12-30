proc resize*(view: ULView; width: cuint; height: cuint) {.
    importc: "ulViewResize", cdecl.}

proc resize*(surface: ULSurface; width: cuint; height: cuint) {.
    importc: "ulSurfaceResize", cdecl.}

proc resize*(overlay: ULOverlay; width: cuint; height: cuint) {.
    importc: "ulOverlayResize", cdecl.}

macro defineGetter*(getter: untyped, typ: typedesc): untyped =
  let
    name = typ.strVal[2..^1]
    paramName = name.toLowerAscii.ident
    cName = "ul" & name & "Get" & getter.strVal.capitalizeAscii
  result = nnkProcDef.newTree(
    postfix(getter, "*"),
    newEmptyNode(),
    newEmptyNode(),
    nnkFormalParams.newTree(
      ident"cuint",
      nnkIdentDefs.newTree(
        paramName,
        typ,
        newEmptyNode()
      )
    ),
    nnkPragma.newTree(
      newColonExpr(ident"importc", cName.ident.toStrLit),
      ident"cdecl"
    ),
    newEmptyNode(),
    newEmptyNode(),
  )

defineGetter(width, ULView)
defineGetter(width, ULBitmap)
defineGetter(width, ULSurface)
defineGetter(width, ULMonitor)
defineGetter(width, ULWindow)
defineGetter(width, ULOverlay)

defineGetter(height, ULView)
defineGetter(height, ULBitmap)
defineGetter(height, ULSurface)
defineGetter(height, ULMonitor)
defineGetter(height, ULWindow)
defineGetter(height, ULOverlay)

converter toBitFlag*[T: enum](flags: set[T]): cuint =
  cast[cuint](flags)
