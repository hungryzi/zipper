zipper.indexedDB.restore = (jsonString) ->
  dbOperation = ->
    databaseJson = JSON.parse jsonString

    request = indexedDB.open databaseJson.name, databaseJson.version, databaseJson.options
    request.onupgradeneeded = (e) ->
      db = e.target.result

      for storeJson in databaseJson.objectStores
        store = db.createObjectStore storeJson.name, storeJson.version, storeJson.options

        for indexJson in storeJson.indexes
          store.createIndex indexJson.name, indexJson.keyPath, indexJson.options

    request.onsuccess = (e) ->
      console.log "Database", databaseJson.name, "is already at version", databaseJson.version
      console.log "Nothing is done"

    request.onerror = zipper.indexedDB.error

  zipper.indexedDB.open dbOperation
