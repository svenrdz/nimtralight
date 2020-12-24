import wrap

converter toCString*(s: string): CString =
  new result.data
  result.len = s.len.cint
  for i in 0..<result.len:
    result.data[i] = cast[cushort](s[i])

converter toULString*(s: string): ULString =
  new(result)
  result[] = s.CString

converter toRef*[T: object](obj: T): ref T =
  new result
  result[] = obj

converter toBitFlag*[T: enum](flags: set[T]): cuint =
  cast[cuint](flags)
