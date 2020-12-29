import wrap

type
  ULString* = object
    p*: ULStringRef
  JSString* = object
    p*: JSStringRef

proc data*(s: ULString): ptr Char16 = s.p.getData

proc data*(s: JSString): ptr Char16 = s.p.JSStringGetCharactersPtr

proc len*(s: String16): uint = s.length

proc len*(s: ULString): uint = s.p.getLength

proc len*(s: JSString): uint = s.p.JSStringGetLength

proc `$`*(s: String16): string =
  var buf = cast[ptr UncheckedArray[Char16]](s.data)
  for i in 0..<s.len:
    result.add buf[i].char

proc `$`*(s: ULString | JSString): string =
  var tmp: String16
  tmp.data = s.data
  tmp.length = s.len
  $tmp

proc `=destroy`*(s: var ULString) =
  echo "=destroy ULString"
  echo $s
  s.p.destroyString

proc `=destroy`*(s: var JSString) =
  echo "=destroy JSString"
  echo $s
  s.p.JSStringRelease
