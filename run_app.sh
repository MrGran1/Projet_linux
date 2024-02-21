export DISPLAY=:0 

pkill -SIGTERM firefox

cd /home/Documents/Cours/linux/Projet_Linux/ &&

(sleep 2 && /usr/bin/firefox "http://127.0.0.1:7177" &);

/usr/bin/Rscript -e 'source("app.R")'
