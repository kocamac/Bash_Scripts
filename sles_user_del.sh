#!/bin/bash

# Kullanici isimlerinin bulunduğu dosya
USERLIST="user_delete.txt"

# USERLIST dosyasinin varlığını kontrol et
if [[ ! -f $USERLIST ]]; then
  echo "Kullanici listesi dosyasi ($USERLIST) bulunamadi!"
  exit 1
fi

# USERLIST dosyasındaki her bir satıri (kullanıcı adi) oku
while IFS= read -r USERNAME; do
  # /etc/passwd ve /etc/shadow dosyalarından kullanıcı adının geçtiği satırları sil
  sed -i "/^$USERNAME:/d" /etc/passwd
  sed -i "/^$USERNAME:/d" /etc/shadow

  # Kullanicinin home dizinini sil 
    rm -rf "/home/$USERNAME"
done < "$USERLIST"
