#!/bin/bash

# Kullanıcı isimlerinin bulunduğu dosya (örneğin, userlist.txt)
USERLIST="userlist.txt"

# Sabit grup ID
GROUP_ID=1000

# USERLIST dosyasının varlığını kontrol et
if [[ ! -f $USERLIST ]]; then
  echo "Kullanıcı listesi dosyası ($USERLIST) bulunamadı!"
  exit 1
fi

# USERLIST dosyasındaki her bir satırı (kullanıcı adı, adı ve soyadı) oku
while IFS=';' read -r USERNAME FULL_NAME; do
  # /etc/passwd dosyasında kullanıcı adının olup olmadığını kontrol et
  if ! grep -q "^$USERNAME:" /etc/passwd; then
    # Kullanıcıyı /etc/passwd dosyasına manuel olarak ekleyin
    USER_ID=$(awk -F: '{if ($3 >= 1000 && $3 < 60000) print $3}' /etc/passwd | sort -n | tail -1)
    USER_ID=$((USER_ID+1))
    echo "$USERNAME:x:$USER_ID:$GROUP_ID:$FULL_NAME,,,:/home/$USERNAME:/bin/bash" >> /etc/passwd

    # Home dizinini oluşturun
    mkdir "/home/$USERNAME"

    # Home dizinindeki hakları kullanıcıya atayın
    chown "$USERNAME":"$GROUP_ID" "/home/$USERNAME"
  fi
done < "$USERLIST"
