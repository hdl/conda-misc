
#!/bin/bash

set -e
set -x

which npm
npm install -g .

# Remove links created by npm
unlink $PREFIX/bin/netlistsvg
unlink $PREFIX/bin/netlistsvg-dumplayout
unlink $PREFIX/lib/node_modules/netlistsvg

# Copy the content instead, make relative links
cp -r  ./ $PREFIX/lib/node_modules/netlistsvg
ln -r -s $PREFIX/lib/node_modules/netlistsvg/bin/netlistsvg.js $PREFIX/bin/netlistsvg
ln -r -s $PREFIX/lib/node_modules/netlistsvg/bin/exportLayout.js $PREFIX/bin/netlistsvg-dumplayout
