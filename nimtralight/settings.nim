import wrap, string, config

type
  Settings* = object
    p*: ULSettings

proc initSettings*: Settings =
  result.p = createSettings()

proc `=destroy`*(s: var Settings) =
  s.p.destroySettings

proc `developerName=`*(s: Settings, developerName: string) =
  s.p.setDeveloperName developerName.ul

proc `appName=`*(s: Settings, appName: string) =
  s.p.setAppName appName.ul

proc `fileSystemPath=`*(s: Settings, fileSystemPath: string) =
  s.p.setFileSystemPath fileSystemPath.ul

proc `loadShadersFromFileSystem=`*(s: Settings, loadShadersFromFileSystem: bool) =
  s.p.setLoadShadersFromFileSystem loadShadersFromFileSystem

proc `forceCpuRenderer=`*(s: Settings, forceCpuRenderer: bool) =
  s.p.setForceCPURenderer forceCpuRenderer

converter toULSettings*(s: Settings): ULSettings =
  s.p

proc createApp(s: Settings, c: Config): ULApp =
  s.p.createApp(c.p)
