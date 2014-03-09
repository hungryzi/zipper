zipper.downloadStructure = ->
  dbOperation = ->
    db = zipper.indexedDB.db

    databaseJson = {}
    databaseJson.name = db.name
    databaseJson.version = db.version
    databaseJson.objectStores = []

    objectStoreNames = db.objectStoreNames
    transaction = db.transaction objectStoreNames, 'readonly'

    for name in objectStoreNames
      store = transaction.objectStore name
      storeJson = {}
      storeJson.name = store.name
      storeJson.keyPath = store.keyPath
      storeJson.options = {
        autoIncrement: store.autoIncrement
      }
      storeJson.indexes = []

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

      databaseJson.objectStores.push storeJson

    url = zipper.generateDownloadUrl JSON.stringify(databaseJson)
    tag = $('<a/>').attr('href', url).text('Download here')
    $('body').append(tag)

  zipper.indexedDB.open dbOperation

