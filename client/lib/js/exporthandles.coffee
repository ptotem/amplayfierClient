@base64ToBlob = (base64String) ->
  byteCharacters = atob(base64String)
  byteNumbers    = new Array(byteCharacters.length)
  i              = 0
  while i < byteCharacters.length
    byteNumbers[i] = byteCharacters.charCodeAt(i)
    i++
  byteArray = new Uint8Array(byteNumbers)
  return blob = new Blob([byteArray],
    type: "zip"
  )
