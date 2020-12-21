import nimtralight_sys

var
  app {.global.}: ULApp
  window {.global.}: ULWindow
  overlay {.global.}: ULOverlay
  view {.global.}: ULView

proc getMessage(ctx: JSContextRef, function: JSObjectRef;
    thisObject: JSObjectRef, argumentCount: uint, arguments: UncheckedArray[
    JSValueRef], exception: ptr JSValueRef): JSValueRef {.cdecl.} =
  var
    str = "Hello from nim!".JSStringCreateWithUTF8CString
    value = JSValueMakeString(ctx, str)
  str.JSStringRelease
  return value

proc onUpdate(userData: pointer) {.cdecl.} = discard

proc onResize(userData: pointer, width: cuint, height: cuint) {.cdecl.} =
  overlay.resize(width, height)

proc onDOMReady(userData: pointer, caller: ULView, frameId: culonglong,
    isMainFrame: bool, url: ULString) {.cdecl.} =
  var
    ctx = view.lockJSContext
    name = "GetMessage".JSStringCreateWithUTF8CString
    fun = JSObjectMakeFunctionWithCallback(ctx, name, getMessage)
  JSObjectSetProperty(ctx, JSContextGetGlobalObject(ctx), name, fun, 0, nil)
  name.JSStringRelease
  view.unlockJSContext

proc init() =
  var
    settings = newULSettings()
  settings.setForceCPURenderer(true)

  var
    config = newULConfig()
  app = newULApp(settings, config)
  app.setUpdateCallback(onUpdate, nil)
  settings.destroySettings
  config.destroyConfig
  window = newULWindow(app.getMainMonitor, 500, 500, false,
      kWindowFlags_Titled.cuint) #| kWindowFlags_Resizable)

  window.setTitle("Ultralight Sample 6 - Intro to C API")
  window.setResizeCallback(onResize, nil)
  app.setWindow(window)
  overlay = window.newULOverlay(window.getWidth, window.getHeight, 0, 0)
  view = overlay.getView
  view.setDOMReadyCallback(onDOMReady, nil)
  var
    url = "file:///app.html".newULString
  view.loadURL(url)
  url.destroyString

proc shutdown() =
  overlay.destroyOverlay
  window.destroyWindow
  app.destroyApp

init()
app.run
shutdown()
