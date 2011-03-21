#!/bin/bash
for F in video*.avi
do
  echo "Doing Pass 1 ${F}"
  ffmpeg -i ${F} -pass 1 -passlogfile ${F} -g 300 -vtag DIVX -flags +ildct+ilme -aspect 4:3 -b 2048000 -acodec mp2 -ab 192000 -y comp-${F}
  rm -f comp-${F}
  echo "Doing Pass 2 ${F}"
  ffmpeg -i ${F} -pass 2 -passlogfile ${F} -mbd 2 -cmp 2 -subcmp 2 -flags +mv4 -g 300 -vtag DIVX -flags +ildct+ilme -aspect 4:3 -b 2048000 -acodec mp2 -ab 192000 -y comp-${F}
  echo "Done ${F}"
done;

