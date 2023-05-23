enum Status { init, load, success, fail }

enum StartStatus { init, loading, success, fail, hasData }

enum HomeStatus { init, loading, success, fail }

enum DataAppStatus {
  init,
  loading,
  checkVersion,
  downloading,
  downloaded,
  success,
  extractFailure,
  deleteFileDataAndRedownload,
  waitForNewUpdate,
  notInternet,
  extract,
}

enum CharacterStatus { init, loading, success, fail }
