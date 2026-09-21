function contrastColor(color) {
  const col = Qt.darker(color, 1);
  const luminance = 0.299 * col.r + 0.587 * col.g + 0.114 * col.b;
  return luminance < 0.5 ? "white" : "black";
}

function initService(serviceName) {
  console.log(`init: ${serviceName}`);
}
