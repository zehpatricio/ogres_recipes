String formatDuration(Duration duration) {
  return duration.toString().substring(0, duration.toString().lastIndexOf(':'));
}
