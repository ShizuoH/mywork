## 参照

### rosのインストール
* http://wiki.ros.org/melodic/Installation/Ubuntu
* http://www1.meijo-u.ac.jp/~kohara/cms/technicalreport/ubuntu18-04_ros_install

### rosとcarlaの連携
https://proc-cpuinfo.fixstars.com/2019/01/carla-simulator/
http://www1.meijo-u.ac.jp/~kohara/cms/technicalreport/ubuntu18-04_ros_install


### 作業ログ

1. 以下の作業にのっとって、rosをインストール(+ワークスペースの作成）
  - http://www1.meijo-u.ac.jp/~kohara/cms/technicalreport/ubuntu18-04_ros_install

1. 以下のページに沿って、まずは、manual_control.pyで動かせるところまで実現
  * https://proc-cpuinfo.fixstars.com/2019/01/carla-simulator/

#### carlaのmanual_control.pyが適切に動かなかった
* 結局、pygameのバージョンの問題だったのでpygameをpipでインストールする
  * https://github.com/carla-simulator/carla/issues/991
  * https://github.com/carla-simulator/carla/issues/2983
  1. python2のpipをインストールしていなかったので、インストール
    ```
    $ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    $ python2 get-pip.py
  ```
  1. pygameのインストール
    ```
    python2 -m pip install -U pygame --user
    ```
