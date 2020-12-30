import strutils
# Generated @ 2020-12-31T00:31:53+01:00
# Command line:
#   /Users/sven/.nimble/pkgs/nimterop-0.6.13/nimterop/toast --preprocess -m:c --recurse -f:ast2 -H --includeDirs+=/Users/sven/ultralight/nimtralight/include --pnim --symOverride=ULInvalidFileHandle,Char16,ULChar16,JSChar,ULStringRef,JSStringRef,ULFaceWinding,ULFontHinting,ULConfig,ULRenderer,ULSession,ULView,ULBitmap,ULBuffer,ULKeyEvent,ULMouseEvent,ULScrollEvent,ULSurface,ULBitmapSurface,ULSettings,ULApp,ULWindow,ULMonitor,ULOverlay,JSContextGroupRef,JSContextRef,JSGlobalContextRef,JSClassRef,JSPropertyNameArrayRef,JSPropertyNameAccumulatorRef,JSValueRef,JSObjectRef,ULWindowFlags --nim:/Users/sven/.choosenim/toolchains/nim-1.4.2/bin/nim --pluginSourcePath=/Users/sven/.cache/nim/nimterop/cPlugins/nimterop_3530770628.nim /Users/sven/ultralight/nimtralight/include/UltralightCAPI.h /Users/sven/ultralight/nimtralight/include/AppCoreCAPI.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSBase.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSContextRef.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSStringRef.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSObjectRef.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSTypedArray.h /Users/sven/ultralight/nimtralight/include/JavaScriptCore/JSValueRef.h -o /Users/sven/ultralight/nimtralight/nimtralight/wrap.nim

# const 'JS_EXPORT' has unsupported value '__attribute__((visibility("default")))'
# const 'ULExport' has unsupported value '__attribute__((visibility("default")))'
# const '_thread_local' has unsupported value '__thread'
# proc 'ulViewResize' skipped
# proc 'ulSurfaceResize' skipped
# var 'ULInvalidFileHandle' skipped
# const 'ACExport' has unsupported value '__attribute__((visibility("default")))'
# proc 'ulOverlayResize' skipped
{.push hint[ConvFromXtoItselfNotNeeded]: off.}
import macros

macro defineEnum(typ: untyped): untyped =
  result = newNimNode(nnkStmtList)

  # Enum mapped to distinct cint
  result.add quote do:
    type `typ`* = distinct cint

  for i in ["+", "-", "*", "div", "mod", "shl", "shr", "or", "and", "xor", "<", "<=", "==", ">", ">="]:
    let
      ni = newIdentNode(i)
      typout = if i[0] in "<=>": newIdentNode("bool") else: typ # comparisons return bool
    if i[0] == '>': # cannot borrow `>` and `>=` from templates
      let
        nopp = if i.len == 2: newIdentNode("<=") else: newIdentNode("<")
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` = `nopp`(y, x)
        proc `ni`*(x: cint, y: `typ`): `typout` = `nopp`(y, x)
        proc `ni`*(x, y: `typ`): `typout` = `nopp`(y, x)
    else:
      result.add quote do:
        proc `ni`*(x: `typ`, y: cint): `typout` {.borrow.}
        proc `ni`*(x: cint, y: `typ`): `typout` {.borrow.}
        proc `ni`*(x, y: `typ`): `typout` {.borrow.}
    result.add quote do:
      proc `ni`*(x: `typ`, y: int): `typout` = `ni`(x, y.cint)
      proc `ni`*(x: int, y: `typ`): `typout` = `ni`(x.cint, y)

  let
    divop = newIdentNode("/")   # `/`()
    dlrop = newIdentNode("$")   # `$`()
    notop = newIdentNode("not") # `not`()
  result.add quote do:
    proc `divop`*(x, y: `typ`): `typ` = `typ`((x.float / y.float).cint)
    proc `divop`*(x: `typ`, y: cint): `typ` = `divop`(x, `typ`(y))
    proc `divop`*(x: cint, y: `typ`): `typ` = `divop`(`typ`(x), y)
    proc `divop`*(x: `typ`, y: int): `typ` = `divop`(x, y.cint)
    proc `divop`*(x: int, y: `typ`): `typ` = `divop`(x.cint, y)

    proc `dlrop`*(x: `typ`): string {.borrow.}
    proc `notop`*(x: `typ`): `typ` {.borrow.}


{.experimental: "codeReordering".}
{.passC: "-I/Users/sven/ultralight/nimtralight/include".}
defineEnum(JSType) ## ```
                   ##   !
                   ##   @enum JSType
                   ##   @abstract     A constant identifying the type of a JSValue.
                   ##   @constant     kJSTypeUndefined  The unique undefined value.
                   ##   @constant     kJSTypeNull       The unique null value.
                   ##   @constant     kJSTypeBoolean    A primitive boolean value, one of true or false.
                   ##   @constant     kJSTypeNumber     A primitive number value.
                   ##   @constant     kJSTypeString     A primitive string value.
                   ##   @constant     kJSTypeObject     An object value (meaning that this JSValueRef is a JSObjectRef).
                   ##   @constant     kJSTypeSymbol     A primitive symbol value.
                   ## ```
defineEnum(JSTypedArrayType) ## ```
                             ##   !
                             ##    @enum JSTypedArrayType
                             ##    @abstract     A constant identifying the Typed Array type of a JSObjectRef.
                             ##    @constant     kJSTypedArrayTypeInt8Array            Int8Array
                             ##    @constant     kJSTypedArrayTypeInt16Array           Int16Array
                             ##    @constant     kJSTypedArrayTypeInt32Array           Int32Array
                             ##    @constant     kJSTypedArrayTypeUint8Array           Uint8Array
                             ##    @constant     kJSTypedArrayTypeUint8ClampedArray    Uint8ClampedArray
                             ##    @constant     kJSTypedArrayTypeUint16Array          Uint16Array
                             ##    @constant     kJSTypedArrayTypeUint32Array          Uint32Array
                             ##    @constant     kJSTypedArrayTypeFloat32Array         Float32Array
                             ##    @constant     kJSTypedArrayTypeFloat64Array         Float64Array
                             ##    @constant     kJSTypedArrayTypeArrayBuffer          ArrayBuffer
                             ##    @constant     kJSTypedArrayTypeNone                 Not a Typed Array
                             ## ```
defineEnum(Enum_UltralightCAPIh1) ## ```
                                  ##   !
                                  ##   @enum JSPropertyAttribute
                                  ##   @constant kJSPropertyAttributeNone         Specifies that a property has no special attributes.
                                  ##   @constant kJSPropertyAttributeReadOnly     Specifies that a property is read-only.
                                  ##   @constant kJSPropertyAttributeDontEnum     Specifies that a property should not be enumerated by JSPropertyEnumerators and JavaScript for...in loops.
                                  ##   @constant kJSPropertyAttributeDontDelete   Specifies that the delete operation should fail on a property.
                                  ## ```
defineEnum(Enum_UltralightCAPIh2) ## ```
                                  ##   !
                                  ##   @enum JSClassAttribute
                                  ##   @constant kJSClassAttributeNone Specifies that a class has no special attributes.
                                  ##   @constant kJSClassAttributeNoAutomaticPrototype Specifies that a class should not automatically generate a shared prototype for its instance objects. Use kJSClassAttributeNoAutomaticPrototype in combination with JSObjectSetPrototype to manage prototypes manually.
                                  ## ```
defineEnum(ULMessageSource)
defineEnum(ULMessageLevel)
defineEnum(ULCursor)
defineEnum(ULBitmapFormat)
defineEnum(ULKeyEventType)
defineEnum(ULMouseEventType)
defineEnum(ULMouseButton)
defineEnum(ULScrollEventType)
defineEnum(ULLogLevel)
defineEnum(ULVertexBufferFormat) ## ```
                                 ##   /
                                 ##     / Vertex formats.
                                 ##     /
                                 ## ```
defineEnum(ULShaderType) ## ```
                         ##   /
                         ##     / Shader types, used with ULGPUState::shader_type
                         ##     /
                         ##     / Each of these correspond to a vertex/pixel shader pair. You can find
                         ##     / stock shader code for these in the shaders folder of the AppCore repo.
                         ##     /
                         ## ```
defineEnum(ULCommandType) ## ```
                          ##   /
                          ##     / Command types, used with ULCommand::command_type
                          ##     /
                          ## ```
const
  ULInvalidFileHandle* = -1.cint
  JSC_OBJC_API_ENABLED* = 0
  kJSTypeUndefined* = (0).JSType
  kJSTypeNull* = (kJSTypeUndefined + 1).JSType
  kJSTypeBoolean* = (kJSTypeNull + 1).JSType
  kJSTypeNumber* = (kJSTypeBoolean + 1).JSType
  kJSTypeString* = (kJSTypeNumber + 1).JSType
  kJSTypeObject* = (kJSTypeString + 1).JSType
  kJSTypeSymbol* = (kJSTypeObject + 1).JSType
  kJSTypedArrayTypeInt8Array* = (0).JSTypedArrayType
  kJSTypedArrayTypeInt16Array* = (kJSTypedArrayTypeInt8Array + 1).JSTypedArrayType
  kJSTypedArrayTypeInt32Array* = (kJSTypedArrayTypeInt16Array + 1).JSTypedArrayType
  kJSTypedArrayTypeUint8Array* = (kJSTypedArrayTypeInt32Array + 1).JSTypedArrayType
  kJSTypedArrayTypeUint8ClampedArray* = (kJSTypedArrayTypeUint8Array + 1).JSTypedArrayType
  kJSTypedArrayTypeUint16Array* = (kJSTypedArrayTypeUint8ClampedArray + 1).JSTypedArrayType
  kJSTypedArrayTypeUint32Array* = (kJSTypedArrayTypeUint16Array + 1).JSTypedArrayType
  kJSTypedArrayTypeFloat32Array* = (kJSTypedArrayTypeUint32Array + 1).JSTypedArrayType
  kJSTypedArrayTypeFloat64Array* = (kJSTypedArrayTypeFloat32Array + 1).JSTypedArrayType
  kJSTypedArrayTypeArrayBuffer* = (kJSTypedArrayTypeFloat64Array + 1).JSTypedArrayType
  kJSTypedArrayTypeNone* = (kJSTypedArrayTypeArrayBuffer + 1).JSTypedArrayType
  kJSPropertyAttributeNone* = (0).cint
  kJSPropertyAttributeReadOnly* = (1 shl typeof(1)(1)).cint
  kJSPropertyAttributeDontEnum* = (1 shl typeof(1)(2)).cint
  kJSPropertyAttributeDontDelete* = (1 shl typeof(1)(3)).cint
  kJSClassAttributeNone* = (0).cint
  kJSClassAttributeNoAutomaticPrototype* = (1 shl typeof(1)(1)).cint
  kMessageSource_XML* = (0).ULMessageSource
  kMessageSource_JS* = (kMessageSource_XML + 1).ULMessageSource
  kMessageSource_Network* = (kMessageSource_JS + 1).ULMessageSource
  kMessageSource_ConsoleAPI* = (kMessageSource_Network + 1).ULMessageSource
  kMessageSource_Storage* = (kMessageSource_ConsoleAPI + 1).ULMessageSource
  kMessageSource_AppCache* = (kMessageSource_Storage + 1).ULMessageSource
  kMessageSource_Rendering* = (kMessageSource_AppCache + 1).ULMessageSource
  kMessageSource_CSS* = (kMessageSource_Rendering + 1).ULMessageSource
  kMessageSource_Security* = (kMessageSource_CSS + 1).ULMessageSource
  kMessageSource_ContentBlocker* = (kMessageSource_Security + 1).ULMessageSource
  kMessageSource_Other* = (kMessageSource_ContentBlocker + 1).ULMessageSource
  kMessageLevel_Log* = (1).ULMessageLevel
  kMessageLevel_Warning* = (2).ULMessageLevel
  kMessageLevel_Error* = (3).ULMessageLevel
  kMessageLevel_Debug* = (4).ULMessageLevel
  kMessageLevel_Info* = (5).ULMessageLevel
  kCursor_Pointer* = (0).ULCursor
  kCursor_Cross* = (kCursor_Pointer + 1).ULCursor
  kCursor_Hand* = (kCursor_Cross + 1).ULCursor
  kCursor_IBeam* = (kCursor_Hand + 1).ULCursor
  kCursor_Wait* = (kCursor_IBeam + 1).ULCursor
  kCursor_Help* = (kCursor_Wait + 1).ULCursor
  kCursor_EastResize* = (kCursor_Help + 1).ULCursor
  kCursor_NorthResize* = (kCursor_EastResize + 1).ULCursor
  kCursor_NorthEastResize* = (kCursor_NorthResize + 1).ULCursor
  kCursor_NorthWestResize* = (kCursor_NorthEastResize + 1).ULCursor
  kCursor_SouthResize* = (kCursor_NorthWestResize + 1).ULCursor
  kCursor_SouthEastResize* = (kCursor_SouthResize + 1).ULCursor
  kCursor_SouthWestResize* = (kCursor_SouthEastResize + 1).ULCursor
  kCursor_WestResize* = (kCursor_SouthWestResize + 1).ULCursor
  kCursor_NorthSouthResize* = (kCursor_WestResize + 1).ULCursor
  kCursor_EastWestResize* = (kCursor_NorthSouthResize + 1).ULCursor
  kCursor_NorthEastSouthWestResize* = (kCursor_EastWestResize + 1).ULCursor
  kCursor_NorthWestSouthEastResize* = (kCursor_NorthEastSouthWestResize + 1).ULCursor
  kCursor_ColumnResize* = (kCursor_NorthWestSouthEastResize + 1).ULCursor
  kCursor_RowResize* = (kCursor_ColumnResize + 1).ULCursor
  kCursor_MiddlePanning* = (kCursor_RowResize + 1).ULCursor
  kCursor_EastPanning* = (kCursor_MiddlePanning + 1).ULCursor
  kCursor_NorthPanning* = (kCursor_EastPanning + 1).ULCursor
  kCursor_NorthEastPanning* = (kCursor_NorthPanning + 1).ULCursor
  kCursor_NorthWestPanning* = (kCursor_NorthEastPanning + 1).ULCursor
  kCursor_SouthPanning* = (kCursor_NorthWestPanning + 1).ULCursor
  kCursor_SouthEastPanning* = (kCursor_SouthPanning + 1).ULCursor
  kCursor_SouthWestPanning* = (kCursor_SouthEastPanning + 1).ULCursor
  kCursor_WestPanning* = (kCursor_SouthWestPanning + 1).ULCursor
  kCursor_Move* = (kCursor_WestPanning + 1).ULCursor
  kCursor_VerticalText* = (kCursor_Move + 1).ULCursor
  kCursor_Cell* = (kCursor_VerticalText + 1).ULCursor
  kCursor_ContextMenu* = (kCursor_Cell + 1).ULCursor
  kCursor_Alias* = (kCursor_ContextMenu + 1).ULCursor
  kCursor_Progress* = (kCursor_Alias + 1).ULCursor
  kCursor_NoDrop* = (kCursor_Progress + 1).ULCursor
  kCursor_Copy* = (kCursor_NoDrop + 1).ULCursor
  kCursor_None* = (kCursor_Copy + 1).ULCursor
  kCursor_NotAllowed* = (kCursor_None + 1).ULCursor
  kCursor_ZoomIn* = (kCursor_NotAllowed + 1).ULCursor
  kCursor_ZoomOut* = (kCursor_ZoomIn + 1).ULCursor
  kCursor_Grab* = (kCursor_ZoomOut + 1).ULCursor
  kCursor_Grabbing* = (kCursor_Grab + 1).ULCursor
  kCursor_Custom* = (kCursor_Grabbing + 1).ULCursor
  kBitmapFormat_A8_UNORM* = (0).ULBitmapFormat ## ```
                                               ##   /
                                               ##     / Alpha channel only, 8-bits per pixel.
                                               ##     /
                                               ##     / Encoding: 8-bits per channel, unsigned normalized.
                                               ##     /
                                               ##     / Color-space: Linear (no gamma), alpha-coverage only.
                                               ##     /
                                               ## ```
  kBitmapFormat_BGRA8_UNORM_SRGB* = (kBitmapFormat_A8_UNORM + 1).ULBitmapFormat ## ```
                                                                                ##   /
                                                                                ##     / Blue Green Red Alpha channels, 32-bits per pixel.
                                                                                ##     /
                                                                                ##     / Encoding: 8-bits per channel, unsigned normalized.
                                                                                ##     /
                                                                                ##     / Color-space: sRGB gamma with premultiplied linear alpha channel.
                                                                                ##     /
                                                                                ## ```
  kKeyEventType_KeyDown* = (0).ULKeyEventType ## ```
                                              ##   /
                                              ##     / Key-Down event type. (Does not trigger accelerator commands in WebCore)
                                              ##     /
                                              ##     / @NOTE: You should probably use RawKeyDown instead when a physical key
                                              ##     /        is pressed. This member is only here for historic compatibility
                                              ##     /        with WebCore's key event types.
                                              ##     /
                                              ## ```
  kKeyEventType_KeyUp* = (kKeyEventType_KeyDown + 1).ULKeyEventType ## ```
                                                                    ##   /
                                                                    ##     / Key-Up event type. Use this when a physical key is released.
                                                                    ##     /
                                                                    ## ```
  kKeyEventType_RawKeyDown* = (kKeyEventType_KeyUp + 1).ULKeyEventType ## ```
                                                                       ##   /
                                                                       ##     / Raw Key-Down type. Use this when a physical key is pressed.
                                                                       ##     /
                                                                       ##     / @NOTE: You should use RawKeyDown for physical key presses since it
                                                                       ##     /        allows WebCore to do additional command translation.
                                                                       ##     /
                                                                       ## ```
  kKeyEventType_Char* = (kKeyEventType_RawKeyDown + 1).ULKeyEventType ## ```
                                                                      ##   /
                                                                      ##     / Character input event type. Use this when the OS generates text from
                                                                      ##     / a physical key being pressed (eg, WM_CHAR on Windows).
                                                                      ##     /
                                                                      ## ```
  kMouseEventType_MouseMoved* = (0).ULMouseEventType
  kMouseEventType_MouseDown* = (kMouseEventType_MouseMoved + 1).ULMouseEventType
  kMouseEventType_MouseUp* = (kMouseEventType_MouseDown + 1).ULMouseEventType
  kMouseButton_None* = (0).ULMouseButton
  kMouseButton_Left* = (kMouseButton_None + 1).ULMouseButton
  kMouseButton_Middle* = (kMouseButton_Left + 1).ULMouseButton
  kMouseButton_Right* = (kMouseButton_Middle + 1).ULMouseButton
  kScrollEventType_ScrollByPixel* = (0).ULScrollEventType
  kScrollEventType_ScrollByPage* = (kScrollEventType_ScrollByPixel + 1).ULScrollEventType
  kLogLevel_Error* = (0).ULLogLevel
  kLogLevel_Warning* = (kLogLevel_Error + 1).ULLogLevel
  kLogLevel_Info* = (kLogLevel_Warning + 1).ULLogLevel
  kVertexBufferFormat_2f_4ub_2f* = (0).ULVertexBufferFormat
  kVertexBufferFormat_2f_4ub_2f_2f_28f* = (kVertexBufferFormat_2f_4ub_2f + 1).ULVertexBufferFormat
  kShaderType_Fill* = (0).ULShaderType ## ```
                                       ##   Shader program for quad geometry
                                       ## ```
  kShaderType_FillPath* = (kShaderType_Fill + 1).ULShaderType ## ```
                                                              ##   Shader program for path geometry
                                                              ## ```
  kCommandType_ClearRenderBuffer* = (0).ULCommandType
  kCommandType_DrawGeometry* = (kCommandType_ClearRenderBuffer + 1).ULCommandType
