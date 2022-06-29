import { CONFIG_KEY, URL } from '../constants'
import { ConfigEntity } from '../types'
import { isValid, validate } from '../validate'
import { triggerConfigError } from 'components/ConfigContext'
import { EMPTY_CONFIG, save } from '..'

export const load = async (
  overridingConfig?: ConfigEntity
): Promise<ConfigEntity> => {
  // Pick the overriding connfig if it exists first
  if (overridingConfig && isValid(overridingConfig)) return overridingConfig

  //Then check the local storage if we have one saved there
  const localConfigString = localStorage.getItem(CONFIG_KEY)
  const localConfig = !!localConfigString && JSON.parse(localConfigString)

  sync().then((remoteConfig)=>{
    save(remoteConfig)
    console.log("Synced new config from remote!")
  })

  if (isValid(localConfig)) return localConfig

  const remoteConfig=await sync()

  return remoteConfig
 
}

export const sync = async (): Promise<ConfigEntity> => {
  const remoteConfig = await fetch(URL).then((response) => response.json())
  const [valid, error, path] = validate(remoteConfig)
  if (!valid) throw new Error(`${error}\nPath: ${path}`)

  return remoteConfig
}
