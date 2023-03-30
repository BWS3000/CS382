read -p "File: " pname
aarch64-linux-gnu-as $pname.s -o $pname.o
sleep 1
aarch64-linux-gnu-ld $pname.o -lc -o $pname
sleep 1
qemu-aarch64 -L /usr/aarch64-linux-gnu/ $pname