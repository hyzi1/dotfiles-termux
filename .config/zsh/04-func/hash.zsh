# Quickly create and compare hashes.

# Use: sh2 backup.tar

sh2() {
  sha256sum "$1" > "${1}.sha256"
  sha512sum "$1" > "${1}.sha512"
}

sh1() {
  sha1sum "$1" > "${1}.sha1"
  md5sum "$1" > "${1}.md5"
}

# This is for comparing hashes quickly, without the need for specifying anything.
sum-a() {
    setopt local_options null_glob

    for f in *.md5; do
        [[ -f "$f" ]] && md5sum -c "$f"
    done

    for f in *.sha1; do
        [[ -f "$f" ]] && sha1sum -c "$f"
    done

    for f in *.sha256; do
        [[ -f "$f" ]] && sha256sum -c "$f"
    done

    for f in *.sha512; do
        [[ -f "$f" ]] && sha512sum -c "$f"
    done

    for f in *.b3; do
        [[ -f "$f" ]] && b3sum -c "$f"
    done
}
