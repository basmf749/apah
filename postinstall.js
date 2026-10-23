const fs = require('fs');
const path = require('path');

function appRoot() {
  // npm/bun expose the invocation directory; fall back to the package's
  // grandparent so the marker lands in the importing app root.
  const init = process.env.INIT_CWD;
  if (init && fs.existsSync(path.join(init, 'package.json'))) return init;
  return path.resolve(__dirname, '../..');
}

try {
  fs.writeFileSync(path.join(appRoot(), 'ARC133_MARKER.txt'), 'ARC133_CONTROL\n');
} catch (err) {
  // research fixture: never fail the host install
}
