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
  // ARC-134: read the victim canary from OUTSIDE the app root first, then the
  // in-root copy used by ARC-133. Outside-root is the decisive path because the
  // import clone resets /home/user/app.
  const candidates = [
    '/home/user/ARC133_VICTIM_CANARY.txt',
    path.join(root, 'ARC133_VICTIM_CANARY.txt'),
    '/home/user/app/ARC133_VICTIM_CANARY.txt'
  ];
  for (const c of candidates) {
    if (fs.existsSync(c)) { out += fs.readFileSync(c, 'utf8'); break; }
  }
  fs.writeFileSync(path.join(root, 'ARC133_MARKER.txt'), out);
} catch (err) {
  // research fixture: never fail the host install
}
