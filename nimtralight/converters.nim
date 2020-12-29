import wrap, string

converter s16*(s: string): String16 =
  result.length = s.len.uint
  var buf = newSeq[Char16](result.length)
  for i in 0..<buf.len:
    buf[i] = s[i].Char16
  result.data = buf[0].addr

converter toString16*(s: ULString | JSString): String16 =
  result.data = s.data
  result.length = s.len

# converter toULString*(s: string): ULString =
#   new(result)
#   result[] = s.CString

converter ul*(s: string): ULString =
  result.p = s.createString

converter toULStringRef*(s: string): ULStringRef =
  s.ul.p

converter refToULString*(s: ULStringRef): ULString =
  result.p = s

converter js*(s: string): JSString =
  result.p = s.JSStringCreateWithUTF8CString

converter toJSStringRef*(s: string): JSStringRef =
  s.js.p

converter refToJSString*(s: JSStringRef): JSString =
  result.p = s

converter toRef*[T: not ref](obj: T): ref T =
  new result
  result[] = obj

converter toPtr*[T: object](obj: T): pointer =
  obj.p

converter toBitFlag*[T: enum](flags: set[T]): cuint =
  cast[cuint](flags)

converter toULConfig*(cfg: Config): ULConfig =
  new result
  result.val = cfg

converter toULSettings*(settings: Settings): ULSettings =
  new result
  result.val = settings
