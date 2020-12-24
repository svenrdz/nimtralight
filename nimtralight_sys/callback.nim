{.experimental: "dynamicBindSym".}
import macros

macro callback*(cbTy: typed, procDef: untyped): untyped =
  let
    def = procDef[0]
    cbImpl = cbTy.getImpl
  expectKind(def, nnkProcDef)
  expectKind(cbImpl, nnkTypeDef)
  expectKind(cbImpl[2], nnkProcTy)
  let
    name = postfix(def[0], "*")
    formalParams = cbImpl[2][0]
    pragmas = cbImpl[2][1]
    body = def[6]
    empty = newEmptyNode()
  result = nnkProcDef.newTree(
    name,
    empty,
    empty,
    formalParams,
    pragmas,
    empty,
    body,
  )
