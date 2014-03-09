zipper.indexedDB.restore = (jsonString) ->
  parseKeyPath = (keyPathJson) ->
    if typeof(keyPathJson) == 'object'
      keyPath = []
      for key, value of keyPathJson
        keyPath.push value unless isNaN(key)
    else
      keyPath = keyPathJson
    keyPath

  # pretend that the database doesn't exist
  databaseJson = JSON.parse jsonString

  request = indexedDB.open databaseJson.name, databaseJson.version, databaseJson.options
  request.onupgradeneeded = (e) ->
    db = e.target.result

    for storeJson in databaseJson.objectStores
      store = db.createObjectStore storeJson.name, storeJson.options

      for indexJson in storeJson.indexes
        keyPath = parseKeyPath(indexJson.keyPath)
        store.createIndex indexJson.name, keyPath, indexJson.options

  request.onsuccess = (e) ->
    # should not run this if database exists
    db = e.target.result
    objectStoreNames = db.objectStoreNames
    return if objectStoreNames.length == 0

    transaction = db.transaction db.objectStoreNames, 'readwrite'

    for storeJson in databaseJson.objectStores
      store = transaction.objectStore storeJson.name

      for obj in storeJson.data
        store.add obj

      null

  request.onerror = zipper.indexedDB.error

