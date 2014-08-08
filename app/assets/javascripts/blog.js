function KLIK(language) {
  var hostname = window.location.hostname;
  var pathname = window.location.pathname;
  var path;
  pathname = pathname.replace(/\/..\//, '/');
  if (language === 'en') {
    path = pathname;
  } else {
    path = '/'+language+pathname;
  }
  window.location.assign(path);
}