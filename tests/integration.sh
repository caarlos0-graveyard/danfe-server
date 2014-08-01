#!/bin/sh

[ -d $@ ] && server="http://danfe-server.herokuapp.com" || server="$@"

echo "Cleaning up..."
[ -d tmp ] && rm -rf tmp/* || mkdir tmp/
PIDS=""

echo "Testing against ${server}..."
for xml in danfe.xml nfe_simples_nacional.xml nfe_with_ns.xml \
  nfce.xml nfe_with_fci.xml nfe_without_ns.xml; do
  curl -X POST ${server} \
    -F "file=@./ruby-danfe/test/${xml}" \
    -o ./tmp/${xml}.pdf -s 2>/dev/null &
  PIDS="${PIDS} $!"
done

for pid in $PIDS; do
  wait $pid
done

echo "Done! Generated files:"
ls -lha ./tmp/*.pdf
