export DISPLAY=:0 

pkill -SIGTERM firefox

#/usr/bin/firefox "http://127.0.0.1:7177" &

#sleep 2 &&

cd /home/user/Desktop/adminlinux &&

(sleep 2 && /usr/bin/firefox "http://127.0.0.1:7177" &);

/usr/bin/Rscript -e 'source("app.R")'
