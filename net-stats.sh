#!/bin/bash
aFL=(rxBytes rxPackets rxErr rxDrop rxFIFO rxFrame rxCompressed rxMulticast txBytes txPackets txErr txDrop txFIFO txFrame txCompressed txMulticast )
i=0
str=''

getData(){
grep -vi 'lo:\|Receive\|bytes' /proc/net/dev|cut -d':' -f2|xargs
}

outputData(){
  while echo '' ;do
    strData="$(getData)"
    strData="${strData//\ /\\n}"
    echo -e '\f\n'"$strData"
    sleep 1
  done
}

for i in {0..15} ;do str="${str} --field=${aFL[$i]}:"; done
outputData|yad --form --cycle-read --columns=2 $str
