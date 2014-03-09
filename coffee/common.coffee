window.zipper = {}
window.zipper.indexedDB = {}

zipper.indexedDB.open = (databaseName, operation) ->
  request = indexedDB.open databaseName

  request.onsuccess = (e) ->
    zipper.indexedDB.db = e.target.result

    if operation? && typeof(operation) == 'function'
      operation()
      zipper.indexedDB.close()
    else
      console.log 'Database has been opened. Please remember to close it after use.'

  request.onerror = zipper.indexedDB.onerror

zipper.indexedDB.onerror = (e) ->
  console.debug 'ERROR', e

zipper.indexedDB.close = ->
  zipper.indexedDB.db.close() if zipper.indexedDB.db

zipper.indexedDB.drop = (databaseName) ->
  indexedDB.deleteDatabase databaseName

zipper.generateDownloadUrl = (content) ->
  blob = new Blob([content], type: 'application/octet-binary')
  URL.createObjectURL(blob)

zipper.indexedDB.bootstrap = ->
  version = 1
  request = indexedDB.open("zipper", version)
  request.onupgradeneeded = zipper.indexedDB.populate
  request.onerror = zipper.indexedDB.onerror

