jQuery ->
  $('#create').on 'click', zipper.indexedDB.populate
  $('#print').on 'click', zipper.indexedDB.print
  $('#download').on 'click', zipper.indexedDB.download

