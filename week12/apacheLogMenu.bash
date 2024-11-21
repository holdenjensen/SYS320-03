#!/bin/bash

menu() {
echo "Please select an option:"
echo "[1] Display all Logs"
echo "[2] Display only IPS"
echo "[3] Display only Pages"
echo "[4] Histogram"
echo "[5] Frequent Visitors"
echo "[6] Suspicious Visitors"
echo "[7] Quit"
}

displayAllLogs() {
cat /var/log/apache2/access.log
}

displayOnlyIPs() {
awk '{print $1}' /var/log/apache2/access.log | sort | uniq
}

displayOnlyPages() {
awk '{print $7}' /var/log/apache2/access.log | sort | uniq
}

frequentVisitors() {
echo "Frequent Visitors:"
awk '{print $1}' /var/log/apache2/access.log | sort | uniq -c | sort -nr | head
}

suspiciousVisitors() {
echo "Suspicious Visitors:"
while read -r ioc; do
grep "$ioc" /var/log/apache2/access.log | awk '{print $1}' | sort | uniq -c
done < ./ioc.txt
}

while true; do
menu
read -p "Enter your choice:" choice

case $choice in
1) displayAllLogs ;;
2) displayOnlyIPS ;;
3) displayOnlyPages ;;
4) echo "Feature not implemented yet" ;;
5) frequentVisitors ;;
6) suspiciousVisitors ;;
7) echo "Exiting..."; break;;
*) invalidOption ;;
esac
done
