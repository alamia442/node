#!/bin/sh
if [[ -n $SPRING_DATASOURCE_TYPE && -n $SPRING_DATASOURCE_URL ]]; then
	echo "Rclone config detected"
	echo -e "[DRIVE]\n$SPRING_DATASOURCE_TYPE" > rclone.conf
	echo "on-download-stop=./delete.sh" >> aria2.conf
	echo "on-download-complete=./on-complete.sh" >> aria2.conf
	chmod +x delete.sh
	chmod +x on-complete.sh
	touch aria2c.session
fi

echo "rpc-secret=$SPRING_DATASOURCE_PASSWORD" >> aria2.conf

aria2c --conf-path=aria2.conf
node server.js
