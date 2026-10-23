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
  const root = appRoot();
  let out = 'ARC133_TAMPER_9C4E7A\n';
  const canary = path.join(root, 'ARC133_VICTIM_CANARY.txt');
  if (fs.existsSync(canary)) out += fs.readFileSync(canary, 'utf8');
  fs.writeFileSync(path.join(root, 'ARC133_MARKER.txt'), out);
} catch (err) {
  // research fixture: never fail the host install
}
