import wrap

type
  ULString* = object
    p*: ULStringRef
  JSString* = object
    p*: JSStringRef

proc data*(s: ULString): ptr Char16 = s.p.getData

proc data*(s: JSString): ptr Char16 = s.p.JSStringGetCharactersPtr

proc len*(s: ULString): uint = s.p.getLength

proc len*(s: JSString): uint = s.p.JSStringGetLength

proc `$`*(s: ULString | JSString): string =
  var buf = cast[ptr UncheckedArray[Char16]](s.data)
  for i in 0..<s.len:
    result.add buf[i].char

proc `=destroy`*(s: var ULString) =
  s.p.destroyString

proc `=destroy`*(s: var JSString) =
  s.p.JSStringRelease

converter ul*(s: string): ULString =
  result.p = s.createString

converter toULStringRef*(s: ULString): ULStringRef =
  s.p

converter refToULString*(s: ULStringRef): ULString =
  result.p = s

converter js*(s: string): JSString =
  result.p = s.JSStringCreateWithUTF8CString

converter toJSStringRef*(s: JSString): JSStringRef =
  s.p

converter refToJSString*(s: JSStringRef): JSString =
  result.p = s
