function oldest() {
  $("#oldest_comments").removeClass("comments");
  $("#newest_comments").addClass("comments");
  $("#newest_button").removeClass("active");
}

function newest() {
  $("#newest_comments").removeClass("comments");
  $("#oldest_comments").addClass("comments");
  $("#oldest_button").removeClass("active");
}