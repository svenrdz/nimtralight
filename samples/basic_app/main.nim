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
  ulOverlayResize(overlay, width, height)

proc onDOMReady(userData: pointer, caller: ULView, frameId: culonglong,
    isMainFrame: bool, url: ULString) {.cdecl.} =
  var
    ctx = view.ulViewLockJSContext
    name = "GetMessage".JSStringCreateWithUTF8CString
    fun = JSObjectMakeFunctionWithCallback(ctx, name, getMessage)
  JSObjectSetProperty(ctx, JSContextGetGlobalObject(ctx), name, fun, 0, nil)
  name.JSStringRelease
  view.ulViewUnlockJSContext

proc init() =
  var
    settings = ulCreateSettings()
  ulSettingsSetForceCPURenderer(settings, true)

  var
    config = ulCreateConfig()
  app = ulCreateApp(settings, config)
  ulAppSetUpdateCallback(app, onUpdate, nil)
  settings.ulDestroySettings
  config.ulDestroyConfig
  window = ulCreateWindow(ulAppGetMainMonitor(app), 500, 500, false,
      kWindowFlags_Titled.cuint) #| kWindowFlags_Resizable)

  ulWindowSetTitle(window, "Ultralight Sample 6 - Intro to C API")
  ulWindowSetResizeCallback(window, onResize, nil)
  ulAppSetWindow(app, window)
  overlay = ulCreateOverlay(window, ulWindowGetWidth(window), ulWindowGetHeight(
      window), 0, 0)
  view = overlay.ulOverlayGetView
  ulViewSetDOMReadyCallback(view, onDOMReady, nil)
  var
    url = "file:///app.html".ulCreateString
  ulViewLoadURL(view, url)
  url.ulDestroyString

proc shutdown() =
  overlay.ulDestroyOverlay
  window.ulDestroyWindow
  app.ulDestroyApp

init()
ulAppRun(app)
shutdown()
