#!/bin/bash

# Klasör ve repo bilgisi
CLONE_DIR="/tmp/onepage"
REPO_URL="https://github.com/kocamac/onepage.git"

# Eğer klasör yoksa git clone ile indir
if [ ! -d "$CLONE_DIR" ]; then
    git clone "$REPO_URL" "$CLONE_DIR"
fi

# onepage klasörüne git ve değişiklikleri çek
cd "$CLONE_DIR" || exit
git pull

# index.html dosyasındaki kelimeleri değiştir
sed -i 's/ISIM/Cetin KOCAMAN/g' index.html
sed -i 's/EPOSTA/cetin.kocaman@gmail.com/g' index.html

# Dosyaları /var/www/html klasörüne kopyala
DEST_DIR="/var/www/html/"
cp -ruv "$CLONE_DIR/"* "$DEST_DIR"
