## マスタリングTCP/IP 入門編

### 第一章　ネットワーク基礎知識

* LAN < (MAN) < WAN

* 流れ

|年代|内容|
|---|---|
|1950年代|バッチ処理(FOTRANとか)|
|1960年代|タイムシェアリングシステム（TSS)|
|1970年代|コンピュータ間通信|
|1980年代|コンピュータネットワーク|
|1990年代|インターネット普及|
|2000年代|インターネット技術中心|
|2010年代|いつでもどこでも何にでもTCP/IPネットワーク|

* メインフレーム＞ワークステーション

* IT, ICT, OT
  * Information Technology
  * Information and Communication Technology
  * Operaional Technology

* TCP/IPはISOの国際標準ではない
  * IETF(Internet Engineering Task Force)の標準化作業

* プロトコルの階層化とOSI参照モデル(これはISO提唱)

|階層|階層名|例|
|---|---|---|
|7|アプリケーション層|e-mailとか|
|6|プレゼンテーション層|データフォーマット|
|5|セッション層|コネクションの確率切断|
|4|トランスポート層|両端のノード間で行う確実にデータを届ける役割|
|3|ネットワーク層|ルータ(IP)|
|2|データリンク層|端末間のデータ通信、スイッチングハブもここ|
|1|物理層|光ケーブル、無線|

* ユニキャスト、ブロードキャスト、マルチキャスト、エニーキャスト

* macアドレスはユニークだが階層性がない
* IPアドレスは階層性がある
  * ネットワーク部、ホスト部
* IPでは、経路制御表（ルーティングテーブル）を覚えておいてどこに送信するか決める
* MACアドレスでは、転送表（フォワーディングテーブル）

* ゲートウェイ
  * proxyサーバも一種のゲートウェイ
  * ルーターのことを慣例的にゲートウェイというが、トランスポート層以上の層でプロトコル変換を行うことものをゲートウェという
  
* ネットワーク構成
  * コア（バックボーン）＞エッジ＞アクセス（アグリゲーション）＞各家庭のルーター

* LTE(3.5G),LTE-Advance(4G),5G

* SDx
  * Software Designed (anything)

### 第二章：TCP/IP 基礎知識

#### keyword
* TCP (Transmission Control Protocol)
* IP (Internet Protocol)
* RFC (Request For Comments)
* NOC (同一ネットワーク内で、ハブとなり階層を一つあげるポイント）
* IX (ネットワークの運用者や運用方針が異なるネットワークのブリッジ)
* ISP (Internet Service Provider)
* ICMP (Internet Control Message Protocol)
* ARP (Address Resolution Protocol)
  * IPアドレスからMACアドレスを取得するプロトコル
* SMTP (Simple Mail Transfer Protocol)
* SNMP (Simple Network Management Protocol)

#### 2.2 TCP/IPの標準化
* TCP/IPという言葉は単にTCPとIPの２つのプロトコルだけでなく、ICMPやTCP,UDP,TELNET,FTP,HTTPなどの、インターネット・プロトコル群を指す
* TCP/IPは標準化の精神で作られている
  * さらにTCP/IPは実用性が高いプロトコルに仕上がっている
  * OSIが普及しなかったのは、動作するプロトコルをすぐに作れなかったことと、急速な変化に対応できるようなプロトコルの改良を行える仕組みがなかったことが原因と言われている
* 各プロトコルが、STD,RFCの番号で管理されていることは知っておく
  * STDがプロトコルに対する仕様、RFCは各変更時の変更仕様
  
#### 2.4 TCP/IPの階層モデル

* ハードウェア,ネットワークインタヘース層,インターネット層,トランスポート層,アプリケーション層
* インターネット層
  * IP, ICMP, ARP
* トランスポート層
  * TCP, UDP
    * TCPはコネクション型、UDPはコネクションレス型
* アプリケーション層
  * Webアクセス(www), HTTP, HTML, SMTP, TELNET, SSH, FTP, SNMP

#### 2.5 TCP/IPの階層モデルと通信例

* データリンク層(イーサネットヘッダ)
  * 宛先MACアドレス
  * 送信元MAXアドレス
  * イーサネットタイプ
* ネットワーク層(IPヘッダ)
  * 送信元IPアドレス
  * 宛先IPアドレス
  * プロトコルタイプ
* トランスポート層(TCP/UDPヘッダ)
  * 送信元ポート番号
  * 宛先ポート番号
* データ
* データリンク層(イーサネットトレイラ）
  * FCS


