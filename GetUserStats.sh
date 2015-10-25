#!/bin/bash
reqs=$1
conc=$2

if [ -n "$reqs" ] && [ -n "$conc" ]; then
    echo number of requests  : $reqs
    echo concurrent requests : $conc

    ab -l -r -k -H "Accept-Encoding: gzip, deflate" \
      -n $reqs -c $conc \
      -g results/GetUserStats-$reqs-$conc.gnuplot \
      -e results/GetUserStats-$reqs-$conc.csv \
      http://gurbetinoylari.azurewebsites.net/api/v1/Tutanak/GetUserStats \
      >> results/GetUserStats-$reqs-$conc.txt

    gnuplot -e "title='GetUserStats $reqs requests/$conc concurrent'; filename='results/GetUserStats-$reqs-$conc.jpg'; input='results/GetUserStats-$reqs-$conc.gnuplot'" GetUserStats.plot
fi
