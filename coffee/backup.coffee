zipper.backup = (databaseName, includeData = true) ->
  initializeDatabaseJson = (db) ->
    databaseJson = {}
    databaseJson.name = db.name
    databaseJson.version = db.version
    databaseJson.objectStores = []
    databaseJson

  initializeStoreJson = (store) ->
    storeJson = {}
    storeJson.name = store.name
    storeJson.options = {
      keyPath: store.keyPath
      autoIncrement: store.autoIncrement
    }

    storeJson.indexes = []
    storeJson.data = []
    storeJson

  saveStoreIndexStructure = (store, storeJson) ->
    indexNames = store.indexNames
    for indexName in indexNames
      index = store.index(indexName)
      indexJson = {}
      indexJson.name = indexName
      indexJson.keyPath = index.keyPath
      indexJson.options = {
        unique: index.unique
        multiEntry: index.multiEntry
      }
      storeJson.indexes.push indexJson

  saveStoreData = (store, storeJson) ->
    cursorRequest = store.openCursor()
    cursorRequest.onsuccess = (e) ->
      result = e.target.result
      if result?
        storeJson.data.push result.value
        result.continue()

    cursorRequest.onerror = zipper.indexedDB.onerror

  showDownloadLink = ->
    url = zipper.generateDownloadUrl JSON.stringify(zipper.databaseJson)
    tag = $('<a/>').attr('href', url).text('Download here')
    $('body').append(tag)

  dbOperation = ->
    db = zipper.indexedDB.db

    zipper.databaseJson = initializeDatabaseJson(db)

    objectStoreNames = db.objectStoreNames
    transaction = db.transaction objectStoreNames, 'readonly'
    transaction.oncomplete = ->
      showDownloadLink()

    for name in objectStoreNames
      store = transaction.objectStore name

      storeJson = initializeStoreJson(store)
      zipper.databaseJson.objectStores.push storeJson

      saveStoreIndexStructure(store, storeJson)
      saveStoreData(store, storeJson) if includeData

  zipper.indexedDB.open databaseName, dbOperation

zipper.backupStructure = (databaseName) ->
  zipper.backup databaseName, false

zipper.backupStructureAndData = zipper.backup

