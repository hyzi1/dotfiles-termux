# Use: gpg-s hi.txt

gpgs() {
    read "user_id?ID-Email: "
    gpg --local-user "$user_id" --clearsign "$1"
}

# These aren't used much. They are for exporting keys.

gpge() {
    read "user_id?ID-Email: "
    gpg --armor --export "$user_id" > key.asc
}

gpgexs() {
    read "user_id?ID-Email: "
    gpg --export-secret-keys --armor "$user_id" > private-key.asc
}