type
  Char16* = cushort
  ULStringRef* = pointer
  JSContextGroupRef* = pointer ## ```
                               ##   JavaScript engine interface 
                               ##     ! @typedef JSContextGroupRef A group that associates JavaScript contexts with one another. Contexts in the same group may share and exchange JavaScript objects.
                               ## ```
  JSContextRef* = pointer ## ```
                          ##   ! @typedef JSContextRef A JavaScript execution context. Holds the global object and other execution state.
                          ## ```
  JSGlobalContextRef* = pointer ## ```
                                ##   ! @typedef JSGlobalContextRef A global JavaScript execution context. A JSGlobalContext is a JSContext.
                                ## ```
  JSStringRef* = pointer ## ```
                         ##   ! @typedef JSStringRef A UTF16 character buffer. The fundamental string representation in JavaScript.
                         ## ```
  JSClassRef* = pointer ## ```
                        ##   ! @typedef JSClassRef A JavaScript class. Used with JSObjectMake to construct objects with custom behavior.
                        ## ```
  JSPropertyNameArrayRef* = pointer ## ```
                                    ##   ! @typedef JSPropertyNameArrayRef An array of JavaScript property names.
                                    ## ```
  JSPropertyNameAccumulatorRef* = pointer ## ```
                                          ##   ! @typedef JSPropertyNameAccumulatorRef An ordered set used to collect the names of a JavaScript object's properties.
                                          ## ```
  JSTypedArrayBytesDeallocator* = proc (bytes: pointer;
                                        deallocatorContext: pointer) {.cdecl.}
  JSValueRef* = pointer ## ```
                        ##   JavaScript data types 
                        ##     ! @typedef JSValueRef A JavaScript value. The base type for all JavaScript values, and polymorphic functions on them.
                        ## ```
  JSObjectRef* = pointer ## ```
                         ##   ! @typedef JSObjectRef A JavaScript object. A JSObject is a JSValue.
                         ## ```
  JSPropertyAttributes* = cuint ## ```
                                ##   ! 
                                ##   @typedef JSPropertyAttributes
                                ##   @abstract A set of JSPropertyAttributes. Combine multiple attributes by logically ORing them together.
                                ## ```
  JSClassAttributes* = cuint ## ```
                             ##   ! 
                             ##   @typedef JSClassAttributes
                             ##   @abstract A set of JSClassAttributes. Combine multiple attributes by logically ORing them together.
                             ## ```
  JSObjectInitializeCallback* = proc (ctx: JSContextRef; `object`: JSObjectRef) {.
      cdecl.}
  JSObjectInitializeCallbackEx* = proc (ctx: JSContextRef; jsClass: JSClassRef;
                                        `object`: JSObjectRef) {.cdecl.}
  JSObjectFinalizeCallback* = proc (`object`: JSObjectRef) {.cdecl.}
  JSObjectFinalizeCallbackEx* = proc (jsClass: JSClassRef; `object`: JSObjectRef) {.
      cdecl.}
  JSObjectHasPropertyCallback* = proc (ctx: JSContextRef; `object`: JSObjectRef;
                                       propertyName: JSStringRef): bool {.cdecl.}
  JSObjectHasPropertyCallbackEx* = proc (ctx: JSContextRef; jsClass: JSClassRef;
      `object`: JSObjectRef; propertyName: JSStringRef): bool {.cdecl.}
  JSObjectGetPropertyCallback* = proc (ctx: JSContextRef; `object`: JSObjectRef;
                                       propertyName: JSStringRef;
                                       exception: ptr JSValueRef): JSValueRef {.
      cdecl.}
  JSObjectGetPropertyCallbackEx* = proc (ctx: JSContextRef; jsClass: JSClassRef;
      `object`: JSObjectRef; propertyName: JSStringRef;
      exception: ptr JSValueRef): JSValueRef {.cdecl.}
  JSObjectSetPropertyCallback* = proc (ctx: JSContextRef; `object`: JSObjectRef;
                                       propertyName: JSStringRef;
                                       value: JSValueRef;
                                       exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectSetPropertyCallbackEx* = proc (ctx: JSContextRef; jsClass: JSClassRef;
      `object`: JSObjectRef; propertyName: JSStringRef; value: JSValueRef;
      exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectDeletePropertyCallback* = proc (ctx: JSContextRef;
      `object`: JSObjectRef; propertyName: JSStringRef;
      exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectDeletePropertyCallbackEx* = proc (ctx: JSContextRef;
      jsClass: JSClassRef; `object`: JSObjectRef; propertyName: JSStringRef;
      exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectGetPropertyNamesCallback* = proc (ctx: JSContextRef;
      `object`: JSObjectRef; propertyNames: JSPropertyNameAccumulatorRef) {.
      cdecl.}
  JSObjectGetPropertyNamesCallbackEx* = proc (ctx: JSContextRef;
      jsClass: JSClassRef; `object`: JSObjectRef;
      propertyNames: JSPropertyNameAccumulatorRef) {.cdecl.}
  JSObjectCallAsFunctionCallback* = proc (ctx: JSContextRef;
      function: JSObjectRef; thisObject: JSObjectRef; argumentCount: uint;
      arguments: UncheckedArray[JSValueRef]; exception: ptr JSValueRef): JSValueRef {.
      cdecl.}
  JSObjectCallAsFunctionCallbackEx* = proc (ctx: JSContextRef;
      jsClass: JSClassRef; className: JSStringRef; function: JSObjectRef;
      thisObject: JSObjectRef; argumentCount: uint;
      arguments: UncheckedArray[JSValueRef]; exception: ptr JSValueRef): JSValueRef {.
      cdecl.}
  JSObjectCallAsConstructorCallback* = proc (ctx: JSContextRef;
      constructor: JSObjectRef; argumentCount: uint;
      arguments: UncheckedArray[JSValueRef]; exception: ptr JSValueRef): JSObjectRef {.
      cdecl.}
  JSObjectCallAsConstructorCallbackEx* = proc (ctx: JSContextRef;
      jsClass: JSClassRef; constructor: JSObjectRef; argumentCount: uint;
      arguments: UncheckedArray[JSValueRef]; exception: ptr JSValueRef): JSObjectRef {.
      cdecl.}
  JSObjectHasInstanceCallback* = proc (ctx: JSContextRef;
                                       constructor: JSObjectRef;
                                       possibleInstance: JSValueRef;
                                       exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectHasInstanceCallbackEx* = proc (ctx: JSContextRef; jsClass: JSClassRef;
      constructor: JSObjectRef; possibleInstance: JSValueRef;
      exception: ptr JSValueRef): bool {.cdecl.}
  JSObjectConvertToTypeCallback* = proc (ctx: JSContextRef;
      `object`: JSObjectRef; `type`: JSType; exception: ptr JSValueRef): JSValueRef {.
      cdecl.}
  JSObjectConvertToTypeCallbackEx* = proc (ctx: JSContextRef;
      jsClass: JSClassRef; `object`: JSObjectRef; `type`: JSType;
      exception: ptr JSValueRef): JSValueRef {.cdecl.}
  JSStaticValue* {.bycopy.} = object ## ```
                                      ##   ! 
                                      ##   @struct JSStaticValue
                                      ##   @abstract This structure describes a statically declared value property.
                                      ##   @field name A null-terminated UTF8 string containing the property's name.
                                      ##   @field getProperty A JSObjectGetPropertyCallback to invoke when getting the property's value.
                                      ##   @field setProperty A JSObjectSetPropertyCallback to invoke when setting the property's value. May be NULL if the ReadOnly attribute is set.
                                      ##   @field attributes A logically ORed set of JSPropertyAttributes to give to the property.
                                      ## ```
    name*: cstring
    getProperty*: JSObjectGetPropertyCallback
    setProperty*: JSObjectSetPropertyCallback
    attributes*: JSPropertyAttributes

  JSStaticValueEx* {.bycopy.} = object ## ```
                                        ##   Extension of the above structure for use with class version 1000
                                        ## ```
    name*: cstring
    getPropertyEx*: JSObjectGetPropertyCallbackEx
    setPropertyEx*: JSObjectSetPropertyCallbackEx
    attributes*: JSPropertyAttributes

  JSStaticFunction* {.bycopy.} = object ## ```
                                         ##   ! 
                                         ##   @struct JSStaticFunction
                                         ##   @abstract This structure describes a statically declared function property.
                                         ##   @field name A null-terminated UTF8 string containing the property's name.
                                         ##   @field callAsFunction A JSObjectCallAsFunctionCallback to invoke when the property is called as a function.
                                         ##   @field attributes A logically ORed set of JSPropertyAttributes to give to the property.
                                         ## ```
    name*: cstring
    callAsFunction*: JSObjectCallAsFunctionCallback
    attributes*: JSPropertyAttributes

  JSStaticFunctionEx* {.bycopy.} = object ## ```
                                           ##   Extension of the above structure for use with class version 1000
                                           ## ```
    name*: cstring
    callAsFunctionEx*: JSObjectCallAsFunctionCallbackEx
    attributes*: JSPropertyAttributes

  JSClassDefinition* {.bycopy.} = object ## ```
                                          ##   !
                                          ##   @struct JSClassDefinition
                                          ##   @abstract This structure contains properties and callbacks that define a type of object. All fields other than the version field are optional. Any pointer may be NULL.
                                          ##   @field version The version number of this structure. The current version is 0.
                                          ##   @field attributes A logically ORed set of JSClassAttributes to give to the class.
                                          ##   @field className A null-terminated UTF8 string containing the class's name.
                                          ##   @field parentClass A JSClass to set as the class's parent class. Pass NULL use the default object class.
                                          ##   @field staticValues A JSStaticValue array containing the class's statically declared value properties. Pass NULL to specify no statically declared value properties. The array must be terminated by a JSStaticValue whose name field is NULL.
                                          ##   @field staticFunctions A JSStaticFunction array containing the class's statically declared function properties. Pass NULL to specify no statically declared function properties. The array must be terminated by a JSStaticFunction whose name field is NULL.
                                          ##   @field initialize The callback invoked when an object is first created. Use this callback to initialize the object.
                                          ##   @field finalize The callback invoked when an object is finalized (prepared for garbage collection). Use this callback to release resources allocated for the object, and perform other cleanup.
                                          ##   @field hasProperty The callback invoked when determining whether an object has a property. If this field is NULL, getProperty is called instead. The hasProperty callback enables optimization in cases where only a property's existence needs to be known, not its value, and computing its value is expensive. 
                                          ##   @field getProperty The callback invoked when getting a property's value.
                                          ##   @field setProperty The callback invoked when setting a property's value.
                                          ##   @field deleteProperty The callback invoked when deleting a property.
                                          ##   @field getPropertyNames The callback invoked when collecting the names of an object's properties.
                                          ##   @field callAsFunction The callback invoked when an object is called as a function.
                                          ##   @field hasInstance The callback invoked when an object is used as the target of an 'instanceof' expression.
                                          ##   @field callAsConstructor The callback invoked when an object is used as a constructor in a 'new' expression.
                                          ##   @field convertToType The callback invoked when converting an object to a particular JavaScript type.
                                          ##   @discussion The staticValues and staticFunctions arrays are the simplest and most efficient means for vending custom properties. Statically declared properties autmatically service requests like getProperty, setProperty, and getPropertyNames. Property access callbacks are required only to implement unusual properties, like array indexes, whose names are not known at compile-time.
                                          ##   
                                          ##   If you named your getter function "GetX" and your setter function "SetX", you would declare a JSStaticValue array containing "X" like this:
                                          ##   
                                          ##   JSStaticValue StaticValueArray[] = {
                                          ##       { "X", GetX, SetX, kJSPropertyAttributeNone },
                                          ##       { 0, 0, 0, 0 }
                                          ##   };
                                          ##   
                                          ##   Standard JavaScript practice calls for storing function objects in prototypes, so they can be shared. The default JSClass created by JSClassCreate follows this idiom, instantiating objects with a shared, automatically generating prototype containing the class's function objects. The kJSClassAttributeNoAutomaticPrototype attribute specifies that a JSClass should not automatically generate such a prototype. The resulting JSClass instantiates objects with the default object prototype, and gives each instance object its own copy of the class's function objects.
                                          ##   
                                          ##   A NULL callback specifies that the default object callback should substitute, except in the case of hasProperty, where it specifies that getProperty should substitute.
                                          ## ```
    version*: cint ## ```
                   ##   default version is 0, use version 1000 for callbacks with extended class information
                   ## ```
    attributes*: JSClassAttributes ## ```
                                   ##   default version is 0, use version 1000 for callbacks with extended class information
                                   ## ```
    className*: cstring
    parentClass*: JSClassRef
    staticValues*: ptr JSStaticValue
    staticFunctions*: ptr JSStaticFunction
    initialize*: JSObjectInitializeCallback
    finalize*: JSObjectFinalizeCallback
    hasProperty*: JSObjectHasPropertyCallback
    getProperty*: JSObjectGetPropertyCallback
    setProperty*: JSObjectSetPropertyCallback
    deleteProperty*: JSObjectDeletePropertyCallback
    getPropertyNames*: JSObjectGetPropertyNamesCallback
    callAsFunction*: JSObjectCallAsFunctionCallback
    callAsConstructor*: JSObjectCallAsConstructorCallback
    hasInstance*: JSObjectHasInstanceCallback
    convertToType*: JSObjectConvertToTypeCallback
    staticValuesEx*: ptr JSStaticValueEx
    staticFunctionsEx*: ptr JSStaticFunctionEx
    initializeEx*: JSObjectInitializeCallbackEx
    finalizeEx*: JSObjectFinalizeCallbackEx
    hasPropertyEx*: JSObjectHasPropertyCallbackEx
    getPropertyEx*: JSObjectGetPropertyCallbackEx
    setPropertyEx*: JSObjectSetPropertyCallbackEx
    deletePropertyEx*: JSObjectDeletePropertyCallbackEx
    getPropertyNamesEx*: JSObjectGetPropertyNamesCallbackEx
    callAsFunctionEx*: JSObjectCallAsFunctionCallbackEx
    callAsConstructorEx*: JSObjectCallAsConstructorCallbackEx
    hasInstanceEx*: JSObjectHasInstanceCallbackEx
    convertToTypeEx*: JSObjectConvertToTypeCallbackEx
    privateData*: pointer    ## ```
                             ##   version 1000 only
                             ## ```
  
  JSChar* = Char16 ## ```
                   ##   !
                   ##   @typedef JSChar
                   ##   @abstract A UTF-16 code unit. One, or a sequence of two, can encode any Unicode
                   ##    character. As with all scalar types, endianness depends on the underlying
                   ##    architecture.
                   ## ```
  ULChar16* = Char16
  ULConfig* = pointer
  ULRenderer* = pointer
  ULSession* = pointer
  ULView* = distinct pointer
  ULBitmap* = distinct pointer
  ULBuffer* = pointer
  ULKeyEvent* = pointer
  ULMouseEvent* = pointer
  ULScrollEvent* = pointer
  ULSurface* = distinct pointer
  ULBitmapSurface* = ULSurface
  ULFaceWinding* {.size: sizeof(cint).} = enum
    fwClockwise, fwCounterClockwise
  ULFontHinting* {.size: sizeof(cint).} = enum
    fhSmooth, fhNormal, fhMonochrome
  ULRect* {.bycopy.} = object
    left*: cfloat
    top*: cfloat
    right*: cfloat
    bottom*: cfloat

  ULIntRect* {.bycopy.} = object
    left*: cint
    top*: cint
    right*: cint
    bottom*: cint

  ULRenderTarget* {.bycopy.} = object
    is_empty*: bool
    width*: cuint
    height*: cuint
    texture_id*: cuint
    texture_width*: cuint
    texture_height*: cuint
    texture_format*: ULBitmapFormat
    uv_coords*: ULRect
    render_buffer_id*: cuint

  ULChangeTitleCallback* = proc (user_data: pointer; caller: ULView;
                                 title: ULStringRef) {.cdecl.}
  ULChangeURLCallback* = proc (user_data: pointer; caller: ULView;
                               url: ULStringRef) {.cdecl.}
  ULChangeTooltipCallback* = proc (user_data: pointer; caller: ULView;
                                   tooltip: ULStringRef) {.cdecl.}
  ULChangeCursorCallback* = proc (user_data: pointer; caller: ULView;
                                  cursor: ULCursor) {.cdecl.}
  ULAddConsoleMessageCallback* = proc (user_data: pointer; caller: ULView;
                                       source: ULMessageSource;
                                       level: ULMessageLevel;
                                       message: ULStringRef; line_number: cuint;
                                       column_number: cuint;
                                       source_id: ULStringRef) {.cdecl.}
  ULCreateChildViewCallback* = proc (user_data: pointer; caller: ULView;
                                     opener_url: ULStringRef;
                                     target_url: ULStringRef; is_popup: bool;
                                     popup_rect: ULIntRect): ULView {.cdecl.}
  ULBeginLoadingCallback* = proc (user_data: pointer; caller: ULView;
                                  frame_id: culonglong; is_main_frame: bool;
                                  url: ULStringRef) {.cdecl.}
  ULFinishLoadingCallback* = proc (user_data: pointer; caller: ULView;
                                   frame_id: culonglong; is_main_frame: bool;
                                   url: ULStringRef) {.cdecl.}
  ULFailLoadingCallback* = proc (user_data: pointer; caller: ULView;
                                 frame_id: culonglong; is_main_frame: bool;
                                 url: ULStringRef; description: ULStringRef;
                                 error_domain: ULStringRef; error_code: cint) {.
      cdecl.}
  ULWindowObjectReadyCallback* = proc (user_data: pointer; caller: ULView;
                                       frame_id: culonglong;
                                       is_main_frame: bool; url: ULStringRef) {.
      cdecl.}
  ULDOMReadyCallback* = proc (user_data: pointer; caller: ULView;
                              frame_id: culonglong; is_main_frame: bool;
                              url: ULStringRef) {.cdecl.}
  ULUpdateHistoryCallback* = proc (user_data: pointer; caller: ULView) {.cdecl.}
  ULSurfaceDefinitionCreateCallback* = proc (width: cuint; height: cuint): pointer {.
      cdecl.}
  ULSurfaceDefinitionDestroyCallback* = proc (user_data: pointer) {.cdecl.}
  ULSurfaceDefinitionGetWidthCallback* = proc (user_data: pointer): cuint {.
      cdecl.}
  ULSurfaceDefinitionGetHeightCallback* = proc (user_data: pointer): cuint {.
      cdecl.}
  ULSurfaceDefinitionGetRowBytesCallback* = proc (user_data: pointer): cuint {.
      cdecl.}
  ULSurfaceDefinitionGetSizeCallback* = proc (user_data: pointer): uint {.cdecl.}
  ULSurfaceDefinitionLockPixelsCallback* = proc (user_data: pointer): pointer {.
      cdecl.}
  ULSurfaceDefinitionUnlockPixelsCallback* = proc (user_data: pointer) {.cdecl.}
  ULSurfaceDefinitionResizeCallback* = proc (user_data: pointer; width: cuint;
      height: cuint) {.cdecl.}
  ULSurfaceDefinition* {.bycopy.} = object
    create*: ULSurfaceDefinitionCreateCallback
    destroy*: ULSurfaceDefinitionDestroyCallback
    get_width*: ULSurfaceDefinitionGetWidthCallback
    get_height*: ULSurfaceDefinitionGetHeightCallback
    get_row_bytes*: ULSurfaceDefinitionGetRowBytesCallback
    get_size*: ULSurfaceDefinitionGetSizeCallback
    lock_pixels*: ULSurfaceDefinitionLockPixelsCallback
    unlock_pixels*: ULSurfaceDefinitionUnlockPixelsCallback
    resize*: ULSurfaceDefinitionResizeCallback

  ULFileHandle* = cint
  ULFileSystemFileExistsCallback* = proc (path: ULStringRef): bool {.cdecl.}
  ULFileSystemGetFileSizeCallback* = proc (handle: ULFileHandle;
      result: ptr clonglong): bool {.cdecl.}
  ULFileSystemGetFileMimeTypeCallback* = proc (path: ULStringRef;
      result: ULStringRef): bool {.cdecl.}
  ULFileSystemOpenFileCallback* = proc (path: ULStringRef;
                                        open_for_writing: bool): ULFileHandle {.
      cdecl.}
  ULFileSystemCloseFileCallback* = proc (handle: ULFileHandle) {.cdecl.}
  ULFileSystemReadFromFileCallback* = proc (handle: ULFileHandle; data: cstring;
      length: clonglong): clonglong {.cdecl.}
  ULFileSystem* {.bycopy.} = object
    file_exists*: ULFileSystemFileExistsCallback
    get_file_size*: ULFileSystemGetFileSizeCallback
    get_file_mime_type*: ULFileSystemGetFileMimeTypeCallback
    open_file*: ULFileSystemOpenFileCallback
    close_file*: ULFileSystemCloseFileCallback
    read_from_file*: ULFileSystemReadFromFileCallback

  ULLoggerLogMessageCallback* = proc (log_level: ULLogLevel;
                                      message: ULStringRef) {.cdecl.}
  ULLogger* {.bycopy.} = object
    log_message*: ULLoggerLogMessageCallback

  ULRenderBuffer* {.bycopy.} = object ## ```
                                       ##   ***************************************************************************
                                       ##    GPUDriver
                                       ##   **************************************************************************
                                       ##     /
                                       ##     / Render buffer description.
                                       ##     /
                                       ## ```
    texture_id*: cuint       ## ```
                             ##   The backing texture for this RenderBuffer
                             ## ```
    width*: cuint            ## ```
                             ##   The width of the RenderBuffer texture
                             ## ```
    height*: cuint           ## ```
                             ##   The height of the RenderBuffer texture
                             ## ```
    has_stencil_buffer*: bool ## ```
                              ##   Currently unused, always false.
                              ## ```
    has_depth_buffer*: bool  ## ```
                             ##   Currently unsued, always false.
                             ## ```
  
  ULVertex_2f_4ub_2f* {.bycopy.} = object ## ```
                                           ##   /
                                           ##     / Vertex layout for path vertices.
                                           ##     /
                                           ##     / (this struct's members aligned on single-byte boundaries)
                                           ##     /
                                           ## ```
    pos*: array[2, cfloat]
    color*: array[4, cuchar]
    obj*: array[2, cfloat]

  ULVertex_2f_4ub_2f_2f_28f* {.bycopy.} = object ## ```
                                                  ##   /
                                                  ##     / Vertex layout for quad vertices.
                                                  ##     /
                                                  ##     / (this struct's members aligned on single-byte boundaries)
                                                  ##     /
                                                  ## ```
    pos*: array[2, cfloat]
    color*: array[4, cuchar]
    tex*: array[2, cfloat]
    obj*: array[2, cfloat]
    data0*: array[4, cfloat]
    data1*: array[4, cfloat]
    data2*: array[4, cfloat]
    data3*: array[4, cfloat]
    data4*: array[4, cfloat]
    data5*: array[4, cfloat]
    data6*: array[4, cfloat]

  ULVertexBuffer* {.bycopy.} = object ## ```
                                       ##   /
                                       ##     / Vertex buffer data.
                                       ##     /
                                       ## ```
    format*: ULVertexBufferFormat
    size*: cuint
    data*: ptr cuchar

  ULIndexType* = cuint       ## ```
                             ##   /
                             ##     / Vertex index type.
                             ##     /
                             ## ```
  ULIndexBuffer* {.bycopy.} = object ## ```
                                      ##   /
                                      ##     / Vertex index buffer data.
                                      ##     /
                                      ## ```
    size*: cuint
    data*: ptr cuchar

  ULMatrix4x4* {.bycopy.} = object ## ```
                                    ##   /
                                    ##     / Raw 4x4 matrix as an array of floats
                                    ##     /
                                    ## ```
    data*: array[16, cfloat]

  ULvec4* {.bycopy.} = object ## ```
                               ##   /
                               ##     / 4-component float vector
                               ##     /
                               ## ```
    value*: array[4, cfloat]

  ULGPUState* {.bycopy.} = object ## ```
                                   ##   /
                                   ##     / GPU State description.
                                   ##     /
                                   ## ```
    viewport_width*: cuint   ## ```
                             ##   / Viewport width in pixels
                             ## ```
    viewport_height*: cuint  ## ```
                             ##   / Viewport height in pixels
                             ## ```
    transform*: ULMatrix4x4 ## ```
                            ##   / Transform matrix-- you should multiply this with the screen-space
                            ##     / orthographic projection matrix then pass to the vertex shader.
                            ## ```
    enable_texturing*: bool ## ```
                            ##   / Whether or not we should enable texturing for the current draw command.
                            ## ```
    enable_blend*: bool ## ```
                        ##   / Whether or not we should enable blending for the current draw command.
                        ##     / If blending is disabled, any drawn pixels should overwrite existing.
                        ##     / Mainly used so we can modify alpha values of the RenderBuffer during
                        ##     / scissored clears.
                        ## ```
    shader_type*: cuchar ## ```
                         ##   / The vertex/pixel shader program pair to use for the current draw command.
                         ##     / You should cast this to ShaderType to get the corresponding enum.
                         ## ```
    render_buffer_id*: cuint ## ```
                             ##   / The render buffer to use for the current draw command.
                             ## ```
    texture_1_id*: cuint ## ```
                         ##   / The texture id to bind to slot #1. (Will be 0 if none)
                         ## ```
    texture_2_id*: cuint ## ```
                         ##   / The texture id to bind to slot #2. (Will be 0 if none)
                         ## ```
    texture_3_id*: cuint ## ```
                         ##   / The texture id to bind to slot #3. (Will be 0 if none)
                         ## ```
    uniform_scalar*: array[8, cfloat] ## ```
                                      ##   / The following four members are passed to the pixel shader via uniforms.
                                      ## ```
    uniform_vector*: array[8, ULvec4]
    clip_size*: cuchar
    clip*: array[8, ULMatrix4x4]
    enable_scissor*: bool ## ```
                          ##   / Whether or not scissor testing should be used for the current draw
                          ##     / command.
                          ## ```
    scissor_rect*: ULIntRect ## ```
                             ##   / The scissor rect to use for scissor testing (units in pixels)
                             ## ```
  
  ULCommand* {.bycopy.} = object ## ```
                                  ##   /
                                  ##     / Command description.
                                  ##     /
                                  ## ```
    command_type*: cuchar    ## ```
                             ##   The type of command to dispatch.
                             ## ```
    gpu_state*: ULGPUState ## ```
                           ##   GPU state parameters for current command.
                           ##     / The following members are only used with kCommandType_DrawGeometry
                           ## ```
    geometry_id*: cuint      ## ```
                             ##   The geometry ID to bind
                             ## ```
    indices_count*: cuint    ## ```
                             ##   The number of indices
                             ## ```
    indices_offset*: cuint   ## ```
                             ##   The index to start from
                             ## ```
  
  ULCommandList* {.bycopy.} = object ## ```
                                      ##   /
                                      ##     / Command list, @see ULGPUDriverUpdateCommandList
                                      ## ```
    size*: cuint
    commands*: ptr ULCommand

  ULGPUDriverBeginSynchronizeCallback* = proc () {.cdecl.}
  ULGPUDriverEndSynchronizeCallback* = proc () {.cdecl.}
  ULGPUDriverNextTextureIdCallback* = proc (): cuint {.cdecl.}
  ULGPUDriverCreateTextureCallback* = proc (texture_id: cuint; bitmap: ULBitmap) {.
      cdecl.}
  ULGPUDriverUpdateTextureCallback* = proc (texture_id: cuint; bitmap: ULBitmap) {.
      cdecl.}
  ULGPUDriverDestroyTextureCallback* = proc (texture_id: cuint) {.cdecl.}
  ULGPUDriverNextRenderBufferIdCallback* = proc (): cuint {.cdecl.}
  ULGPUDriverCreateRenderBufferCallback* = proc (render_buffer_id: cuint;
      buffer: ULRenderBuffer) {.cdecl.}
  ULGPUDriverDestroyRenderBufferCallback* = proc (render_buffer_id: cuint) {.
      cdecl.}
  ULGPUDriverNextGeometryIdCallback* = proc (): cuint {.cdecl.}
  ULGPUDriverCreateGeometryCallback* = proc (geometry_id: cuint;
      vertices: ULVertexBuffer; indices: ULIndexBuffer) {.cdecl.}
  ULGPUDriverUpdateGeometryCallback* = proc (geometry_id: cuint;
      vertices: ULVertexBuffer; indices: ULIndexBuffer) {.cdecl.}
  ULGPUDriverDestroyGeometryCallback* = proc (geometry_id: cuint) {.cdecl.}
  ULGPUDriverUpdateCommandListCallback* = proc (list: ULCommandList) {.cdecl.}
  ULGPUDriver* {.bycopy.} = object
    begin_synchronize*: ULGPUDriverBeginSynchronizeCallback
    end_synchronize*: ULGPUDriverEndSynchronizeCallback
    next_texture_id*: ULGPUDriverNextTextureIdCallback
    create_texture*: ULGPUDriverCreateTextureCallback
    update_texture*: ULGPUDriverUpdateTextureCallback
    destroy_texture*: ULGPUDriverDestroyTextureCallback
    next_render_buffer_id*: ULGPUDriverNextRenderBufferIdCallback
    create_render_buffer*: ULGPUDriverCreateRenderBufferCallback
    destroy_render_buffer*: ULGPUDriverDestroyRenderBufferCallback
    next_geometry_id*: ULGPUDriverNextGeometryIdCallback
    create_geometry*: ULGPUDriverCreateGeometryCallback
    update_geometry*: ULGPUDriverUpdateGeometryCallback
    destroy_geometry*: ULGPUDriverDestroyGeometryCallback
    update_command_list*: ULGPUDriverUpdateCommandListCallback

  ULClipboardClearCallback* = proc () {.cdecl.}
  ULClipboardReadPlainTextCallback* = proc (result: ULStringRef) {.cdecl.}
  ULClipboardWritePlainTextCallback* = proc (text: ULStringRef) {.cdecl.}
  ULClipboard* {.bycopy.} = object
    clear*: ULClipboardClearCallback
    read_plain_text*: ULClipboardReadPlainTextCallback
    write_plain_text*: ULClipboardWritePlainTextCallback

  ULSettings* = pointer
  ULApp* = pointer
  ULWindow* = pointer
  ULMonitor* = distinct pointer
  ULOverlay* = distinct pointer
  ULWindowFlags* {.size: sizeof(cuint).} = enum
    wfBorderless = 1 shl 0, wfTitled = 1 shl 1, wfResizable = 1 shl 2,
    wfMaximizable = 1 shl 3
  ULUpdateCallback* = proc (user_data: pointer) {.cdecl.}
  ULCloseCallback* = proc (user_data: pointer) {.cdecl.}
  ULResizeCallback* = proc (user_data: pointer; width: cuint; height: cuint) {.
      cdecl.}
var kJSClassDefinitionEmpty* {.importc.}: JSClassDefinition ## ```
                                                            ##   ! 
                                                            ##   @const kJSClassDefinitionEmpty 
                                                            ##   @abstract A JSClassDefinition structure of the current version, filled with NULL pointers and having no attributes.
                                                            ##   @discussion Use this constant as a convenience when creating class definitions. For example, to create a class definition with only a finalize method:
                                                            ##   
                                                            ##   JSClassDefinition definition = kJSClassDefinitionEmpty;
                                                            ##   definition.finalize = Finalize;
                                                            ## ```
proc JSEvaluateScript*(ctx: JSContextRef; script: JSStringRef;
                       thisObject: JSObjectRef; sourceURL: JSStringRef;
                       startingLineNumber: cint; exception: ptr JSValueRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   Script Evaluation 
                    ##     !
                    ##   @function JSEvaluateScript
                    ##   @abstract Evaluates a string of JavaScript.
                    ##   @param ctx The execution context to use.
                    ##   @param script A JSString containing the script to evaluate.
                    ##   @param thisObject The object to use as "this," or NULL to use the global object as "this."
                    ##   @param sourceURL A JSString containing a URL for the script's source file. This is used by debuggers and when reporting exceptions. Pass NULL if you do not care to include source file information.
                    ##   @param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
                    ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##   @result The JSValue that results from evaluating script, or NULL if an exception is thrown.
                    ## ```
proc JSCheckScriptSyntax*(ctx: JSContextRef; script: JSStringRef;
                          sourceURL: JSStringRef; startingLineNumber: cint;
                          exception: ptr JSValueRef): bool {.importc, cdecl.}
  ## ```
                                                                             ##   !
                                                                             ##   @function JSCheckScriptSyntax
                                                                             ##   @abstract Checks for syntax errors in a string of JavaScript.
                                                                             ##   @param ctx The execution context to use.
                                                                             ##   @param script A JSString containing the script to check for syntax errors.
                                                                             ##   @param sourceURL A JSString containing a URL for the script's source file. This is only used when reporting exceptions. Pass NULL if you do not care to include source file information in exceptions.
                                                                             ##   @param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
                                                                             ##   @param exception A pointer to a JSValueRef in which to store a syntax error exception, if any. Pass NULL if you do not care to store a syntax error exception.
                                                                             ##   @result true if the script is syntactically correct, otherwise false.
                                                                             ## ```
proc JSGarbageCollect*(ctx: JSContextRef) {.importc, cdecl.}
  ## ```
                                                            ##   !
                                                            ##   @function JSGarbageCollect
                                                            ##   @abstract Performs a JavaScript garbage collection.
                                                            ##   @param ctx The execution context to use.
                                                            ##   @discussion JavaScript values that are on the machine stack, in a register,
                                                            ##    protected by JSValueProtect, set as the global object of an execution context,
                                                            ##    or reachable from any such value will not be collected.
                                                            ##   
                                                            ##    During JavaScript execution, you are not required to call this function; the
                                                            ##    JavaScript engine will garbage collect as needed. JavaScript values created
                                                            ##    within a context group are automatically destroyed when the last reference
                                                            ##    to the context group is released.
                                                            ## ```
proc JSValueGetType*(ctx: JSContextRef; value: JSValueRef): JSType {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Returns a JavaScript value's type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue whose type you want to obtain.
           ##   @result         A value of type JSType that identifies value's type.
           ## ```
proc JSValueIsUndefined*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the undefined type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the undefined type, otherwise false.
           ## ```
proc JSValueIsNull*(ctx: JSContextRef; value: JSValueRef): bool {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##   @function
                                                                                  ##   @abstract       Tests whether a JavaScript value's type is the null type.
                                                                                  ##   @param ctx  The execution context to use.
                                                                                  ##   @param value    The JSValue to test.
                                                                                  ##   @result         true if value's type is the null type, otherwise false.
                                                                                  ## ```
proc JSValueIsBoolean*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the boolean type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the boolean type, otherwise false.
           ## ```
proc JSValueIsNumber*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the number type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the number type, otherwise false.
           ## ```
proc JSValueIsString*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the string type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the string type, otherwise false.
           ## ```
proc JSValueIsSymbol*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the symbol type.
           ##   @param ctx      The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the symbol type, otherwise false.
           ## ```
proc JSValueIsObject*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value's type is the object type.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value's type is the object type, otherwise false.
           ## ```
proc JSValueIsObjectOfClass*(ctx: JSContextRef; value: JSValueRef;
                             jsClass: JSClassRef): bool {.importc, cdecl.}
  ## ```
                                                                          ##   !
                                                                          ##   @function
                                                                          ##   @abstract Tests whether a JavaScript value is an object with a given class in its class chain.
                                                                          ##   @param ctx The execution context to use.
                                                                          ##   @param value The JSValue to test.
                                                                          ##   @param jsClass The JSClass to test against.
                                                                          ##   @result true if value is an object and has jsClass in its class chain, otherwise false.
                                                                          ## ```
proc JSValueIsArray*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Tests whether a JavaScript value is an array.
           ##   @param ctx      The execution context to use.
           ##   @param value    The JSValue to test.
           ##   @result         true if value is an array, otherwise false.
           ## ```
proc JSValueIsDate*(ctx: JSContextRef; value: JSValueRef): bool {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##   @function
                                                                                  ##   @abstract       Tests whether a JavaScript value is a date.
                                                                                  ##   @param ctx      The execution context to use.
                                                                                  ##   @param value    The JSValue to test.
                                                                                  ##   @result         true if value is a date, otherwise false.
                                                                                  ## ```
proc JSValueGetTypedArrayType*(ctx: JSContextRef; value: JSValueRef;
                               exception: ptr JSValueRef): JSTypedArrayType {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract           Returns a JavaScript value's Typed Array type.
                    ##   @param ctx          The execution context to use.
                    ##   @param value        The JSValue whose Typed Array type to return.
                    ##   @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##   @result             A value of type JSTypedArrayType that identifies value's Typed Array type, or kJSTypedArrayTypeNone if the value is not a Typed Array object.
                    ## ```
proc JSValueIsEqual*(ctx: JSContextRef; a: JSValueRef; b: JSValueRef;
                     exception: ptr JSValueRef): bool {.importc, cdecl.}
  ## ```
                                                                        ##   Comparing values 
                                                                        ##     !
                                                                        ##   @function
                                                                        ##   @abstract Tests whether two JavaScript values are equal, as compared by the JS == operator.
                                                                        ##   @param ctx The execution context to use.
                                                                        ##   @param a The first value to test.
                                                                        ##   @param b The second value to test.
                                                                        ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                        ##   @result true if the two values are equal, false if they are not equal or an exception is thrown.
                                                                        ## ```
proc JSValueIsStrictEqual*(ctx: JSContextRef; a: JSValueRef; b: JSValueRef): bool {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract       Tests whether two JavaScript values are strict equal, as compared by the JS === operator.
                    ##   @param ctx  The execution context to use.
                    ##   @param a        The first value to test.
                    ##   @param b        The second value to test.
                    ##   @result         true if the two values are strict equal, otherwise false.
                    ## ```
proc JSValueIsInstanceOfConstructor*(ctx: JSContextRef; value: JSValueRef;
                                     constructor: JSObjectRef;
                                     exception: ptr JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Tests whether a JavaScript value is an object constructed by a given constructor, as compared by the JS instanceof operator.
           ##   @param ctx The execution context to use.
           ##   @param value The JSValue to test.
           ##   @param constructor The constructor to test against.
           ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##   @result true if value is an object constructed by constructor, as compared by the JS instanceof operator, otherwise false.
           ## ```
proc JSValueMakeUndefined*(ctx: JSContextRef): JSValueRef {.importc, cdecl.}
  ## ```
                                                                            ##   Creating values 
                                                                            ##     !
                                                                            ##   @function
                                                                            ##   @abstract       Creates a JavaScript value of the undefined type.
                                                                            ##   @param ctx  The execution context to use.
                                                                            ##   @result         The unique undefined value.
                                                                            ## ```
proc JSValueMakeNull*(ctx: JSContextRef): JSValueRef {.importc, cdecl.}
  ## ```
                                                                       ##   !
                                                                       ##   @function
                                                                       ##   @abstract       Creates a JavaScript value of the null type.
                                                                       ##   @param ctx  The execution context to use.
                                                                       ##   @result         The unique null value.
                                                                       ## ```
proc JSValueMakeBoolean*(ctx: JSContextRef; boolean: bool): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract       Creates a JavaScript value of the boolean type.
                    ##   @param ctx  The execution context to use.
                    ##   @param boolean  The bool to assign to the newly created JSValue.
                    ##   @result         A JSValue of the boolean type, representing the value of boolean.
                    ## ```
proc JSValueMakeNumber*(ctx: JSContextRef; number: cdouble): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract       Creates a JavaScript value of the number type.
                    ##   @param ctx  The execution context to use.
                    ##   @param number   The double to assign to the newly created JSValue.
                    ##   @result         A JSValue of the number type, representing the value of number.
                    ## ```
proc JSValueMakeString*(ctx: JSContextRef; string: JSStringRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract       Creates a JavaScript value of the string type.
                    ##   @param ctx  The execution context to use.
                    ##   @param string   The JSString to assign to the newly created JSValue. The
                    ##    newly created JSValue retains string, and releases it upon garbage collection.
                    ##   @result         A JSValue of the string type, representing the value of string.
                    ## ```
proc JSValueMakeSymbol*(ctx: JSContextRef; description: JSStringRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract            Creates a JavaScript value of the symbol type.
                    ##    @param ctx           The execution context to use.
                    ##    @param description   A description of the newly created symbol value.
                    ##    @result              A unique JSValue of the symbol type, whose description matches the one provided.
                    ## ```
proc JSValueMakeFromJSONString*(ctx: JSContextRef; string: JSStringRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   Converting to and from JSON formatted strings 
                    ##     !
                    ##    @function
                    ##    @abstract       Creates a JavaScript value from a JSON formatted string.
                    ##    @param ctx      The execution context to use.
                    ##    @param string   The JSString containing the JSON string to be parsed.
                    ##    @result         A JSValue containing the parsed value, or NULL if the input is invalid.
                    ## ```
proc JSValueCreateJSONString*(ctx: JSContextRef; value: JSValueRef;
                              indent: cuint; exception: ptr JSValueRef): JSStringRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract       Creates a JavaScript string containing the JSON serialized representation of a JS value.
                    ##    @param ctx      The execution context to use.
                    ##    @param value    The value to serialize.
                    ##    @param indent   The number of spaces to indent when nesting.  If 0, the resulting JSON will not contains newlines.  The size of the indent is clamped to 10 spaces.
                    ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result         A JSString with the result of serialization, or NULL if an exception is thrown.
                    ## ```
proc JSValueToBoolean*(ctx: JSContextRef; value: JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   Converting to primitive values 
           ##     !
           ##   @function
           ##   @abstract       Converts a JavaScript value to boolean and returns the resulting boolean.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to convert.
           ##   @result         The boolean result of conversion.
           ## ```
proc JSValueToNumber*(ctx: JSContextRef; value: JSValueRef;
                      exception: ptr JSValueRef): cdouble {.importc, cdecl.}
  ## ```
                                                                            ##   !
                                                                            ##   @function
                                                                            ##   @abstract       Converts a JavaScript value to number and returns the resulting number.
                                                                            ##   @param ctx  The execution context to use.
                                                                            ##   @param value    The JSValue to convert.
                                                                            ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                            ##   @result         The numeric result of conversion, or NaN if an exception is thrown.
                                                                            ## ```
proc JSValueToStringCopy*(ctx: JSContextRef; value: JSValueRef;
                          exception: ptr JSValueRef): JSStringRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract       Converts a JavaScript value to string and copies the result into a JavaScript string.
           ##   @param ctx  The execution context to use.
           ##   @param value    The JSValue to convert.
           ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##   @result         A JSString with the result of conversion, or NULL if an exception is thrown. Ownership follows the Create Rule.
           ## ```
proc JSValueToObject*(ctx: JSContextRef; value: JSValueRef;
                      exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                                ##   !
                                                                                ##   @function
                                                                                ##   @abstract Converts a JavaScript value to object and returns the resulting object.
                                                                                ##   @param ctx  The execution context to use.
                                                                                ##   @param value    The JSValue to convert.
                                                                                ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                                ##   @result         The JSObject result of conversion, or NULL if an exception is thrown.
                                                                                ## ```
proc JSValueProtect*(ctx: JSContextRef; value: JSValueRef) {.importc, cdecl.}
  ## ```
                                                                             ##   Garbage collection 
                                                                             ##     !
                                                                             ##   @function
                                                                             ##   @abstract Protects a JavaScript value from garbage collection.
                                                                             ##   @param ctx The execution context to use.
                                                                             ##   @param value The JSValue to protect.
                                                                             ##   @discussion Use this method when you want to store a JSValue in a global or on the heap, where the garbage collector will not be able to discover your reference to it.
                                                                             ##    
                                                                             ##   A value may be protected multiple times and must be unprotected an equal number of times before becoming eligible for garbage collection.
                                                                             ## ```
proc JSValueUnprotect*(ctx: JSContextRef; value: JSValueRef) {.importc, cdecl.}
  ## ```
                                                                               ##   !
                                                                               ##   @function
                                                                               ##   @abstract       Unprotects a JavaScript value from garbage collection.
                                                                               ##   @param ctx      The execution context to use.
                                                                               ##   @param value    The JSValue to unprotect.
                                                                               ##   @discussion     A value may be protected multiple times and must be unprotected an 
                                                                               ##    equal number of times before becoming eligible for garbage collection.
                                                                               ## ```
proc JSClassCreate*(definition: ptr JSClassDefinition): JSClassRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Creates a JavaScript class suitable for use with JSObjectMake.
           ##   @param definition A JSClassDefinition that defines the class.
           ##   @result A JSClass with the given definition. Ownership follows the Create Rule.
           ## ```
proc JSClassRetain*(jsClass: JSClassRef): JSClassRef {.importc, cdecl.}
  ## ```
                                                                       ##   !
                                                                       ##   @function
                                                                       ##   @abstract Retains a JavaScript class.
                                                                       ##   @param jsClass The JSClass to retain.
                                                                       ##   @result A JSClass that is the same as jsClass.
                                                                       ## ```
proc JSClassRelease*(jsClass: JSClassRef) {.importc, cdecl.}
  ## ```
                                                            ##   !
                                                            ##   @function
                                                            ##   @abstract Releases a JavaScript class.
                                                            ##   @param jsClass The JSClass to release.
                                                            ## ```
proc JSClassGetPrivate*(jsClass: JSClassRef): pointer {.importc, cdecl.}
  ## ```
                                                                        ##   !
                                                                        ##   @function
                                                                        ##   @abstract Retrieves the private data from a class reference, only possible with classes created with version 1000 (extended callbacks).
                                                                        ##   @param jsClass The class to get the data from
                                                                        ##   @result The private data on the class, or NULL, if not set
                                                                        ##   @discussion Only classes with version 1000 (extended callbacks) can store private data, for other classes always NULL will always be returned.
                                                                        ## ```
proc JSClassSetPrivate*(jsClass: JSClassRef; data: pointer): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Sets the private data on a class, only possible with classes created with version 1000 (extended callbacks).
           ##   @param jsClass The class to set the data on
           ##   @param data A void* to set as the private data for the class
           ##   @result true if the data has been set on the class, false if the class has not been created with version 1000 (extended callbacks)
           ##   @discussion Only classes with version 1000 (extended callbacks) can store private data, for other classes the function always fails. The set pointer is not touched by the engine.
           ## ```
proc JSObjectMake*(ctx: JSContextRef; jsClass: JSClassRef; data: pointer): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Creates a JavaScript object.
                    ##   @param ctx The execution context to use.
                    ##   @param jsClass The JSClass to assign to the object. Pass NULL to use the default object class.
                    ##   @param data A void* to set as the object's private data. Pass NULL to specify no private data.
                    ##   @result A JSObject with the given class and private data.
                    ##   @discussion The default object class does not allocate storage for private data, so you must provide a non-NULL jsClass to JSObjectMake if you want your object to be able to store private data.
                    ##   
                    ##   data is set on the created object before the intialize methods in its class chain are called. This enables the initialize methods to retrieve and manipulate data through JSObjectGetPrivate.
                    ## ```
proc JSObjectMakeFunctionWithCallback*(ctx: JSContextRef; name: JSStringRef;
    callAsFunction: JSObjectCallAsFunctionCallback): JSObjectRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Convenience method for creating a JavaScript function with a given callback as its implementation.
           ##   @param ctx The execution context to use.
           ##   @param name A JSString containing the function's name. This will be used when converting the function to string. Pass NULL to create an anonymous function.
           ##   @param callAsFunction The JSObjectCallAsFunctionCallback to invoke when the function is called.
           ##   @result A JSObject that is a function. The object's prototype will be the default function prototype.
           ## ```
proc JSObjectMakeConstructor*(ctx: JSContextRef; jsClass: JSClassRef;
    callAsConstructor: JSObjectCallAsConstructorCallback): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Convenience method for creating a JavaScript constructor.
                    ##   @param ctx The execution context to use.
                    ##   @param jsClass A JSClass that is the class your constructor will assign to the objects its constructs. jsClass will be used to set the constructor's .prototype property, and to evaluate 'instanceof' expressions. Pass NULL to use the default object class.
                    ##   @param callAsConstructor A JSObjectCallAsConstructorCallback to invoke when your constructor is used in a 'new' expression. Pass NULL to use the default object constructor.
                    ##   @result A JSObject that is a constructor. The object's prototype will be the default object prototype.
                    ##   @discussion The default object constructor takes no arguments and constructs an object of class jsClass with no private data.
                    ## ```
proc JSObjectMakeArray*(ctx: JSContextRef; argumentCount: uint;
                        arguments: UncheckedArray[JSValueRef];
                        exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##    @function
                                                                                  ##    @abstract Creates a JavaScript Array object.
                                                                                  ##    @param ctx The execution context to use.
                                                                                  ##    @param argumentCount An integer count of the number of arguments in arguments.
                                                                                  ##    @param arguments A JSValue array of data to populate the Array with. Pass NULL if argumentCount is 0.
                                                                                  ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                                  ##    @result A JSObject that is an Array.
                                                                                  ##    @discussion The behavior of this function does not exactly match the behavior of the built-in Array constructor. Specifically, if one argument 
                                                                                  ##    is supplied, this function returns an array with one element.
                                                                                  ## ```
proc JSObjectMakeDate*(ctx: JSContextRef; argumentCount: uint;
                       arguments: UncheckedArray[JSValueRef];
                       exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                                 ##   !
                                                                                 ##    @function
                                                                                 ##    @abstract Creates a JavaScript Date object, as if by invoking the built-in Date constructor.
                                                                                 ##    @param ctx The execution context to use.
                                                                                 ##    @param argumentCount An integer count of the number of arguments in arguments.
                                                                                 ##    @param arguments A JSValue array of arguments to pass to the Date Constructor. Pass NULL if argumentCount is 0.
                                                                                 ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                                 ##    @result A JSObject that is a Date.
                                                                                 ## ```
proc JSObjectMakeError*(ctx: JSContextRef; argumentCount: uint;
                        arguments: UncheckedArray[JSValueRef];
                        exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##    @function
                                                                                  ##    @abstract Creates a JavaScript Error object, as if by invoking the built-in Error constructor.
                                                                                  ##    @param ctx The execution context to use.
                                                                                  ##    @param argumentCount An integer count of the number of arguments in arguments.
                                                                                  ##    @param arguments A JSValue array of arguments to pass to the Error Constructor. Pass NULL if argumentCount is 0.
                                                                                  ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                                  ##    @result A JSObject that is a Error.
                                                                                  ## ```
proc JSObjectMakeRegExp*(ctx: JSContextRef; argumentCount: uint;
                         arguments: UncheckedArray[JSValueRef];
                         exception: ptr JSValueRef): JSObjectRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##    @function
           ##    @abstract Creates a JavaScript RegExp object, as if by invoking the built-in RegExp constructor.
           ##    @param ctx The execution context to use.
           ##    @param argumentCount An integer count of the number of arguments in arguments.
           ##    @param arguments A JSValue array of arguments to pass to the RegExp Constructor. Pass NULL if argumentCount is 0.
           ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##    @result A JSObject that is a RegExp.
           ## ```
proc JSObjectMakeDeferredPromise*(ctx: JSContextRef; resolve: ptr JSObjectRef;
                                  reject: ptr JSObjectRef;
                                  exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract Creates a JavaScript promise object by invoking the provided executor.
                    ##    @param ctx The execution context to use.
                    ##    @param resolve A pointer to a JSObjectRef in which to store the resolve function for the new promise. Pass NULL if you do not care to store the resolve callback.
                    ##    @param reject A pointer to a JSObjectRef in which to store the reject function for the new promise. Pass NULL if you do not care to store the reject callback.
                    ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result A JSObject that is a promise or NULL if an exception occurred.
                    ## ```
proc JSObjectMakeFunction*(ctx: JSContextRef; name: JSStringRef;
                           parameterCount: cuint;
                           parameterNames: UncheckedArray[JSStringRef];
                           body: JSStringRef; sourceURL: JSStringRef;
                           startingLineNumber: cint; exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Creates a function with a given script as its body.
                    ##   @param ctx The execution context to use.
                    ##   @param name A JSString containing the function's name. This will be used when converting the function to string. Pass NULL to create an anonymous function.
                    ##   @param parameterCount An integer count of the number of parameter names in parameterNames.
                    ##   @param parameterNames A JSString array containing the names of the function's parameters. Pass NULL if parameterCount is 0.
                    ##   @param body A JSString containing the script to use as the function's body.
                    ##   @param sourceURL A JSString containing a URL for the script's source file. This is only used when reporting exceptions. Pass NULL if you do not care to include source file information in exceptions.
                    ##   @param startingLineNumber An integer value specifying the script's starting line number in the file located at sourceURL. This is only used when reporting exceptions. The value is one-based, so the first line is line 1 and invalid values are clamped to 1.
                    ##   @param exception A pointer to a JSValueRef in which to store a syntax error exception, if any. Pass NULL if you do not care to store a syntax error exception.
                    ##   @result A JSObject that is a function, or NULL if either body or parameterNames contains a syntax error. The object's prototype will be the default function prototype.
                    ##   @discussion Use this method when you want to execute a script repeatedly, to avoid the cost of re-parsing the script before each execution.
                    ## ```
proc JSObjectGetPrototype*(ctx: JSContextRef; `object`: JSObjectRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets an object's prototype.
                    ##   @param ctx  The execution context to use.
                    ##   @param object A JSObject whose prototype you want to get.
                    ##   @result A JSValue that is the object's prototype.
                    ## ```
proc JSObjectSetPrototype*(ctx: JSContextRef; `object`: JSObjectRef;
                           value: JSValueRef) {.importc, cdecl.}
  ## ```
                                                                ##   !
                                                                ##   @function
                                                                ##   @abstract Sets an object's prototype.
                                                                ##   @param ctx  The execution context to use.
                                                                ##   @param object The JSObject whose prototype you want to set.
                                                                ##   @param value A JSValue to set as the object's prototype.
                                                                ## ```
proc JSObjectHasProperty*(ctx: JSContextRef; `object`: JSObjectRef;
                          propertyName: JSStringRef): bool {.importc, cdecl.}
  ## ```
                                                                             ##   !
                                                                             ##   @function
                                                                             ##   @abstract Tests whether an object has a given property.
                                                                             ##   @param object The JSObject to test.
                                                                             ##   @param propertyName A JSString containing the property's name.
                                                                             ##   @result true if the object has a property whose name matches propertyName, otherwise false.
                                                                             ## ```
proc JSObjectGetProperty*(ctx: JSContextRef; `object`: JSObjectRef;
                          propertyName: JSStringRef; exception: ptr JSValueRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets a property from an object.
                    ##   @param ctx The execution context to use.
                    ##   @param object The JSObject whose property you want to get.
                    ##   @param propertyName A JSString containing the property's name.
                    ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##   @result The property's value if object has the property, otherwise the undefined value.
                    ## ```
proc JSObjectSetProperty*(ctx: JSContextRef; `object`: JSObjectRef;
                          propertyName: JSStringRef; value: JSValueRef;
                          attributes: JSPropertyAttributes;
                          exception: ptr JSValueRef) {.importc, cdecl.}
  ## ```
                                                                       ##   !
                                                                       ##   @function
                                                                       ##   @abstract Sets a property on an object.
                                                                       ##   @param ctx The execution context to use.
                                                                       ##   @param object The JSObject whose property you want to set.
                                                                       ##   @param propertyName A JSString containing the property's name.
                                                                       ##   @param value A JSValueRef to use as the property's value.
                                                                       ##   @param attributes A logically ORed set of JSPropertyAttributes to give to the property.
                                                                       ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                       ## ```
proc JSObjectDeleteProperty*(ctx: JSContextRef; `object`: JSObjectRef;
                             propertyName: JSStringRef;
                             exception: ptr JSValueRef): bool {.importc, cdecl.}
  ## ```
                                                                                ##   !
                                                                                ##   @function
                                                                                ##   @abstract Deletes a property from an object.
                                                                                ##   @param ctx The execution context to use.
                                                                                ##   @param object The JSObject whose property you want to delete.
                                                                                ##   @param propertyName A JSString containing the property's name.
                                                                                ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                                ##   @result true if the delete operation succeeds, otherwise false (for example, if the property has the kJSPropertyAttributeDontDelete attribute set).
                                                                                ## ```
proc JSObjectHasPropertyForKey*(ctx: JSContextRef; `object`: JSObjectRef;
                                propertyKey: JSValueRef;
                                exception: ptr JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##    @function
           ##    @abstract Tests whether an object has a given property using a JSValueRef as the property key.
           ##    @param object The JSObject to test.
           ##    @param propertyKey A JSValueRef containing the property key to use when looking up the property.
           ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##    @result true if the object has a property whose name matches propertyKey, otherwise false.
           ##    @discussion This function is the same as performing "propertyKey in object" from JavaScript.
           ## ```
proc JSObjectGetPropertyForKey*(ctx: JSContextRef; `object`: JSObjectRef;
                                propertyKey: JSValueRef;
                                exception: ptr JSValueRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract Gets a property from an object using a JSValueRef as the property key.
                    ##    @param ctx The execution context to use.
                    ##    @param object The JSObject whose property you want to get.
                    ##    @param propertyKey A JSValueRef containing the property key to use when looking up the property.
                    ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result The property's value if object has the property key, otherwise the undefined value.
                    ##    @discussion This function is the same as performing "object[propertyKey]" from JavaScript.
                    ## ```
proc JSObjectSetPropertyForKey*(ctx: JSContextRef; `object`: JSObjectRef;
                                propertyKey: JSValueRef; value: JSValueRef;
                                attributes: JSPropertyAttributes;
                                exception: ptr JSValueRef) {.importc, cdecl.}
  ## ```
                                                                             ##   !
                                                                             ##    @function
                                                                             ##    @abstract Sets a property on an object using a JSValueRef as the property key.
                                                                             ##    @param ctx The execution context to use.
                                                                             ##    @param object The JSObject whose property you want to set.
                                                                             ##    @param propertyKey A JSValueRef containing the property key to use when looking up the property.
                                                                             ##    @param value A JSValueRef to use as the property's value.
                                                                             ##    @param attributes A logically ORed set of JSPropertyAttributes to give to the property.
                                                                             ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                             ##    @discussion This function is the same as performing "object[propertyKey] = value" from JavaScript.
                                                                             ## ```
proc JSObjectDeletePropertyForKey*(ctx: JSContextRef; `object`: JSObjectRef;
                                   propertyKey: JSValueRef;
                                   exception: ptr JSValueRef): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##    @function
           ##    @abstract Deletes a property from an object using a JSValueRef as the property key.
           ##    @param ctx The execution context to use.
           ##    @param object The JSObject whose property you want to delete.
           ##    @param propertyKey A JSValueRef containing the property key to use when looking up the property.
           ##    @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##    @result true if the delete operation succeeds, otherwise false (for example, if the property has the kJSPropertyAttributeDontDelete attribute set).
           ##    @discussion This function is the same as performing "delete object[propertyKey]" from JavaScript.
           ## ```
proc JSObjectGetPropertyAtIndex*(ctx: JSContextRef; `object`: JSObjectRef;
                                 propertyIndex: cuint; exception: ptr JSValueRef): JSValueRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets a property from an object by numeric index.
                    ##   @param ctx The execution context to use.
                    ##   @param object The JSObject whose property you want to get.
                    ##   @param propertyIndex An integer value that is the property's name.
                    ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##   @result The property's value if object has the property, otherwise the undefined value.
                    ##   @discussion Calling JSObjectGetPropertyAtIndex is equivalent to calling JSObjectGetProperty with a string containing propertyIndex, but JSObjectGetPropertyAtIndex provides optimized access to numeric properties.
                    ## ```
proc JSObjectSetPropertyAtIndex*(ctx: JSContextRef; `object`: JSObjectRef;
                                 propertyIndex: cuint; value: JSValueRef;
                                 exception: ptr JSValueRef) {.importc, cdecl.}
  ## ```
                                                                              ##   !
                                                                              ##   @function
                                                                              ##   @abstract Sets a property on an object by numeric index.
                                                                              ##   @param ctx The execution context to use.
                                                                              ##   @param object The JSObject whose property you want to set.
                                                                              ##   @param propertyIndex The property's name as a number.
                                                                              ##   @param value A JSValue to use as the property's value.
                                                                              ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                              ##   @discussion Calling JSObjectSetPropertyAtIndex is equivalent to calling JSObjectSetProperty with a string containing propertyIndex, but JSObjectSetPropertyAtIndex provides optimized access to numeric properties.
                                                                              ## ```
proc JSObjectGetPrivate*(`object`: JSObjectRef): pointer {.importc, cdecl.}
  ## ```
                                                                           ##   !
                                                                           ##   @function
                                                                           ##   @abstract Gets an object's private data.
                                                                           ##   @param object A JSObject whose private data you want to get.
                                                                           ##   @result A void* that is the object's private data, if the object has private data, otherwise NULL.
                                                                           ## ```
proc JSObjectSetPrivate*(`object`: JSObjectRef; data: pointer): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Sets a pointer to private data on an object.
           ##   @param object The JSObject whose private data you want to set.
           ##   @param data A void* to set as the object's private data.
           ##   @result true if object can store private data, otherwise false.
           ##   @discussion The default object class does not allocate storage for private data. Only objects created with a non-NULL JSClass can store private data.
           ## ```
proc JSObjectIsFunction*(ctx: JSContextRef; `object`: JSObjectRef): bool {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Tests whether an object can be called as a function.
                    ##   @param ctx  The execution context to use.
                    ##   @param object The JSObject to test.
                    ##   @result true if the object can be called as a function, otherwise false.
                    ## ```
proc JSObjectCallAsFunction*(ctx: JSContextRef; `object`: JSObjectRef;
                             thisObject: JSObjectRef; argumentCount: uint;
                             arguments: UncheckedArray[JSValueRef];
                             exception: ptr JSValueRef): JSValueRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Calls an object as a function.
           ##   @param ctx The execution context to use.
           ##   @param object The JSObject to call as a function.
           ##   @param thisObject The object to use as "this," or NULL to use the global object as "this."
           ##   @param argumentCount An integer count of the number of arguments in arguments.
           ##   @param arguments A JSValue array of arguments to pass to the function. Pass NULL if argumentCount is 0.
           ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##   @result The JSValue that results from calling object as a function, or NULL if an exception is thrown or object is not a function.
           ## ```
proc JSObjectIsConstructor*(ctx: JSContextRef; `object`: JSObjectRef): bool {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Tests whether an object can be called as a constructor.
                    ##   @param ctx  The execution context to use.
                    ##   @param object The JSObject to test.
                    ##   @result true if the object can be called as a constructor, otherwise false.
                    ## ```
proc JSObjectCallAsConstructor*(ctx: JSContextRef; `object`: JSObjectRef;
                                argumentCount: uint;
                                arguments: UncheckedArray[JSValueRef];
                                exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Calls an object as a constructor.
                    ##   @param ctx The execution context to use.
                    ##   @param object The JSObject to call as a constructor.
                    ##   @param argumentCount An integer count of the number of arguments in arguments.
                    ##   @param arguments A JSValue array of arguments to pass to the constructor. Pass NULL if argumentCount is 0.
                    ##   @param exception A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##   @result The JSObject that results from calling object as a constructor, or NULL if an exception is thrown or object is not a constructor.
                    ## ```
proc JSObjectCopyPropertyNames*(ctx: JSContextRef; `object`: JSObjectRef): JSPropertyNameArrayRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets the names of an object's enumerable properties.
                    ##   @param ctx The execution context to use.
                    ##   @param object The object whose property names you want to get.
                    ##   @result A JSPropertyNameArray containing the names object's enumerable properties. Ownership follows the Create Rule.
                    ## ```
proc JSPropertyNameArrayRetain*(array: JSPropertyNameArrayRef): JSPropertyNameArrayRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Retains a JavaScript property name array.
                    ##   @param array The JSPropertyNameArray to retain.
                    ##   @result A JSPropertyNameArray that is the same as array.
                    ## ```
proc JSPropertyNameArrayRelease*(array: JSPropertyNameArrayRef) {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##   @function
                                                                                  ##   @abstract Releases a JavaScript property name array.
                                                                                  ##   @param array The JSPropetyNameArray to release.
                                                                                  ## ```
proc JSPropertyNameArrayGetCount*(array: JSPropertyNameArrayRef): uint {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets a count of the number of items in a JavaScript property name array.
                    ##   @param array The array from which to retrieve the count.
                    ##   @result An integer count of the number of names in array.
                    ## ```
proc JSPropertyNameArrayGetNameAtIndex*(array: JSPropertyNameArrayRef;
                                        index: uint): JSStringRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Gets a property name at a given index in a JavaScript property name array.
           ##   @param array The array from which to retrieve the property name.
           ##   @param index The index of the property name to retrieve.
           ##   @result A JSStringRef containing the property name.
           ## ```
proc JSPropertyNameAccumulatorAddName*(accumulator: JSPropertyNameAccumulatorRef;
                                       propertyName: JSStringRef) {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Adds a property name to a JavaScript property name accumulator.
           ##   @param accumulator The accumulator object to which to add the property name.
           ##   @param propertyName The property name to add.
           ## ```
proc JSContextGroupCreate*(): JSContextGroupRef {.importc, cdecl.}
  ## ```
                                                                  ##   !
                                                                  ##   @function
                                                                  ##   @abstract Creates a JavaScript context group.
                                                                  ##   @discussion A JSContextGroup associates JavaScript contexts with one another.
                                                                  ##    Contexts in the same group may share and exchange JavaScript objects. Sharing and/or exchanging
                                                                  ##    JavaScript objects between contexts in different groups will produce undefined behavior.
                                                                  ##    When objects from the same context group are used in multiple threads, explicit
                                                                  ##    synchronization is required.
                                                                  ##   
                                                                  ##    A JSContextGroup may need to run deferred tasks on a run loop, such as garbage collection
                                                                  ##    or resolving WebAssembly compilations. By default, calling JSContextGroupCreate will use
                                                                  ##    the run loop of the thread it was called on. Currently, there is no API to change a
                                                                  ##    JSContextGroup's run loop once it has been created.
                                                                  ##   @result The created JSContextGroup.
                                                                  ## ```
proc JSContextGroupRetain*(group: JSContextGroupRef): JSContextGroupRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Retains a JavaScript context group.
                    ##   @param group The JSContextGroup to retain.
                    ##   @result A JSContextGroup that is the same as group.
                    ## ```
proc JSContextGroupRelease*(group: JSContextGroupRef) {.importc, cdecl.}
  ## ```
                                                                        ##   !
                                                                        ##   @function
                                                                        ##   @abstract Releases a JavaScript context group.
                                                                        ##   @param group The JSContextGroup to release.
                                                                        ## ```
proc JSGlobalContextCreate*(globalObjectClass: JSClassRef): JSGlobalContextRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Creates a global JavaScript execution context.
                    ##   @discussion JSGlobalContextCreate allocates a global object and populates it with all the
                    ##    built-in JavaScript objects, such as Object, Function, String, and Array.
                    ##   
                    ##    In WebKit version 4.0 and later, the context is created in a unique context group.
                    ##    Therefore, scripts may execute in it concurrently with scripts executing in other contexts.
                    ##    However, you may not use values created in the context in other contexts.
                    ##   @param globalObjectClass The class to use when creating the global object. Pass 
                    ##    NULL to use the default object class.
                    ##   @result A JSGlobalContext with a global object of class globalObjectClass.
                    ## ```
proc JSGlobalContextCreateInGroup*(group: JSContextGroupRef;
                                   globalObjectClass: JSClassRef): JSGlobalContextRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Creates a global JavaScript execution context in the context group provided.
                    ##   @discussion JSGlobalContextCreateInGroup allocates a global object and populates it with
                    ##    all the built-in JavaScript objects, such as Object, Function, String, and Array.
                    ##   @param globalObjectClass The class to use when creating the global object. Pass
                    ##    NULL to use the default object class.
                    ##   @param group The context group to use. The created global context retains the group.
                    ##    Pass NULL to create a unique group for the context.
                    ##   @result A JSGlobalContext with a global object of class globalObjectClass and a context
                    ##    group equal to group.
                    ## ```
proc JSGlobalContextRetain*(ctx: JSGlobalContextRef): JSGlobalContextRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Retains a global JavaScript execution context.
                    ##   @param ctx The JSGlobalContext to retain.
                    ##   @result A JSGlobalContext that is the same as ctx.
                    ## ```
proc JSGlobalContextRelease*(ctx: JSGlobalContextRef) {.importc, cdecl.}
  ## ```
                                                                        ##   !
                                                                        ##   @function
                                                                        ##   @abstract Releases a global JavaScript execution context.
                                                                        ##   @param ctx The JSGlobalContext to release.
                                                                        ## ```
proc JSContextGetGlobalObject*(ctx: JSContextRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                                 ##   !
                                                                                 ##   @function
                                                                                 ##   @abstract Gets the global object of a JavaScript execution context.
                                                                                 ##   @param ctx The JSContext whose global object you want to get.
                                                                                 ##   @result ctx's global object.
                                                                                 ## ```
proc JSContextGetGroup*(ctx: JSContextRef): JSContextGroupRef {.importc, cdecl.}
  ## ```
                                                                                ##   !
                                                                                ##   @function
                                                                                ##   @abstract Gets the context group to which a JavaScript execution context belongs.
                                                                                ##   @param ctx The JSContext whose group you want to get.
                                                                                ##   @result ctx's group.
                                                                                ## ```
proc JSContextGetGlobalContext*(ctx: JSContextRef): JSGlobalContextRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Gets the global context of a JavaScript execution context.
                    ##   @param ctx The JSContext whose global context you want to get.
                    ##   @result ctx's global context.
                    ## ```
proc JSGlobalContextCopyName*(ctx: JSGlobalContextRef): JSStringRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Gets a copy of the name of a context.
           ##   @param ctx The JSGlobalContext whose name you want to get.
           ##   @result The name for ctx.
           ##   @discussion A JSGlobalContext's name is exposed for remote debugging to make it
           ##   easier to identify the context you would like to attach to.
           ## ```
proc JSGlobalContextSetName*(ctx: JSGlobalContextRef; name: JSStringRef) {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract Sets the remote debugging name for a context.
                    ##   @param ctx The JSGlobalContext that you want to name.
                    ##   @param name The remote debugging name to set on ctx.
                    ## ```
proc JSStringCreateWithCharacters*(chars: ptr JSChar; numChars: uint): JSStringRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##   @function
                    ##   @abstract         Creates a JavaScript string from a buffer of Unicode characters.
                    ##   @param chars      The buffer of Unicode characters to copy into the new JSString.
                    ##   @param numChars   The number of characters to copy from the buffer pointed to by chars.
                    ##   @result           A JSString containing chars. Ownership follows the Create Rule.
                    ## ```
proc JSStringCreateWithUTF8CString*(string: cstring): JSStringRef {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract         Creates a JavaScript string from a null-terminated UTF8 string.
           ##   @param string     The null-terminated UTF8 string to copy into the new JSString.
           ##   @result           A JSString containing string. Ownership follows the Create Rule.
           ## ```
proc JSStringRetain*(string: JSStringRef): JSStringRef {.importc, cdecl.}
  ## ```
                                                                         ##   !
                                                                         ##   @function
                                                                         ##   @abstract         Retains a JavaScript string.
                                                                         ##   @param string     The JSString to retain.
                                                                         ##   @result           A JSString that is the same as string.
                                                                         ## ```
proc JSStringRelease*(string: JSStringRef) {.importc, cdecl.}
  ## ```
                                                             ##   !
                                                             ##   @function
                                                             ##   @abstract         Releases a JavaScript string.
                                                             ##   @param string     The JSString to release.
                                                             ## ```
proc JSStringGetLength*(string: JSStringRef): uint {.importc, cdecl.}
  ## ```
                                                                     ##   !
                                                                     ##   @function
                                                                     ##   @abstract         Returns the number of Unicode characters in a JavaScript string.
                                                                     ##   @param string     The JSString whose length (in Unicode characters) you want to know.
                                                                     ##   @result           The number of Unicode characters stored in string.
                                                                     ## ```
proc JSStringGetCharactersPtr*(string: JSStringRef): ptr JSChar {.importc, cdecl.}
  ## ```
                                                                                  ##   !
                                                                                  ##   @function
                                                                                  ##   @abstract         Returns a pointer to the Unicode character buffer that 
                                                                                  ##    serves as the backing store for a JavaScript string.
                                                                                  ##   @param string     The JSString whose backing store you want to access.
                                                                                  ##   @result           A pointer to the Unicode character buffer that serves as string's 
                                                                                  ##    backing store, which will be deallocated when string is deallocated.
                                                                                  ## ```
proc JSStringGetMaximumUTF8CStringSize*(string: JSStringRef): uint {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract Returns the maximum number of bytes a JavaScript string will 
           ##    take up if converted into a null-terminated UTF8 string.
           ##   @param string The JSString whose maximum converted size (in bytes) you 
           ##    want to know.
           ##   @result The maximum number of bytes that could be required to convert string into a 
           ##    null-terminated UTF8 string. The number of bytes that the conversion actually ends 
           ##    up requiring could be less than this, but never more.
           ## ```
proc JSStringGetUTF8CString*(string: JSStringRef; buffer: cstring;
                             bufferSize: uint): uint {.importc, cdecl.}
  ## ```
                                                                       ##   !
                                                                       ##   @function
                                                                       ##   @abstract Converts a JavaScript string into a null-terminated UTF8 string, 
                                                                       ##    and copies the result into an external byte buffer.
                                                                       ##   @param string The source JSString.
                                                                       ##   @param buffer The destination byte buffer into which to copy a null-terminated 
                                                                       ##    UTF8 representation of string. On return, buffer contains a UTF8 string 
                                                                       ##    representation of string. If bufferSize is too small, buffer will contain only 
                                                                       ##    partial results. If buffer is not at least bufferSize bytes in size, 
                                                                       ##    behavior is undefined. 
                                                                       ##   @param bufferSize The size of the external buffer in bytes.
                                                                       ##   @result The number of bytes written into buffer (including the null-terminator byte).
                                                                       ## ```
proc JSStringIsEqual*(a: JSStringRef; b: JSStringRef): bool {.importc, cdecl.}
  ## ```
                                                                              ##   !
                                                                              ##   @function
                                                                              ##   @abstract     Tests whether two JavaScript strings match.
                                                                              ##   @param a      The first JSString to test.
                                                                              ##   @param b      The second JSString to test.
                                                                              ##   @result       true if the two strings match, otherwise false.
                                                                              ## ```
proc JSStringIsEqualToUTF8CString*(a: JSStringRef; b: cstring): bool {.importc,
    cdecl.}
  ## ```
           ##   !
           ##   @function
           ##   @abstract     Tests whether a JavaScript string matches a null-terminated UTF8 string.
           ##   @param a      The JSString to test.
           ##   @param b      The null-terminated UTF8 string to test.
           ##   @result       true if the two strings match, otherwise false.
           ## ```
proc JSObjectMakeTypedArray*(ctx: JSContextRef; arrayType: JSTypedArrayType;
                             length: uint; exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   ------------- Typed Array functions --------------
                    ##     !
                    ##    @function
                    ##    @abstract           Creates a JavaScript Typed Array object with the given number of elements.
                    ##    @param ctx          The execution context to use.
                    ##    @param arrayType    A value identifying the type of array to create. If arrayType is kJSTypedArrayTypeNone or kJSTypedArrayTypeArrayBuffer then NULL will be returned.
                    ##    @param length       The number of elements to be in the new Typed Array.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             A JSObjectRef that is a Typed Array with all elements set to zero or NULL if there was an error.
                    ## ```
proc JSObjectMakeTypedArrayWithBytesNoCopy*(ctx: JSContextRef;
    arrayType: JSTypedArrayType; bytes: pointer; byteLength: uint;
    bytesDeallocator: JSTypedArrayBytesDeallocator; deallocatorContext: pointer;
    exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                              ##   !
                                                              ##    @function
                                                              ##    @abstract                 Creates a JavaScript Typed Array object from an existing pointer.
                                                              ##    @param ctx                The execution context to use.
                                                              ##    @param arrayType          A value identifying the type of array to create. If arrayType is kJSTypedArrayTypeNone or kJSTypedArrayTypeArrayBuffer then NULL will be returned.
                                                              ##    @param bytes              A pointer to the byte buffer to be used as the backing store of the Typed Array object.
                                                              ##    @param byteLength         The number of bytes pointed to by the parameter bytes.
                                                              ##    @param bytesDeallocator   The allocator to use to deallocate the external buffer when the JSTypedArrayData object is deallocated.
                                                              ##    @param deallocatorContext A pointer to pass back to the deallocator.
                                                              ##    @param exception          A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                              ##    @result                   A JSObjectRef Typed Array whose backing store is the same as the one pointed to by bytes or NULL if there was an error.
                                                              ##    @discussion               If an exception is thrown during this function the bytesDeallocator will always be called.
                                                              ## ```
proc JSObjectMakeTypedArrayWithArrayBuffer*(ctx: JSContextRef;
    arrayType: JSTypedArrayType; buffer: JSObjectRef; exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract           Creates a JavaScript Typed Array object from an existing JavaScript Array Buffer object.
                    ##    @param ctx          The execution context to use.
                    ##    @param arrayType    A value identifying the type of array to create. If arrayType is kJSTypedArrayTypeNone or kJSTypedArrayTypeArrayBuffer then NULL will be returned.
                    ##    @param buffer       An Array Buffer object that should be used as the backing store for the created JavaScript Typed Array object.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             A JSObjectRef that is a Typed Array or NULL if there was an error. The backing store of the Typed Array will be buffer.
                    ## ```
proc JSObjectMakeTypedArrayWithArrayBufferAndOffset*(ctx: JSContextRef;
    arrayType: JSTypedArrayType; buffer: JSObjectRef; byteOffset: uint;
    length: uint; exception: ptr JSValueRef): JSObjectRef {.importc, cdecl.}
  ## ```
                                                                            ##   !
                                                                            ##    @function
                                                                            ##    @abstract           Creates a JavaScript Typed Array object from an existing JavaScript Array Buffer object with the given offset and length.
                                                                            ##    @param ctx          The execution context to use.
                                                                            ##    @param arrayType    A value identifying the type of array to create. If arrayType is kJSTypedArrayTypeNone or kJSTypedArrayTypeArrayBuffer then NULL will be returned.
                                                                            ##    @param buffer       An Array Buffer object that should be used as the backing store for the created JavaScript Typed Array object.
                                                                            ##    @param byteOffset   The byte offset for the created Typed Array. byteOffset should aligned with the element size of arrayType.
                                                                            ##    @param length       The number of elements to include in the Typed Array.
                                                                            ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                                                                            ##    @result             A JSObjectRef that is a Typed Array or NULL if there was an error. The backing store of the Typed Array will be buffer.
                                                                            ## ```
proc JSObjectGetTypedArrayBytesPtr*(ctx: JSContextRef; `object`: JSObjectRef;
                                    exception: ptr JSValueRef): pointer {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract           Returns a temporary pointer to the backing store of a JavaScript Typed Array object.
                    ##    @param ctx          The execution context to use.
                    ##    @param object       The Typed Array object whose backing store pointer to return.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             A pointer to the raw data buffer that serves as object's backing store or NULL if object is not a Typed Array object.
                    ##    @discussion         The pointer returned by this function is temporary and is not guaranteed to remain valid across JavaScriptCore API calls.
                    ## ```
proc JSObjectGetTypedArrayLength*(ctx: JSContextRef; `object`: JSObjectRef;
                                  exception: ptr JSValueRef): uint {.importc,
    cdecl.}
  ## ```
           ##   !
           ##    @function
           ##    @abstract           Returns the length of a JavaScript Typed Array object.
           ##    @param ctx          The execution context to use.
           ##    @param object       The Typed Array object whose length to return.
           ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
           ##    @result             The length of the Typed Array object or 0 if the object is not a Typed Array object.
           ## ```
proc JSObjectGetTypedArrayByteLength*(ctx: JSContextRef; `object`: JSObjectRef;
                                      exception: ptr JSValueRef): uint {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract           Returns the byte length of a JavaScript Typed Array object.
                    ##    @param ctx          The execution context to use.
                    ##    @param object       The Typed Array object whose byte length to return.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             The byte length of the Typed Array object or 0 if the object is not a Typed Array object.
                    ## ```
proc JSObjectGetTypedArrayByteOffset*(ctx: JSContextRef; `object`: JSObjectRef;
                                      exception: ptr JSValueRef): uint {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract           Returns the byte offset of a JavaScript Typed Array object.
                    ##    @param ctx          The execution context to use.
                    ##    @param object       The Typed Array object whose byte offset to return.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             The byte offset of the Typed Array object or 0 if the object is not a Typed Array object.
                    ## ```
proc JSObjectGetTypedArrayBuffer*(ctx: JSContextRef; `object`: JSObjectRef;
                                  exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract           Returns the JavaScript Array Buffer object that is used as the backing of a JavaScript Typed Array object.
                    ##    @param ctx          The execution context to use.
                    ##    @param object       The JSObjectRef whose Typed Array type data pointer to obtain.
                    ##    @param exception    A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result             A JSObjectRef with a JSTypedArrayType of kJSTypedArrayTypeArrayBuffer or NULL if object is not a Typed Array.
                    ## ```
proc JSObjectMakeArrayBufferWithBytesNoCopy*(ctx: JSContextRef; bytes: pointer;
    byteLength: uint; bytesDeallocator: JSTypedArrayBytesDeallocator;
    deallocatorContext: pointer; exception: ptr JSValueRef): JSObjectRef {.
    importc, cdecl.}
  ## ```
                    ##   ------------- Array Buffer functions -------------
                    ##     !
                    ##    @function
                    ##    @abstract                 Creates a JavaScript Array Buffer object from an existing pointer.
                    ##    @param ctx                The execution context to use.
                    ##    @param bytes              A pointer to the byte buffer to be used as the backing store of the Typed Array object.
                    ##    @param byteLength         The number of bytes pointed to by the parameter bytes.
                    ##    @param bytesDeallocator   The allocator to use to deallocate the external buffer when the Typed Array data object is deallocated.
                    ##    @param deallocatorContext A pointer to pass back to the deallocator.
                    ##    @param exception          A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result                   A JSObjectRef Array Buffer whose backing store is the same as the one pointed to by bytes or NULL if there was an error.
                    ##    @discussion               If an exception is thrown during this function the bytesDeallocator will always be called.
                    ## ```
proc JSObjectGetArrayBufferBytesPtr*(ctx: JSContextRef; `object`: JSObjectRef;
                                     exception: ptr JSValueRef): pointer {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract         Returns a pointer to the data buffer that serves as the backing store for a JavaScript Typed Array object.
                    ##    @param object     The Array Buffer object whose internal backing store pointer to return.
                    ##    @param exception  A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result           A pointer to the raw data buffer that serves as object's backing store or NULL if object is not an Array Buffer object.
                    ##    @discussion       The pointer returned by this function is temporary and is not guaranteed to remain valid across JavaScriptCore API calls.
                    ## ```
proc JSObjectGetArrayBufferByteLength*(ctx: JSContextRef; `object`: JSObjectRef;
                                       exception: ptr JSValueRef): uint {.
    importc, cdecl.}
  ## ```
                    ##   !
                    ##    @function
                    ##    @abstract         Returns the number of bytes in a JavaScript data object.
                    ##    @param ctx        The execution context to use.
                    ##    @param object     The JS Arary Buffer object whose length in bytes to return.
                    ##    @param exception  A pointer to a JSValueRef in which to store an exception, if any. Pass NULL if you do not care to store an exception.
                    ##    @result           The number of bytes stored in the data object.
                    ## ```
proc versionString*(): cstring {.importc: "ulVersionString", cdecl.}
  ## ```
                                                                    ##   ***************************************************************************
                                                                    ##    API Note:
                                                                    ##   
                                                                    ##    You should only destroy objects that you explicitly create. Do not destroy
                                                                    ##    any objects returned from the API or callbacks unless otherwise noted.
                                                                    ##   **************************************************************************
                                                                    ##    ***************************************************************************
                                                                    ##    Version
                                                                    ##   **************************************************************************
                                                                    ##     /
                                                                    ##     / Get the version string of the library in MAJOR.MINOR.PATCH format.
                                                                    ##     /
                                                                    ## ```
proc versionMajor*(): cuint {.importc: "ulVersionMajor", cdecl.}
  ## ```
                                                                ##   /
                                                                ##     / Get the numeric major version of the library.
                                                                ##     /
                                                                ## ```
proc versionMinor*(): cuint {.importc: "ulVersionMinor", cdecl.}
  ## ```
                                                                ##   /
                                                                ##     / Get the numeric minor version of the library.
                                                                ##     /
                                                                ## ```
proc versionPatch*(): cuint {.importc: "ulVersionPatch", cdecl.}
  ## ```
                                                                ##   /
                                                                ##     / Get the numeric patch version of the library.
                                                                ##     /
                                                                ## ```
proc createConfig*(): ULConfig {.importc: "ulCreateConfig", cdecl.}
  ## ```
                                                                   ##   ***************************************************************************
                                                                   ##    Config
                                                                   ##   **************************************************************************
                                                                   ##     /
                                                                   ##     / Create config with default values (see <Ultralight/platform/Config.h>).
                                                                   ##     /
                                                                   ## ```
proc destroyConfig*(config: ULConfig) {.importc: "ulDestroyConfig", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Destroy config.
                                                                           ##     /
                                                                           ## ```
proc setResourcePath*(config: ULConfig; resource_path: ULStringRef) {.
    importc: "ulConfigSetResourcePath", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Set the file path to the directory that contains Ultralight's bundled
                                               ##     / resources (eg, cacert.pem and other localized resources).
                                               ##     /
                                               ## ```
proc setCachePath*(config: ULConfig; cache_path: ULStringRef) {.
    importc: "ulConfigSetCachePath", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Set the file path to a writable directory that will be used to store
                                            ##     / cookies, cached resources, and other persistent data.
                                            ##     /
                                            ## ```
proc setUseGPURenderer*(config: ULConfig; use_gpu: bool) {.
    importc: "ulConfigSetUseGPURenderer", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / When enabled, each View will be rendered to an offscreen GPU texture
                                                 ##     / using the GPU driver set in ulPlatformSetGPUDriver. You can fetch
                                                 ##     / details for the texture via ulViewGetRenderTarget.
                                                 ##     /
                                                 ##     / When disabled (the default), each View will be rendered to an offscreen
                                                 ##     / pixel buffer. This pixel buffer can optionally be provided by the user--
                                                 ##     / for more info see ulViewGetSurface.
                                                 ##     /
                                                 ## ```
proc setDeviceScale*(config: ULConfig; value: cdouble) {.
    importc: "ulConfigSetDeviceScale", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Set the amount that the application DPI has been scaled, used for
                                              ##     / scaling device coordinates to pixels and oversampling raster shapes
                                              ##     / (Default = 1.0).
                                              ##     /
                                              ## ```
proc setFaceWinding*(config: ULConfig; winding: ULFaceWinding) {.
    importc: "ulConfigSetFaceWinding", cdecl.}
  ## ```
                                              ##   /
                                              ##     / The winding order for front-facing triangles. @see FaceWinding
                                              ##     /
                                              ##     / Note: This is only used with custom GPUDrivers
                                              ##     /
                                              ## ```
proc setEnableImages*(config: ULConfig; enabled: bool) {.
    importc: "ulConfigSetEnableImages", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Set whether images should be enabled (Default = True).
                                               ##     /
                                               ## ```
proc setEnableJavaScript*(config: ULConfig; enabled: bool) {.
    importc: "ulConfigSetEnableJavaScript", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / Set whether JavaScript should be eanbled (Default = True).
                                                   ##     /
                                                   ## ```
proc setFontHinting*(config: ULConfig; font_hinting: ULFontHinting) {.
    importc: "ulConfigSetFontHinting", cdecl.}
  ## ```
                                              ##   /
                                              ##     / The hinting algorithm to use when rendering fonts. (Default = kFontHinting_Normal)
                                              ##     / @see ULFontHinting
                                              ##     /
                                              ## ```
proc setFontGamma*(config: ULConfig; font_gamma: cdouble) {.
    importc: "ulConfigSetFontGamma", cdecl.}
  ## ```
                                            ##   /
                                            ##     / The gamma to use when compositing font glyphs, change this value to
                                            ##     / adjust contrast (Adobe and Apple prefer 1.8, others may prefer 2.2).
                                            ##     / (Default = 1.8)
                                            ##     /
                                            ## ```
proc setFontFamilyStandard*(config: ULConfig; font_name: ULStringRef) {.
    importc: "ulConfigSetFontFamilyStandard", cdecl.}
  ## ```
                                                     ##   /
                                                     ##     / Set default font-family to use (Default = Times New Roman).
                                                     ##     /
                                                     ## ```
proc setFontFamilyFixed*(config: ULConfig; font_name: ULStringRef) {.
    importc: "ulConfigSetFontFamilyFixed", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / Set default font-family to use for fixed fonts, eg <pre> and <code>
                                                  ##     / (Default = Courier New).
                                                  ##     /
                                                  ## ```
proc setFontFamilySerif*(config: ULConfig; font_name: ULStringRef) {.
    importc: "ulConfigSetFontFamilySerif", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / Set default font-family to use for serif fonts (Default = Times New Roman).
                                                  ##     /
                                                  ## ```
proc setFontFamilySansSerif*(config: ULConfig; font_name: ULStringRef) {.
    importc: "ulConfigSetFontFamilySansSerif", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set default font-family to use for sans-serif fonts (Default = Arial).
                                                      ##     /
                                                      ## ```
proc setUserAgent*(config: ULConfig; agent_string: ULStringRef) {.
    importc: "ulConfigSetUserAgent", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Set user agent string (See <Ultralight/platform/Config.h> for the default).
                                            ##     /
                                            ## ```
proc setUserStylesheet*(config: ULConfig; css_string: ULStringRef) {.
    importc: "ulConfigSetUserStylesheet", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / Set user stylesheet (CSS) (Default = Empty).
                                                 ##     /
                                                 ## ```
proc setForceRepaint*(config: ULConfig; enabled: bool) {.
    importc: "ulConfigSetForceRepaint", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Set whether or not we should continuously repaint any Views or compositor
                                               ##     / layers, regardless if they are dirty or not. This is mainly used to
                                               ##     / diagnose painting/shader issues. (Default = False)
                                               ##     /
                                               ## ```
proc setAnimationTimerDelay*(config: ULConfig; delay: cdouble) {.
    importc: "ulConfigSetAnimationTimerDelay", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set the amount of time to wait before triggering another repaint when a
                                                      ##     / CSS animation is active. (Default = 1.0 / 60.0)
                                                      ##     /
                                                      ## ```
proc setScrollTimerDelay*(config: ULConfig; delay: cdouble) {.
    importc: "ulConfigSetScrollTimerDelay", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / When a smooth scroll animation is active, the amount of time (in seconds)
                                                   ##     / to wait before triggering another repaint. Default is 60 Hz.
                                                   ##     /
                                                   ## ```
proc setRecycleDelay*(config: ULConfig; delay: cdouble) {.
    importc: "ulConfigSetRecycleDelay", cdecl.}
  ## ```
                                               ##   /
                                               ##     / The amount of time (in seconds) to wait before running the recycler (will
                                               ##     / attempt to return excess memory back to the system). (Default = 4.0)
                                               ##     /
                                               ## ```
proc setMemoryCacheSize*(config: ULConfig; size: cuint) {.
    importc: "ulConfigSetMemoryCacheSize", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / Set the size of WebCore's memory cache for decoded images, scripts, and
                                                  ##     / other assets in bytes. (Default = 64 1024 1024)
                                                  ##     /
                                                  ## ```
proc setPageCacheSize*(config: ULConfig; size: cuint) {.
    importc: "ulConfigSetPageCacheSize", cdecl.}
  ## ```
                                                ##   /
                                                ##     / Set the number of pages to keep in the cache. (Default = 0)
                                                ##     /
                                                ## ```
proc setOverrideRAMSize*(config: ULConfig; size: cuint) {.
    importc: "ulConfigSetOverrideRAMSize", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / JavaScriptCore tries to detect the system's physical RAM size to set
                                                  ##     / reasonable allocation limits. Set this to anything other than 0 to
                                                  ##     / override the detected value. Size is in bytes.
                                                  ##     /
                                                  ##     / This can be used to force JavaScriptCore to be more conservative with
                                                  ##     / its allocation strategy (at the cost of some performance).
                                                  ##     /
                                                  ## ```
proc setMinLargeHeapSize*(config: ULConfig; size: cuint) {.
    importc: "ulConfigSetMinLargeHeapSize", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / The minimum size of large VM heaps in JavaScriptCore. Set this to a
                                                   ##     / lower value to make these heaps start with a smaller initial value.
                                                   ##     /
                                                   ## ```
proc setMinSmallHeapSize*(config: ULConfig; size: cuint) {.
    importc: "ulConfigSetMinSmallHeapSize", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / The minimum size of small VM heaps in JavaScriptCore. Set this to a
                                                   ##     / lower value to make these heaps start with a smaller initial value.
                                                   ##     /
                                                   ## ```
proc createRenderer*(config: ULConfig): ULRenderer {.
    importc: "ulCreateRenderer", cdecl.}
  ## ```
                                        ##   ***************************************************************************
                                        ##    Renderer
                                        ##   **************************************************************************
                                        ##     /
                                        ##     / Create the Ultralight Renderer directly.
                                        ##     /
                                        ##     / Unlike ulCreateApp(), this does not use any native windows for drawing
                                        ##     / and allows you to manage your own runloop and painting. This method is
                                        ##     / recommended for those wishing to integrate the library into a game.
                                        ##     /
                                        ##     / This singleton manages the lifetime of all Views and coordinates all
                                        ##     / painting, rendering, network requests, and event dispatch.
                                        ##     /
                                        ##     / You should only call this once per process lifetime.
                                        ##     /
                                        ##     / You shoud set up your platform handlers (eg, ulPlatformSetLogger,
                                        ##     / ulPlatformSetFileSystem, etc.) before calling this.
                                        ##     /
                                        ##     / You will also need to define a font loader before calling this--
                                        ##     / as of this writing (v1.2) the only way to do this in C API is by calling
                                        ##     / ulEnablePlatformFontLoader() (available in <AppCore/CAPI.h>).
                                        ##     /
                                        ##     / @NOTE:  You should not call this if you are using ulCreateApp(), it
                                        ##     /         creates its own renderer and provides default implementations for
                                        ##     /         various platform handlers automatically.
                                        ##     /
                                        ## ```
proc destroyRenderer*(renderer: ULRenderer) {.importc: "ulDestroyRenderer",
    cdecl.}
  ## ```
           ##   /
           ##     / Destroy the renderer.
           ##     /
           ## ```
proc update*(renderer: ULRenderer) {.importc: "ulUpdate", cdecl.}
  ## ```
                                                                 ##   /
                                                                 ##     / Update timers and dispatch internal callbacks (JavaScript and network).
                                                                 ##     /
                                                                 ## ```
proc render*(renderer: ULRenderer) {.importc: "ulRender", cdecl.}
  ## ```
                                                                 ##   /
                                                                 ##     / Render all active Views.
                                                                 ##     /
                                                                 ## ```
proc purgeMemory*(renderer: ULRenderer) {.importc: "ulPurgeMemory", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Attempt to release as much memory as possible. Don't call this from any
                                                                           ##     / callbacks or driver code.
                                                                           ##     /
                                                                           ## ```
proc logMemoryUsage*(renderer: ULRenderer) {.importc: "ulLogMemoryUsage", cdecl.}
  ## ```
                                                                                 ##   /
                                                                                 ##     / Print detailed memory usage statistics to the log.
                                                                                 ##     / (@see ulPlatformSetLogger)
                                                                                 ##     /
                                                                                 ## ```
proc createSession*(renderer: ULRenderer; is_persistent: bool; name: ULStringRef): ULSession {.
    importc: "ulCreateSession", cdecl.}
  ## ```
                                       ##   ***************************************************************************
                                       ##    Session
                                       ##   **************************************************************************
                                       ##     /
                                       ##     / Create a Session to store local data in (such as cookies, local storage,
                                       ##     / application cache, indexed db, etc).
                                       ##     /
                                       ## ```
proc destroySession*(session: ULSession) {.importc: "ulDestroySession", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Destroy a Session.
                                                                               ##     /
                                                                               ## ```
proc defaultSession*(renderer: ULRenderer): ULSession {.
    importc: "ulDefaultSession", cdecl.}
  ## ```
                                        ##   /
                                        ##     / Get the default session (persistent session named "default").
                                        ##     /
                                        ##     / @note  This session is owned by the Renderer, you shouldn't destroy it.
                                        ##     /
                                        ## ```
proc isPersistent*(session: ULSession): bool {.importc: "ulSessionIsPersistent",
    cdecl.}
  ## ```
           ##   /
           ##     / Whether or not is persistent (backed to disk).
           ##     /
           ## ```
proc getName*(session: ULSession): ULStringRef {.importc: "ulSessionGetName",
    cdecl.}
  ## ```
           ##   /
           ##     / Unique name identifying the session (used for unique disk path).
           ##     /
           ## ```
proc getId*(session: ULSession): culonglong {.importc: "ulSessionGetId", cdecl.}
  ## ```
                                                                                ##   /
                                                                                ##     / Unique numeric Id for the session.
                                                                                ##     /
                                                                                ## ```
proc getDiskPath*(session: ULSession): ULStringRef {.
    importc: "ulSessionGetDiskPath", cdecl.}
  ## ```
                                            ##   /
                                            ##     / The disk path to write to (used by persistent sessions only).
                                            ##     /
                                            ## ```
proc createView*(renderer: ULRenderer; width: cuint; height: cuint;
                 transparent: bool; session: ULSession; force_cpu_renderer: bool): ULView {.
    importc: "ulCreateView", cdecl.}
  ## ```
                                    ##   ***************************************************************************
                                    ##    View
                                    ##   **************************************************************************
                                    ##     /
                                    ##     / Create a View with certain size (in pixels).
                                    ##     /
                                    ##     / @note  You can pass null to 'session' to use the default session.
                                    ##     /
                                    ## ```
proc destroyView*(view: ULView) {.importc: "ulDestroyView", cdecl.}
  ## ```
                                                                   ##   /
                                                                   ##     / Destroy a View.
                                                                   ##     /
                                                                   ## ```
proc getURL*(view: ULView): ULStringRef {.importc: "ulViewGetURL", cdecl.}
  ## ```
                                                                          ##   /
                                                                          ##     / Get current URL.
                                                                          ##     /
                                                                          ##     / @note Don't destroy the returned string, it is owned by the View.
                                                                          ##     /
                                                                          ## ```
proc getTitle*(view: ULView): ULStringRef {.importc: "ulViewGetTitle", cdecl.}
  ## ```
                                                                              ##   /
                                                                              ##     / Get current title.
                                                                              ##     /
                                                                              ##     / @note Don't destroy the returned string, it is owned by the View.
                                                                              ##     /
                                                                              ## ```
proc get*(view: ULView): cuint {.importc: "ulViewGetWidth", cdecl.}
  ## ```
                                                                   ##   /
                                                                   ##     / Get the width, in pixels.
                                                                   ##     /
                                                                   ## ```
proc isLoading*(view: ULView): bool {.importc: "ulViewIsLoading", cdecl.}
  ## ```
                                                                         ##   /
                                                                         ##     / Check if main frame is loading.
                                                                         ##     /
                                                                         ## ```
proc getRenderTarget*(view: ULView): ULRenderTarget {.
    importc: "ulViewGetRenderTarget", cdecl.}
  ## ```
                                             ##   /
                                             ##     / Get the RenderTarget for the View.
                                             ##     /
                                             ##     / @note  Only valid when the GPU renderer is enabled in Config.
                                             ##     /
                                             ## ```
proc getSurface*(view: ULView): ULSurface {.importc: "ulViewGetSurface", cdecl.}
  ## ```
                                                                                ##   /
                                                                                ##     / Get the Surface for the View (native pixel buffer container).
                                                                                ##     /
                                                                                ##     / @note  Only valid when the GPU renderer is disabled in Config.
                                                                                ##     /
                                                                                ##     /        (Will return a nullptr when the GPU renderer is enabled.)
                                                                                ##     /
                                                                                ##     /        The default Surface is BitmapSurface but you can provide your
                                                                                ##     /        own Surface implementation via ulPlatformSetSurfaceDefinition.
                                                                                ##     /
                                                                                ##     /        When using the default Surface, you can retrieve the underlying
                                                                                ##     /        bitmap by casting ULSurface to ULBitmapSurface and calling
                                                                                ##     /        ulBitmapSurfaceGetBitmap().
                                                                                ##     /
                                                                                ## ```
proc loadHTML*(view: ULView; html_string: ULStringRef) {.
    importc: "ulViewLoadHTML", cdecl.}
  ## ```
                                      ##   /
                                      ##     / Load a raw string of HTML.
                                      ##     /
                                      ## ```
proc loadURL*(view: ULView; url_string: ULStringRef) {.importc: "ulViewLoadURL",
    cdecl.}
  ## ```
           ##   /
           ##     / Load a URL into main frame.
           ##     /
           ## ```
proc lockJSContext*(view: ULView): JSContextRef {.
    importc: "ulViewLockJSContext", cdecl.}
  ## ```
                                           ##   /
                                           ##     / Acquire the page's JSContext for use with JavaScriptCore API.
                                           ##     /
                                           ##     / @note  This call locks the context for the current thread. You should
                                           ##     /        call ulViewUnlockJSContext() after using the context so other
                                           ##     /        worker threads can modify JavaScript state.
                                           ##     /
                                           ##     / @note  The lock is recusive, it's okay to call this multiple times as long
                                           ##     /        as you call ulViewUnlockJSContext() the same number of times.
                                           ##     /
                                           ## ```
proc unlockJSContext*(view: ULView) {.importc: "ulViewUnlockJSContext", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Unlock the page's JSContext after a previous call to ulViewLockJSContext().
                                                                               ##     /
                                                                               ## ```
proc evaluateScript*(view: ULView; js_string: ULStringRef;
                     exception: ptr ULStringRef): ULStringRef {.
    importc: "ulViewEvaluateScript", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Evaluate a string of JavaScript and return result.
                                            ##     /
                                            ##     / @param  js_string  The string of JavaScript to evaluate.
                                            ##     /
                                            ##     / @param  exception  The address of a ULString to store a description of the
                                            ##     /                    last exception. Pass NULL to ignore this. Don't destroy
                                            ##     /                    the exception string returned, it's owned by the View.
                                            ##     /
                                            ##     / @note Don't destroy the returned string, it's owned by the View. This value
                                            ##     /       is reset with every call-- if you want to retain it you should copy
                                            ##     /       the result to a new string via ulCreateStringFromCopy().
                                            ##     /
                                            ##     / @note An example of using this API:
                                            ##     /       <pre>
                                            ##     /         ULString script = ulCreateString("1 + 1");
                                            ##     /         ULString exception;
                                            ##     /         ULString result = ulViewEvaluateScript(view, script, &exception);
                                            ##     /          Use the result ("2") and exception description (if any) here. 
                                            ##     /         ulDestroyString(script);
                                            ##     /       </pre>
                                            ##     /
                                            ## ```
proc canGoBack*(view: ULView): bool {.importc: "ulViewCanGoBack", cdecl.}
  ## ```
                                                                         ##   /
                                                                         ##     / Check if can navigate backwards in history.
                                                                         ##     /
                                                                         ## ```
proc canGoForward*(view: ULView): bool {.importc: "ulViewCanGoForward", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Check if can navigate forwards in history.
                                                                               ##     /
                                                                               ## ```
proc goBack*(view: ULView) {.importc: "ulViewGoBack", cdecl.}
  ## ```
                                                             ##   /
                                                             ##     / Navigate backwards in history.
                                                             ##     /
                                                             ## ```
proc goForward*(view: ULView) {.importc: "ulViewGoForward", cdecl.}
  ## ```
                                                                   ##   /
                                                                   ##     / Navigate forwards in history.
                                                                   ##     /
                                                                   ## ```
proc goToHistoryOffset*(view: ULView; offset: cint) {.
    importc: "ulViewGoToHistoryOffset", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Navigate to arbitrary offset in history.
                                               ##     /
                                               ## ```
proc reload*(view: ULView) {.importc: "ulViewReload", cdecl.}
  ## ```
                                                             ##   /
                                                             ##     / Reload current page.
                                                             ##     /
                                                             ## ```
proc stop*(view: ULView) {.importc: "ulViewStop", cdecl.}
  ## ```
                                                         ##   /
                                                         ##     / Stop all page loads.
                                                         ##     /
                                                         ## ```
proc focus*(view: ULView) {.importc: "ulViewFocus", cdecl.}
  ## ```
                                                           ##   /
                                                           ##     / Give focus to the View.
                                                           ##     /
                                                           ##     / You should call this to give visual indication that the View has input
                                                           ##     / focus (changes active text selection colors, for example).
                                                           ##     /
                                                           ## ```
proc unfocus*(view: ULView) {.importc: "ulViewUnfocus", cdecl.}
  ## ```
                                                               ##   /
                                                               ##     / Remove focus from the View and unfocus any focused input elements.
                                                               ##     /
                                                               ##     / You should call this to give visual indication that the View has lost
                                                               ##     / input focus.
                                                               ##     /
                                                               ## ```
proc hasFocus*(view: ULView): bool {.importc: "ulViewHasFocus", cdecl.}
  ## ```
                                                                       ##   /
                                                                       ##     / Whether or not the View has focus.
                                                                       ##     /
                                                                       ## ```
proc hasInputFocus*(view: ULView): bool {.importc: "ulViewHasInputFocus", cdecl.}
  ## ```
                                                                                 ##   /
                                                                                 ##     / Whether or not the View has an input element with visible keyboard focus
                                                                                 ##     / (indicated by a blinking caret).
                                                                                 ##     /
                                                                                 ##     / You can use this to decide whether or not the View should consume
                                                                                 ##     / keyboard input events (useful in games with mixed UI and key handling).
                                                                                 ##     /
                                                                                 ## ```
proc fireKeyEvent*(view: ULView; key_event: ULKeyEvent) {.
    importc: "ulViewFireKeyEvent", cdecl.}
  ## ```
                                          ##   /
                                          ##     / Fire a keyboard event.
                                          ##     /
                                          ## ```
proc fireMouseEvent*(view: ULView; mouse_event: ULMouseEvent) {.
    importc: "ulViewFireMouseEvent", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Fire a mouse event.
                                            ##     /
                                            ## ```
proc fireScrollEvent*(view: ULView; scroll_event: ULScrollEvent) {.
    importc: "ulViewFireScrollEvent", cdecl.}
  ## ```
                                             ##   /
                                             ##     / Fire a scroll event.
                                             ##     /
                                             ## ```
proc setChangeTitleCallback*(view: ULView; callback: ULChangeTitleCallback;
                             user_data: pointer) {.
    importc: "ulViewSetChangeTitleCallback", cdecl.}
  ## ```
                                                    ##   /
                                                    ##     / Set callback for when the page title changes.
                                                    ##     /
                                                    ## ```
proc setChangeURLCallback*(view: ULView; callback: ULChangeURLCallback;
                           user_data: pointer) {.
    importc: "ulViewSetChangeURLCallback", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / Set callback for when the page URL changes.
                                                  ##     /
                                                  ## ```
proc setChangeTooltipCallback*(view: ULView; callback: ULChangeTooltipCallback;
                               user_data: pointer) {.
    importc: "ulViewSetChangeTooltipCallback", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set callback for when the tooltip changes (usually result of a mouse hover).
                                                      ##     /
                                                      ## ```
proc setChangeCursorCallback*(view: ULView; callback: ULChangeCursorCallback;
                              user_data: pointer) {.
    importc: "ulViewSetChangeCursorCallback", cdecl.}
  ## ```
                                                     ##   /
                                                     ##     / Set callback for when the mouse cursor changes.
                                                     ##     /
                                                     ## ```
proc setAddConsoleMessageCallback*(view: ULView;
                                   callback: ULAddConsoleMessageCallback;
                                   user_data: pointer) {.
    importc: "ulViewSetAddConsoleMessageCallback", cdecl.}
  ## ```
                                                          ##   /
                                                          ##     / Set callback for when a message is added to the console (useful for
                                                          ##     / JavaScript / network errors and debugging).
                                                          ##     /
                                                          ## ```
proc setCreateChildViewCallback*(view: ULView;
                                 callback: ULCreateChildViewCallback;
                                 user_data: pointer) {.
    importc: "ulViewSetCreateChildViewCallback", cdecl.}
  ## ```
                                                        ##   /
                                                        ##     / Set callback for when the page wants to create a new View.
                                                        ##     /
                                                        ##     / This is usually the result of a user clicking a link with target="_blank"
                                                        ##     / or by JavaScript calling window.open(url).
                                                        ##     /
                                                        ##     / To allow creation of these new Views, you should create a new View in
                                                        ##     / this callback, resize it to your container,
                                                        ##     / and return it. You are responsible for displaying the returned View.
                                                        ##     /
                                                        ##     / You should return NULL if you want to block the action.
                                                        ##     /
                                                        ## ```
proc setBeginLoadingCallback*(view: ULView; callback: ULBeginLoadingCallback;
                              user_data: pointer) {.
    importc: "ulViewSetBeginLoadingCallback", cdecl.}
  ## ```
                                                     ##   /
                                                     ##     / Set callback for when the page begins loading a new URL into a frame.
                                                     ##     /
                                                     ## ```
proc setFinishLoadingCallback*(view: ULView; callback: ULFinishLoadingCallback;
                               user_data: pointer) {.
    importc: "ulViewSetFinishLoadingCallback", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set callback for when the page finishes loading a URL into a frame.
                                                      ##     /
                                                      ## ```
proc setFailLoadingCallback*(view: ULView; callback: ULFailLoadingCallback;
                             user_data: pointer) {.
    importc: "ulViewSetFailLoadingCallback", cdecl.}
  ## ```
                                                    ##   /
                                                    ##     / Set callback for when an error occurs while loading a URL into a frame.
                                                    ##     /
                                                    ## ```
proc setWindowObjectReadyCallback*(view: ULView;
                                   callback: ULWindowObjectReadyCallback;
                                   user_data: pointer) {.
    importc: "ulViewSetWindowObjectReadyCallback", cdecl.}
  ## ```
                                                          ##   /
                                                          ##     / Set callback for when the JavaScript window object is reset for a new
                                                          ##     / page load.
                                                          ##     /
                                                          ##     / This is called before any scripts are executed on the page and is the
                                                          ##     / earliest time to setup any initial JavaScript state or bindings.
                                                          ##     /
                                                          ##     / The document is not guaranteed to be loaded/parsed at this point. If
                                                          ##     / you need to make any JavaScript calls that are dependent on DOM elements
                                                          ##     / or scripts on the page, use DOMReady instead.
                                                          ##     /
                                                          ##     / The window object is lazily initialized (this will not be called on pages
                                                          ##     / with no scripts).
                                                          ##     /
                                                          ## ```
proc setDOMReadyCallback*(view: ULView; callback: ULDOMReadyCallback;
                          user_data: pointer) {.
    importc: "ulViewSetDOMReadyCallback", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / Set callback for when all JavaScript has been parsed and the document is
                                                 ##     / ready.
                                                 ##     /
                                                 ##     / This is the best time to make any JavaScript calls that are dependent on
                                                 ##     / DOM elements or scripts on the page.
                                                 ##     /
                                                 ## ```
proc setUpdateHistoryCallback*(view: ULView; callback: ULUpdateHistoryCallback;
                               user_data: pointer) {.
    importc: "ulViewSetUpdateHistoryCallback", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set callback for when the history (back/forward state) is modified.
                                                      ##     /
                                                      ## ```
proc setNeedsPaint*(view: ULView; needs_paint: bool) {.
    importc: "ulViewSetNeedsPaint", cdecl.}
  ## ```
                                           ##   /
                                           ##     / Set whether or not a view should be repainted during the next call to
                                           ##     / ulRender.
                                           ##     /
                                           ##     / @note  This flag is automatically set whenever the page content changes
                                           ##     /        but you can set it directly in case you need to force a repaint.
                                           ##     /
                                           ## ```
proc getNeedsPaint*(view: ULView): bool {.importc: "ulViewGetNeedsPaint", cdecl.}
  ## ```
                                                                                 ##   /
                                                                                 ##     / Whether or not a view should be painted during the next call to ulRender.
                                                                                 ##     /
                                                                                 ## ```
proc createInspectorView*(view: ULView): ULView {.
    importc: "ulViewCreateInspectorView", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / Create an inspector for this View, this is useful for debugging and
                                                 ##     / inspecting pages locally. This will only succeed if you have the
                                                 ##     / inspector assets in your filesystem-- the inspector will look for
                                                 ##     / file:/inspector/Main.html when it loads.
                                                 ##     /
                                                 ##     / @note  The initial dimensions of the returned View are 10x10, you should
                                                 ##     /        call ulViewResize on the returned View to resize it to your desired
                                                 ##     /        dimensions.
                                                 ##     /
                                                 ##     / @note  You will need to call ulDestroyView on the returned instance
                                                 ##     /        when you're done using it.
                                                 ##     /
                                                 ## ```
proc createString*(str: cstring): ULStringRef {.importc: "ulCreateString", cdecl.}
  ## ```
                                                                                  ##   ***************************************************************************
                                                                                  ##    String
                                                                                  ##   **************************************************************************
                                                                                  ##     /
                                                                                  ##     / Create string from null-terminated ASCII C-string.
                                                                                  ##     /
                                                                                  ## ```
proc createStringUTF8*(str: cstring; len: uint): ULStringRef {.
    importc: "ulCreateStringUTF8", cdecl.}
  ## ```
                                          ##   /
                                          ##     / Create string from UTF-8 buffer.
                                          ##     /
                                          ## ```
proc createStringUTF16*(str: ptr ULChar16; len: uint): ULStringRef {.
    importc: "ulCreateStringUTF16", cdecl.}
  ## ```
                                           ##   /
                                           ##     / Create string from UTF-16 buffer.
                                           ##     /
                                           ## ```
proc createStringFromCopy*(str: ULStringRef): ULStringRef {.
    importc: "ulCreateStringFromCopy", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Create string from copy of existing string.
                                              ##     /
                                              ## ```
proc destroyString*(str: ULStringRef) {.importc: "ulDestroyString", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Destroy string (you should destroy any strings you explicitly Create).
                                                                           ##     /
                                                                           ## ```
proc getData*(str: ULStringRef): ptr ULChar16 {.importc: "ulStringGetData",
    cdecl.}
  ## ```
           ##   /
           ##     / Get internal UTF-16 buffer data.
           ##     /
           ## ```
proc getLength*(str: ULStringRef): uint {.importc: "ulStringGetLength", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Get length in UTF-16 characters.
                                                                               ##     /
                                                                               ## ```
proc isEmpty*(str: ULStringRef): bool {.importc: "ulStringIsEmpty", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Whether this string is empty or not.
                                                                           ##     /
                                                                           ## ```
proc assignString*(str: ULStringRef; new_str: ULStringRef) {.
    importc: "ulStringAssignString", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Replaces the contents of 'str' with the contents of 'new_str'
                                            ##     /
                                            ## ```
proc assignCString*(str: ULStringRef; c_str: cstring) {.
    importc: "ulStringAssignCString", cdecl.}
  ## ```
                                             ##   /
                                             ##     / Replaces the contents of 'str' with the contents of a C-string.
                                             ##     /
                                             ## ```
proc createEmptyBitmap*(): ULBitmap {.importc: "ulCreateEmptyBitmap", cdecl.}
  ## ```
                                                                             ##   ***************************************************************************
                                                                             ##    Bitmap
                                                                             ##   **************************************************************************
                                                                             ##     /
                                                                             ##     / Create empty bitmap.
                                                                             ##     /
                                                                             ## ```
proc createBitmap*(width: cuint; height: cuint; format: ULBitmapFormat): ULBitmap {.
    importc: "ulCreateBitmap", cdecl.}
  ## ```
                                      ##   /
                                      ##     / Create bitmap with certain dimensions and pixel format.
                                      ##     /
                                      ## ```
proc createBitmapFromPixels*(width: cuint; height: cuint;
                             format: ULBitmapFormat; row_bytes: cuint;
                             pixels: pointer; size: uint; should_copy: bool): ULBitmap {.
    importc: "ulCreateBitmapFromPixels", cdecl.}
  ## ```
                                                ##   /
                                                ##     / Create bitmap from existing pixel buffer. @see Bitmap for help using
                                                ##     / this function.
                                                ##     /
                                                ## ```
proc createBitmapFromCopy*(existing_bitmap: ULBitmap): ULBitmap {.
    importc: "ulCreateBitmapFromCopy", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Create bitmap from copy.
                                              ##     /
                                              ## ```
proc destroyBitmap*(bitmap: ULBitmap) {.importc: "ulDestroyBitmap", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Destroy a bitmap (you should only destroy Bitmaps you have explicitly
                                                                           ##     / created via one of the creation functions above.
                                                                           ##     /
                                                                           ## ```
proc getFormat*(bitmap: ULBitmap): ULBitmapFormat {.
    importc: "ulBitmapGetFormat", cdecl.}
  ## ```
                                         ##   /
                                         ##     / Get the pixel format.
                                         ##     /
                                         ## ```
proc getBpp*(bitmap: ULBitmap): cuint {.importc: "ulBitmapGetBpp", cdecl.}
  ## ```
                                                                          ##   /
                                                                          ##     / Get the bytes per pixel.
                                                                          ##     /
                                                                          ## ```
proc getRowBytes*(bitmap: ULBitmap): cuint {.importc: "ulBitmapGetRowBytes",
    cdecl.}
  ## ```
           ##   /
           ##     / Get the number of bytes per row.
           ##     /
           ## ```
proc getSize*(bitmap: ULBitmap): uint {.importc: "ulBitmapGetSize", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Get the size in bytes of the underlying pixel buffer.
                                                                           ##     /
                                                                           ## ```
proc ownsPixels*(bitmap: ULBitmap): bool {.importc: "ulBitmapOwnsPixels", cdecl.}
  ## ```
                                                                                 ##   /
                                                                                 ##     / Whether or not this bitmap owns its own pixel buffer.
                                                                                 ##     /
                                                                                 ## ```
proc lockPixels*(bitmap: ULBitmap): pointer {.importc: "ulBitmapLockPixels",
    cdecl.}
  ## ```
           ##   /
           ##     / Lock pixels for reading/writing, returns pointer to pixel buffer.
           ##     /
           ## ```
proc unlockPixels*(bitmap: ULBitmap) {.importc: "ulBitmapUnlockPixels", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Unlock pixels after locking.
                                                                               ##     /
                                                                               ## ```
proc rawPixels*(bitmap: ULBitmap): pointer {.importc: "ulBitmapRawPixels", cdecl.}
  ## ```
                                                                                  ##   /
                                                                                  ##     / Get raw pixel buffer-- you should only call this if Bitmap is already
                                                                                  ##     / locked.
                                                                                  ##     /
                                                                                  ## ```
proc erase*(bitmap: ULBitmap) {.importc: "ulBitmapErase", cdecl.}
  ## ```
                                                                 ##   /
                                                                 ##     / Reset bitmap pixels to 0.
                                                                 ##     /
                                                                 ## ```
proc writePNG*(bitmap: ULBitmap; path: cstring): bool {.
    importc: "ulBitmapWritePNG", cdecl.}
  ## ```
                                        ##   /
                                        ##     / Write bitmap to a PNG on disk.
                                        ##     /
                                        ## ```
proc swapRedBlueChannels*(bitmap: ULBitmap) {.
    importc: "ulBitmapSwapRedBlueChannels", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / This converts a BGRA bitmap to RGBA bitmap and vice-versa by swapping
                                                   ##     / the red and blue channels.
                                                   ##     /
                                                   ## ```
proc createKeyEvent*(`type`: ULKeyEventType; modifiers: cuint;
                     virtual_key_code: cint; native_key_code: cint;
                     text: ULStringRef; unmodified_text: ULStringRef;
                     is_keypad: bool; is_auto_repeat: bool; is_system_key: bool): ULKeyEvent {.
    importc: "ulCreateKeyEvent", cdecl.}
  ## ```
                                        ##   ***************************************************************************
                                        ##   Key Event
                                        ##  ***************************************************************************
                                        ##     /
                                        ##     / Create a key event, @see KeyEvent for help with the following parameters.
                                        ##     /
                                        ## ```
proc destroyKeyEvent*(evt: ULKeyEvent) {.importc: "ulDestroyKeyEvent", cdecl.}
  ## ```
                                                                              ##   /
                                                                              ##     / Destroy a key event.
                                                                              ##     /
                                                                              ## ```
proc createMouseEvent*(`type`: ULMouseEventType; x: cint; y: cint;
                       button: ULMouseButton): ULMouseEvent {.
    importc: "ulCreateMouseEvent", cdecl.}
  ## ```
                                          ##   ***************************************************************************
                                          ##    Mouse Event
                                          ##   **************************************************************************
                                          ##     /
                                          ##     / Create a mouse event, @see MouseEvent for help using this function.
                                          ##     /
                                          ## ```
proc destroyMouseEvent*(evt: ULMouseEvent) {.importc: "ulDestroyMouseEvent",
    cdecl.}
  ## ```
           ##   /
           ##     / Destroy a mouse event.
           ##     /
           ## ```
proc createScrollEvent*(`type`: ULScrollEventType; delta_x: cint; delta_y: cint): ULScrollEvent {.
    importc: "ulCreateScrollEvent", cdecl.}
  ## ```
                                           ##   ***************************************************************************
                                           ##    Scroll Event
                                           ##   **************************************************************************
                                           ##     /
                                           ##     / Create a scroll event, @see ScrollEvent for help using this function.
                                           ##     /
                                           ## ```
proc destroyScrollEvent*(evt: ULScrollEvent) {.importc: "ulDestroyScrollEvent",
    cdecl.}
  ## ```
           ##   /
           ##     / Destroy a scroll event.
           ##     /
           ## ```
proc rectIsEmpty*(rect: ULRect): bool {.importc: "ulRectIsEmpty", cdecl.}
  ## ```
                                                                         ##   ***************************************************************************
                                                                         ##    Rect
                                                                         ##   **************************************************************************
                                                                         ##     /
                                                                         ##     / Whether or not a ULRect is empty (all members equal to 0)
                                                                         ##     /
                                                                         ## ```
proc rectMakeEmpty*(): ULRect {.importc: "ulRectMakeEmpty", cdecl.}
  ## ```
                                                                   ##   /
                                                                   ##     / Create an empty ULRect (all members equal to 0)
                                                                   ##     /
                                                                   ## ```
proc intRectIsEmpty*(rect: ULIntRect): bool {.importc: "ulIntRectIsEmpty", cdecl.}
  ## ```
                                                                                  ##   ***************************************************************************
                                                                                  ##    IntRect
                                                                                  ##   **************************************************************************
                                                                                  ##     /
                                                                                  ##     / Whether or not a ULIntRect is empty (all members equal to 0)
                                                                                  ##     /
                                                                                  ## ```
proc intRectMakeEmpty*(): ULIntRect {.importc: "ulIntRectMakeEmpty", cdecl.}
  ## ```
                                                                            ##   /
                                                                            ##     / Create an empty ULIntRect (all members equal to 0)
                                                                            ##     /
                                                                            ## ```
proc setDirtyBounds*(surface: ULSurface; bounds: ULIntRect) {.
    importc: "ulSurfaceSetDirtyBounds", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Set the dirty bounds to a certain value.
                                               ##     /
                                               ##     / This is called after the Renderer paints to an area of the pixel buffer.
                                               ##     / (The new value will be joined with the existing dirty_bounds())
                                               ##     /
                                               ## ```
proc getDirtyBounds*(surface: ULSurface): ULIntRect {.
    importc: "ulSurfaceGetDirtyBounds", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Get the dirty bounds.
                                               ##     /
                                               ##     / This value can be used to determine which portion of the pixel buffer has
                                               ##     / been updated since the last call to ulSurfaceClearDirtyBounds().
                                               ##     /
                                               ##     / The general algorithm to determine if a Surface needs display is:
                                               ##     / <pre>
                                               ##     /   if (!ulIntRectIsEmpty(ulSurfaceGetDirtyBounds(surface))) {
                                               ##     /        Surface pixels are dirty and needs display.
                                               ##     /        Cast Surface to native Surface and use it here (pseudo code)
                                               ##     /       DisplaySurface(surface);
                                               ##     /
                                               ##     /        Once you're done, clear the dirty bounds:
                                               ##     /       ulSurfaceClearDirtyBounds(surface);
                                               ##     /  }
                                               ##     /  </pre>
                                               ##     /
                                               ## ```
proc clearDirtyBounds*(surface: ULSurface) {.
    importc: "ulSurfaceClearDirtyBounds", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / Clear the dirty bounds.
                                                 ##     /
                                                 ##     / You should call this after you're done displaying the Surface.
                                                 ##     /
                                                 ## ```
proc getUserData*(surface: ULSurface): pointer {.
    importc: "ulSurfaceGetUserData", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Get the underlying user data pointer (this is only valid if you have
                                            ##     / set a custom surface implementation via ulPlatformSetSurfaceDefinition).
                                            ##     /
                                            ##     / This will return nullptr if this surface is the default ULBitmapSurface.
                                            ##     /
                                            ## ```
proc getBitmap*(surface: ULBitmapSurface): ULBitmap {.
    importc: "ulBitmapSurfaceGetBitmap", cdecl.}
  ## ```
                                                ##   ***************************************************************************
                                                ##    BitmapSurface
                                                ##   **************************************************************************
                                                ##     /
                                                ##     / Get the underlying Bitmap from the default Surface.
                                                ##     /
                                                ##     / @note  Do not call ulDestroyBitmap() on the returned value, it is owned
                                                ##     /        by the surface.
                                                ##     /
                                                ## ```
proc lyProjection*(transform: ULMatrix4x4; viewport_width: cfloat;
                   viewport_height: cfloat; flip_y: bool): ULMatrix4x4 {.
    importc: "ulApplyProjection", cdecl.}
  ## ```
                                         ##   /
                                         ##     / Sets up an orthographic projection matrix with a certain viewport width
                                         ##     / and height, multiplies it by 'transform', and returns the result.
                                         ##     /
                                         ##     / This should be used to calculate the model-view projection matrix for the
                                         ##     / vertex shaders using the current ULGPUState.
                                         ##     /
                                         ##     / The 'flip_y' can be optionally used to flip the Y coordinate-space.
                                         ##     / (Usually flip_y == true for OpenGL)
                                         ##     /
                                         ## ```
proc platformSetLogger*(logger: ULLogger) {.importc: "ulPlatformSetLogger",
    cdecl.}
  ## ```
           ##   ***************************************************************************
           ##    Platform
           ##   **************************************************************************
           ##     /
           ##     / Set a custom Logger implementation.
           ##     /
           ##     / This is used to log debug messages to the console or to a log file.
           ##     /
           ##     / You should call this before ulCreateRenderer() or ulCreateApp().
           ##     /
           ##     / @note  ulCreateApp() will use the default logger if you never call this.
           ##     /
           ##     / @note  If you're not using ulCreateApp(), (eg, using ulCreateRenderer())
           ##     /        you can still use the default logger by calling
           ##     /        ulEnableDefaultLogger() (@see <AppCore/CAPI.h>)
           ##     /
           ## ```
proc platformSetFileSystem*(file_system: ULFileSystem) {.
    importc: "ulPlatformSetFileSystem", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Set a custom FileSystem implementation.
                                               ##     /
                                               ##     / This is used for loading File URLs (eg, <file:/page.html>). If you don't
                                               ##     / call this, and are not using ulCreateApp() or ulEnablePlatformFileSystem(),
                                               ##     / you will not be able to load any File URLs.
                                               ##     /
                                               ##     / You should call this before ulCreateRenderer() or ulCreateApp().
                                               ##     /
                                               ##     / @note  ulCreateApp() will use the default platform file system if you never
                                               ##     /        call this.
                                               ##     /
                                               ##     / @note  If you're not using ulCreateApp(), (eg, using ulCreateRenderer())
                                               ##     /        you can still use the default platform file system by calling
                                               ##     /        ulEnablePlatformFileSystem() (@see <AppCore/CAPI.h>)
                                               ##     /
                                               ## ```
proc platformSetSurfaceDefinition*(surface_definition: ULSurfaceDefinition) {.
    importc: "ulPlatformSetSurfaceDefinition", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Set a custom Surface implementation.
                                                      ##     /
                                                      ##     / This can be used to wrap a platform-specific GPU texture, Windows DIB,
                                                      ##     / macOS CGImage, or any other pixel buffer target for display on screen.
                                                      ##     /
                                                      ##     / By default, the library uses a bitmap surface for all surfaces but you can
                                                      ##     / override this by providing your own surface definition here.
                                                      ##     /
                                                      ##     / You should call this before ulCreateRenderer() or ulCreateApp().
                                                      ##     /
                                                      ## ```
proc platformSetGPUDriver*(gpu_driver: ULGPUDriver) {.
    importc: "ulPlatformSetGPUDriver", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Set a custom GPUDriver implementation.
                                              ##     /
                                              ##     / This should be used if you have enabled the GPU renderer in the Config and
                                              ##     / are using ulCreateRenderer() (which does not provide its own GPUDriver
                                              ##     / implementation).
                                              ##     /
                                              ##     / The GPUDriver interface is used by the library to dispatch GPU calls to
                                              ##     / your native GPU context (eg, D3D11, Metal, OpenGL, Vulkan, etc.) There
                                              ##     / are reference implementations for this interface in the AppCore repo.
                                              ##     /
                                              ##     / You should call this before ulCreateRenderer().
                                              ##     /
                                              ## ```
proc platformSetClipboard*(clipboard: ULClipboard) {.
    importc: "ulPlatformSetClipboard", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Set a custom Clipboard implementation.
                                              ##     /
                                              ##     / This should be used if you are using ulCreateRenderer() (which does not
                                              ##     / provide its own clipboard implementation).
                                              ##     /
                                              ##     / The Clipboard interface is used by the library to make calls to the
                                              ##     / system's native clipboard (eg, cut, copy, paste).
                                              ##     /
                                              ##     / You should call this before ulCreateRenderer().
                                              ##     /
                                              ## ```
proc createSettings*(): ULSettings {.importc: "ulCreateSettings", cdecl.}
  ## ```
                                                                         ##   /
                                                                         ##     / Create settings with default values (see <AppCore/App.h>).
                                                                         ##     /
                                                                         ## ```
proc destroySettings*(settings: ULSettings) {.importc: "ulDestroySettings",
    cdecl.}
  ## ```
           ##   /
           ##     / Destroy settings.
           ##     /
           ## ```
proc setDeveloperName*(settings: ULSettings; name: ULStringRef) {.
    importc: "ulSettingsSetDeveloperName", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / Set the name of the developer of this app.
                                                  ##     /
                                                  ##     / This is used to generate a unique path to store local application data
                                                  ##     / on the user's machine.
                                                  ##     /
                                                  ##     / Default is "MyCompany"
                                                  ##     /
                                                  ## ```
proc setAppName*(settings: ULSettings; name: ULStringRef) {.
    importc: "ulSettingsSetAppName", cdecl.}
  ## ```
                                            ##   /
                                            ##     / Set the name of this app.
                                            ##     /
                                            ##     / This is used to generate a unique path to store local application data
                                            ##     / on the user's machine.
                                            ##     /
                                            ##     / Default is "MyApp"
                                            ##     /
                                            ## ```
proc setFileSystemPath*(settings: ULSettings; path: ULStringRef) {.
    importc: "ulSettingsSetFileSystemPath", cdecl.}
  ## ```
                                                   ##   /
                                                   ##     / Set the root file path for our file system, you should set this to the
                                                   ##     / relative path where all of your app data is.
                                                   ##     /
                                                   ##     / This will be used to resolve all file URLs, eg file:/page.html
                                                   ##     /
                                                   ##     / @note  The default path is "./assets/"
                                                   ##     /
                                                   ##     /        This relative path is resolved using the following logic:
                                                   ##     /         - Windows: relative to the executable path
                                                   ##     /         - Linux:   relative to the executable path
                                                   ##     /         - macOS:   relative to YourApp.app/Contents/Resources/
                                                   ##     /
                                                   ## ```
proc setLoadShadersFromFileSystem*(settings: ULSettings; enabled: bool) {.
    importc: "ulSettingsSetLoadShadersFromFileSystem", cdecl.}
  ## ```
                                                              ##   /
                                                              ##     / Set whether or not we should load and compile shaders from the file system
                                                              ##     / (eg, from the /shaders/ path, relative to file_system_path).
                                                              ##     /
                                                              ##     / If this is false (the default), we will instead load pre-compiled shaders
                                                              ##     / from memory which speeds up application startup time.
                                                              ##     /
                                                              ## ```
proc setForceCPURenderer*(settings: ULSettings; force_cpu: bool) {.
    importc: "ulSettingsSetForceCPURenderer", cdecl.}
  ## ```
                                                     ##   /
                                                     ##     / We try to use the GPU renderer when a compatible GPU is detected.
                                                     ##     /
                                                     ##     / Set this to true to force the engine to always use the CPU renderer.
                                                     ##     /
                                                     ## ```
proc createApp*(settings: ULSettings; config: ULConfig): ULApp {.
    importc: "ulCreateApp", cdecl.}
  ## ```
                                   ##   /
                                   ##     / Create the App singleton.
                                   ##     /
                                   ##     / @param  settings  Settings to customize App runtime behavior. You can pass
                                   ##     /                   NULL for this parameter to use default settings.
                                   ##     /
                                   ##     / @param  config  Config options for the Ultralight renderer. You can pass
                                   ##     /                 NULL for this parameter to use default config.
                                   ##     /
                                   ##     / @note  You should only create one of these per application lifetime.
                                   ##     /
                                   ##     / @note  Certain Config options may be overridden during App creation,
                                   ##     /        most commonly Config::face_winding and Config::device_scale_hint.
                                   ##     /
                                   ## ```
proc destroyApp*(app: ULApp) {.importc: "ulDestroyApp", cdecl.}
  ## ```
                                                               ##   /
                                                               ##     / Destroy the App instance.
                                                               ##     /
                                                               ## ```
proc setWindow*(app: ULApp; window: ULWindow) {.importc: "ulAppSetWindow", cdecl.}
  ## ```
                                                                                  ##   /
                                                                                  ##     / Set the main window, you must set this before calling ulAppRun.
                                                                                  ##     /
                                                                                  ##     / @param  window  The window to use for all rendering.
                                                                                  ##     /
                                                                                  ##     / @note  We currently only support one Window per App, this will change
                                                                                  ##     /        later once we add support for multiple driver instances.
                                                                                  ##     /
                                                                                  ## ```
proc getWindow*(app: ULApp): ULWindow {.importc: "ulAppGetWindow", cdecl.}
  ## ```
                                                                          ##   /
                                                                          ##     / Get the main window.
                                                                          ##     /
                                                                          ## ```
proc setUpdateCallback*(app: ULApp; callback: ULUpdateCallback;
                        user_data: pointer) {.importc: "ulAppSetUpdateCallback",
    cdecl.}
  ## ```
           ##   /
           ##     / Set a callback for whenever the App updates. You should update all app
           ##     / logic here.
           ##     /
           ##     / @note  This event is fired right before the run loop calls
           ##     /        Renderer::Update and Renderer::Render.
           ##     /
           ## ```
proc isRunning*(app: ULApp): bool {.importc: "ulAppIsRunning", cdecl.}
  ## ```
                                                                      ##   /
                                                                      ##     / Whether or not the App is running.
                                                                      ##     /
                                                                      ## ```
proc getMainMonitor*(app: ULApp): ULMonitor {.importc: "ulAppGetMainMonitor",
    cdecl.}
  ## ```
           ##   /
           ##     / Get the main monitor (this is never NULL).
           ##     /
           ##     / @note  We'll add monitor enumeration later.
           ##     /
           ## ```
proc getRenderer*(app: ULApp): ULRenderer {.importc: "ulAppGetRenderer", cdecl.}
  ## ```
                                                                                ##   /
                                                                                ##     / Get the underlying Renderer instance.
                                                                                ##     /
                                                                                ## ```
proc run*(app: ULApp) {.importc: "ulAppRun", cdecl.}
  ## ```
                                                    ##   /
                                                    ##     / Run the main loop, make sure to call ulAppSetWindow before calling this.
                                                    ##     /
                                                    ## ```
proc quit*(app: ULApp) {.importc: "ulAppQuit", cdecl.}
  ## ```
                                                      ##   /
                                                      ##     / Quit the application.
                                                      ##     /
                                                      ## ```
proc getScale*(monitor: ULMonitor): cdouble {.importc: "ulMonitorGetScale",
    cdecl.}
  ## ```
           ##   /
           ##     / Get the monitor's DPI scale (1.0 = 100%).
           ##     /
           ## ```
proc createWindow*(monitor: ULMonitor; width: cuint; height: cuint;
                   fullscreen: bool; window_flags: cuint): ULWindow {.
    importc: "ulCreateWindow", cdecl.}
  ## ```
                                      ##   /
                                      ##     / Create a new Window.
                                      ##     /
                                      ##     / @param  monitor       The monitor to create the Window on.
                                      ##     /
                                      ##     / @param  width         The width (in device coordinates).
                                      ##     /
                                      ##     / @param  height        The height (in device coordinates).
                                      ##     /
                                      ##     / @param  fullscreen    Whether or not the window is fullscreen.
                                      ##     /
                                      ##     / @param  window_flags  Various window flags.
                                      ##     /
                                      ## ```
proc destroyWindow*(window: ULWindow) {.importc: "ulDestroyWindow", cdecl.}
  ## ```
                                                                           ##   /
                                                                           ##     / Destroy a Window.
                                                                           ##     /
                                                                           ## ```
proc setCloseCallback*(window: ULWindow; callback: ULCloseCallback;
                       user_data: pointer) {.
    importc: "ulWindowSetCloseCallback", cdecl.}
  ## ```
                                                ##   /
                                                ##     / Set a callback to be notified when a window closes.
                                                ##     /
                                                ## ```
proc setResizeCallback*(window: ULWindow; callback: ULResizeCallback;
                        user_data: pointer) {.
    importc: "ulWindowSetResizeCallback", cdecl.}
  ## ```
                                                 ##   /
                                                 ##     / Set a callback to be notified when a window resizes
                                                 ##     / (parameters are passed back in pixels).
                                                 ##     /
                                                 ## ```
proc isFullscreen*(window: ULWindow): bool {.importc: "ulWindowIsFullscreen",
    cdecl.}
  ## ```
           ##   /
           ##     / Get whether or not a window is fullscreen.
           ##     /
           ## ```
proc setTitle*(window: ULWindow; title: cstring) {.importc: "ulWindowSetTitle",
    cdecl.}
  ## ```
           ##   /
           ##     / Set the window title.
           ##     /
           ## ```
proc setCursor*(window: ULWindow; cursor: ULCursor) {.
    importc: "ulWindowSetCursor", cdecl.}
  ## ```
                                         ##   /
                                         ##     / Set the cursor for a window.
                                         ##     /
                                         ## ```
proc close*(window: ULWindow) {.importc: "ulWindowClose", cdecl.}
  ## ```
                                                                 ##   /
                                                                 ##     / Close a window.
                                                                 ##     /
                                                                 ## ```
proc deviceToPixel*(window: ULWindow; val: cint): cint {.
    importc: "ulWindowDeviceToPixel", cdecl.}
  ## ```
                                             ##   /
                                             ##     / Convert device coordinates to pixels using the current DPI scale.
                                             ##     /
                                             ## ```
proc pixelsToDevice*(window: ULWindow; val: cint): cint {.
    importc: "ulWindowPixelsToDevice", cdecl.}
  ## ```
                                              ##   /
                                              ##     / Convert pixels to device coordinates using the current DPI scale.
                                              ##     /
                                              ## ```
proc getNativeHandle*(window: ULWindow): pointer {.
    importc: "ulWindowGetNativeHandle", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Get the underlying native window handle.
                                               ##     /
                                               ##     / @note This is:  - HWND on Windows
                                               ##     /                 - NSWindow* on macOS
                                               ##     /                 - GLFWwindow* on Linux
                                               ##     /
                                               ## ```
proc createOverlay*(window: ULWindow; width: cuint; height: cuint; x: cint;
                    y: cint): ULOverlay {.importc: "ulCreateOverlay", cdecl.}
  ## ```
                                                                             ##   /
                                                                             ##     / Create a new Overlay.
                                                                             ##     /
                                                                             ##     / @param  window  The window to create the Overlay in. (we currently only
                                                                             ##     /                 support one window per application)
                                                                             ##     /
                                                                             ##     / @param  width   The width in device coordinates.
                                                                             ##     /
                                                                             ##     / @param  height  The height in device coordinates.
                                                                             ##     /
                                                                             ##     / @param  x       The x-position (offset from the left of the Window), in
                                                                             ##     /                 pixels.
                                                                             ##     /
                                                                             ##     / @param  y       The y-position (offset from the top of the Window), in
                                                                             ##     /                 pixels.
                                                                             ##     /
                                                                             ##     / @note  Each Overlay is essentially a View and an on-screen quad. You should
                                                                             ##     /        create the Overlay then load content into the underlying View.
                                                                             ##     /
                                                                             ## ```
proc createOverlayWithView*(window: ULWindow; view: ULView; x: cint; y: cint): ULOverlay {.
    importc: "ulCreateOverlayWithView", cdecl.}
  ## ```
                                               ##   /
                                               ##     / Create a new Overlay, wrapping an existing View.
                                               ##     /
                                               ##     / @param  window  The window to create the Overlay in. (we currently only
                                               ##     /                 support one window per application)
                                               ##     /
                                               ##     / @param  view    The View to wrap (will use its width and height).
                                               ##     /
                                               ##     / @param  x       The x-position (offset from the left of the Window), in
                                               ##     /                 pixels.
                                               ##     /
                                               ##     / @param  y       The y-position (offset from the top of the Window), in
                                               ##     /                 pixels.
                                               ##     /
                                               ##     / @note  Each Overlay is essentially a View and an on-screen quad. You should
                                               ##     /        create the Overlay then load content into the underlying View.
                                               ##     /
                                               ## ```
proc destroyOverlay*(overlay: ULOverlay) {.importc: "ulDestroyOverlay", cdecl.}
  ## ```
                                                                               ##   /
                                                                               ##     / Destroy an overlay.
                                                                               ##     /
                                                                               ## ```
proc getView*(overlay: ULOverlay): ULView {.importc: "ulOverlayGetView", cdecl.}
  ## ```
                                                                                ##   /
                                                                                ##     / Get the underlying View.
                                                                                ##     /
                                                                                ## ```
proc getX*(overlay: ULOverlay): cint {.importc: "ulOverlayGetX", cdecl.}
  ## ```
                                                                        ##   /
                                                                        ##     / Get the x-position (offset from the left of the Window), in pixels.
                                                                        ##     /
                                                                        ## ```
proc getY*(overlay: ULOverlay): cint {.importc: "ulOverlayGetY", cdecl.}
  ## ```
                                                                        ##   /
                                                                        ##     / Get the y-position (offset from the top of the Window), in pixels.
                                                                        ##     /
                                                                        ## ```
proc moveTo*(overlay: ULOverlay; x: cint; y: cint) {.importc: "ulOverlayMoveTo",
    cdecl.}
  ## ```
           ##   /
           ##     / Move the overlay to a new position (in pixels).
           ##     /
           ## ```
proc isHidden*(overlay: ULOverlay): bool {.importc: "ulOverlayIsHidden", cdecl.}
  ## ```
                                                                                ##   /
                                                                                ##     / Whether or not the overlay is hidden (not drawn).
                                                                                ##     /
                                                                                ## ```
proc hide*(overlay: ULOverlay) {.importc: "ulOverlayHide", cdecl.}
  ## ```
                                                                  ##   /
                                                                  ##     / Hide the overlay (will no longer be drawn).
                                                                  ##     /
                                                                  ## ```
proc show*(overlay: ULOverlay) {.importc: "ulOverlayShow", cdecl.}
  ## ```
                                                                  ##   /
                                                                  ##     / Show the overlay.
                                                                  ##     /
                                                                  ## ```
proc enablePlatformFontLoader*() {.importc: "ulEnablePlatformFontLoader", cdecl.}
  ## ```
                                                                                 ##   ***************************************************************************
                                                                                 ##    Platform
                                                                                 ##   **************************************************************************
                                                                                 ##     /
                                                                                 ##     / This is only needed if you are not calling ulCreateApp().
                                                                                 ##     /
                                                                                 ##     / Initializes the platform font loader and sets it as the current FontLoader.
                                                                                 ##     /
                                                                                 ## ```
proc enablePlatformFileSystem*(base_dir: ULStringRef) {.
    importc: "ulEnablePlatformFileSystem", cdecl.}
  ## ```
                                                  ##   /
                                                  ##     / This is only needed if you are not calling ulCreateApp().
                                                  ##     /
                                                  ##     / Initializes the platform file system (needed for loading file:/ URLs) and
                                                  ##     / sets it as the current FileSystem.
                                                  ##     /
                                                  ##     / You can specify a base directory path to resolve relative paths against.
                                                  ##     /
                                                  ## ```
proc enableDefaultLogger*(log_path: ULStringRef) {.
    importc: "ulEnableDefaultLogger", cdecl.}
  ## ```
                                             ##   /
                                             ##     / This is only needed if you are not calling ulCreateApp().
                                             ##     /
                                             ##     / Initializes the default logger (writes the log to a file).
                                             ##     /
                                             ##     / You should specify a writable log path to write the log to
                                             ##     / for example "./ultralight.log".
                                             ##     /
                                             ## ```
{.pop.}

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
