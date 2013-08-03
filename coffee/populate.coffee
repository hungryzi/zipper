zipper.indexedDB.populate = (e) ->
  db = zipper.indexedDB.db = e.target.result

  e.target.transaction.onerror = zipper.indexedDB.onerror

  # create object stores
  db.deleteObjectStore "left"  if db.objectStoreNames.contains("left")
  leftStore = db.createObjectStore "left",
    keyPath: "id",
    autoComplete: true

  db.deleteObjectStore "right"  if db.objectStoreNames.contains("right")
  rightStore = db.createObjectStore "right",
    keyPath: "id",
    autoComplete: true

  # put in test data
  n = 10
  while n -= 1
    leftStore.add id: n, desc: "left ##{n}"
    rightStore.add id: n, desc: "right ##{n}"

