# PCの設定

## emacsの設定
* 以下のページからほしいバージョンをダウンロードして、適当なディレクトリに置く。
  * https://www.gnu.org/savannah-checkouts/gnu/emacs/emacs.html
* 以下のコマンドでインストール
```
$ sudo apt-get install build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev libxpm-dev automake autoconf gnutls-bin libgnutls28-dev
$ cd [emacs dir]
$ ./configure
$ make
$ sudo make install
```

