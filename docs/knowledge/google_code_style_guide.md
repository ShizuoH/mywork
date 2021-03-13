# Google C++ スタイルガイドチートシート

## はじめに（引用）
* https://cpprefjp.github.io
  * C++の説明など
* https://www.gocca.work/cpp-simple-factory-method/

## Contents

### ヘッダファイル
* 原則的に、全ての.ccファイルは関連付く.hファイルを持つようにする。
  * ユニットテストやmainは例外

#### 自己完結型ヘッダー
* ヘッダファイルではない、includeして使われるべきものは.incで終わるようにしますが、なるべく使用は控える

#### インクルードガード
* 個人的な見解として、#pragma onceでよい

#### 前方宣言
* 可能な限り避ける

#### インライン関数
* 経験的なルールとして、関数が10行より多くなったらインライン化すべきでない
* ループやswitchがある時点でインラインの効果は薄れる

#### インクルードの名前と順序
```
#include "foo/server/fooserver.h"

#include <sys/types.h>
#include <unistd.h>
#include <vector>

#include "base/basictypes.h"
#include "base/commandlineflags.h"
#include "foo/server/bar.h"
```

### スコープ
#### 名前空間
```
// .h ファイル
namespace mynamespace {

// すべての宣言は名前空間のスコープに含めます。
// インデントはしません。
class MyClass {
 public:
  ...
  void Foo();
};

}  // namespace mynamespace
```
```
// .ccファイル
namespace mynamespace {

// 関数の定義は名前空間に含めます。
void MyClass::Foo() {
  ...
}

}  // namespace mynamespace
```
* using namepsace foo は使わない。
* インライン名前空間は使わない。
* 名前空間名はすべて小文字。

#### 無名名前空間と静的変数
* .ccファイル内の定義は原則無名の名前空間内で宣言する(staticとほぼ同義）
* C++ において static は 様々な意味を持つ。
宣言に内部リンケージを持たせる場合は、 static ではなく無名名前空間を使う。


#### メンバではない関数、静的メンバ関数、グローバル関数
* メンバではない関数はいずれかの名前空間内におく。完全なグローバル関数は原則不可。

#### ローカル変数
* スコープは狭くする
* 可能な限り、宣言と同時に初期化する。{}による初期化をうまく使う。
```
std::vector<int> v = {1, 2};
```

#### 静的変数とグローバル変数
* 静的ストレージのオブジェクトは「トリビアルに破棄可能」でない限り、禁止
* 「トリビアルに破棄可能」とは、ユーザー定義されないデストラクタを持っているということを意味する。
* 静的ストレージとも呼ばれるstaticストレージの有効期間(static storage duration)は、
staticキーワードをつけて宣言したローカル変数やデータメンバー、
thread_localをつけずに宣言した名前空間スコープの変数などが該当する。
* 静的変数の初期化は可能な限りconstexpr。

#### thread_local Variables
* スレッドストレージの有効期間(thread storage duration)は、
thread_localキーワードをつけて宣言した変数が該当する。
この変数は、スレッドごとに異なるオブジェクトが割り当てられる。

### Common patterns
* TBD

### thread_local Variables
* TBD

### クラス
* コンストラクタで仮想メンバ関数をコールしない
* 失敗するかもしれない初期化処理はしない
  * Init()メソッドの導入を検討する

#### 暗黙的型変換

* 1つの引数をとるコンストラクタにはexplictをつけて、暗黙的型変換を禁止する
  * 1つの引数では呼び出せないコンストラクタにおいては、explicitを省略できる。 
  * 1つのstd::initializer_list型の引数をとるコンストラクタについも、
  コピーによる初期化(例: MyType m = {1, 2};)をサポートするためにexplicitを省略できる。

#### コピー可能な型・ムーブ可能な型
* 公開APIとしてのクラスは、そのクラスがコピー可能なのか、ムーブしかできないのか、
コピーもムーブもできないのか、明示されているべき。
* TBD

#### 構造体かクラスか
* 基本classを使う
* structは、データを運ぶためだけの受け身的なオブジェクトに使う

#### 継承
* 継承より抱合(コンポジション)の方が適切な場合も多い
* TBD（理解できるまで、継承の仕様は注意）

#### 演算子のオーバーロード
* ユーザ定義のリテラルは作ってはいけない
  * TBDだが、以下を見る限り、ユーザ定義のリテラルは不要
    * https://cpprefjp.github.io/lang/cpp11/user_defined_literals.html
    
#### アクセス制限
* クラスのデータメンバーは基本、private。
* static constなものはpublicでよい
* Google Testを使う場合は、protectedでよい
  * TBD(おそらく継承してテストする？）
  
#### 宣言の順序  
* public: protected: private: の順。空になるセクションは省略。
* 似た宣言はまとめる。
* 型(typedef、using、内部構造体・クラスを含む)、定数、ファクトリ関数、コンストラクタ、代入演算子、デストラクタ、それ以外のすべてのメソッド、データメンバ の順
  * ファクトリ関数とは、サブクラス（子クラス）のオブジェクトを生成し、それを指し示すスーパークラス（親クラス）のポインタを返す関数。
  * つまり、スーパークラスを強制的に返して、スーパークラスをベースにサブクラスに応じた振る舞いを行うこと（ポリモーフィズム）を意識させるための関数。

### 関数

#### 出力用の引数
* 出力用引数よりも戻り値を使用すべき。
* 出力のみの引数を用いる場合は、入力引数よりも後に並べる。
* 入力用の引数は、通常、値であるかconst参照であるのに対して、出力用・入出力用の引数は非constへのポインタ。

#### 関数は短く
* 目安は40行程度

#### 参照渡し
* 入力は基本的に、const T&
* const T* は明示的な理由が必要

#### 関数のオーバーロード
* コードの読者が、その呼び出し元を読んだときに、具体的にどのオーバーロードが呼び出されるか正確に把握していなくとも、何が起こるか理解できるであろう場合にのみ使用できる

#### 引数のデフォルト値
* 仮想関数では使わない

#### 戻り値の型を後置する関数宣言構文
* 以下の構文
```
auto foo(int x) -> int;
```
* 以下ような場合に限られる
  * 通常の構文（難解）
```
template <typename T, typename U>
decltype(declval<T&>() + declval<U&>()) add(T t, U u);
```
  * 戻り値の型を後置する関数宣言構文
```
template <typename T, typename U>
auto add(T t, U u) -> decltype(t + u);
````

### Google特有のマジック

#### スマートポインタの所有権
* TBD

#### cpplint
* スタイルをちぇっくしてくれるpythonファイル

### その他のC++の機能
#### 右辺値参照
* 右辺値参照は、ムーブコンストラクタ・ムーブ代入演算子(詳細はコピー可能な型・ムーブ可能な型)を定義するために使用
* めったに使わないはずなので、使うときは

#### フレンド
* クラスのフレンドは同じファイル内に定義する
* クラスのユニットテストを行う別のクラスがフレンドに指定されていると便利な場合もある

#### 例外
* 基本的にGOTOと同じで、処理フローがどうなるかわからなくなるので、throwはしない

#### noexcept
* TBD

#### 実行時型情報(RTTI)
* 実行時型情報によって、実行時にオブジェクトの型を調べられる。typeidやdynamic_castを使う。
しかし、基本的に使わない。

#### キャスト
* OK
```
static_cast<float>(double_value)
int64 y = int64{1} << 42
```
* NG
```
int y = (int)x
int y = int(x)
```

#### ストリーム
* ストリームにおける<<のオーバーロードは、値を表す型に対してその値を出力するだけの実装とする
  * <<がヒューマンリーダブルな文字列を出力する場合のみに限定する

#### 前置インクリメントと前置デクリメント
* 基本は、前置インクリメント

#### constの使い方
* 原則constでよければ、常にconstを使う
* constexprと使い分ける
* constを前置するほうが、おそらく可読性が高い

#### constexprの使い方
* 真の定数を決めるときや、関数が真の定数の定義をサポートするときは、constexprを使用する
* constexprを使いたいがためだけに、関数定義を複雑化させるのはNG
* インライン化を強制する目的ではconstexprを使用してはいけない

#### 整数型
* 基本int
* 整数型のサイズを保証する必要がある場合は、shortやunsigned long long等ではなく、常にint16_tやuint64_tを優先する

##### unsignedな整数
* unsignedな整数の演算は、単純な整数の演算とは異なり、
合同算術によって定義され(オーバーフロー・アンダーフロー時に周回する)るが、 
このことがコンパイラに検出できない大きなバグのカテゴリを生み出す可能性がある
* コンテナについては、sizeとポインタではなく、イテレータを使う
* signed整数とunsigned整数を混ぜて使わない
* 変数が非負であることを表すためだけにunsigned型を使ってはいけない

#### 64ビットへの移植性
* TBD

#### プリプロセッサマクロ
* .hファイルでは、マクロを定義しない
* マクロは使う直前に#defineし、使い終わったらすぐに#undef
  * 既存のマクロを自分のものに置き換えるために、#undefしてはいけない。ユニークな名前をつける。
* C++の偏った構造を拡張するためにマクロを使わない。あるいは、少なくとも、その挙動について十分なドキュメント化を行う。
* 関数名やクラス名、変数名を生成するために##を使わない

#### 0とnullptrとNULL
* 整数には0、実数には0.0、ポインタにはnullptr、文字には'\0'を使う。

#### sizeof
* sizeof(型)よりもsizeof(変数名)を優先する

#### auto
* 型名を明示することで可読性が向上する場合は、従来通り、型の名前を明示して宣言を行う
* 型の名前が騒がしい場合や、明確な場合、重要でない場合(＝型の名前が読者の理解の役に立たない場合)はautoを使う

#### 波括弧による初期化子リスト
* 以下のように使える
```
std::vector<string> v = {"foo", "bar"};
std::map<int, string> m = {{1, "one"}, {2, "2"}};
std::vector<int> test_function() { return {1, 2, 3}; }
for (int i : {-1, -2, -3}) {}
```
#### ラムダ式
* TBD

#### テンプレートメタプログラミング
* TBD

#### boost
* boostのうち、あらかじめ認められたライブラリのみを使用する
* boostの例
  * TBD
  
#### std::hash
* すでに使えるようになっている型に対してstd::hashを使うのはOK。
* 新しい型をサポートするためにstd::hashの特殊化を定義するのはNG。

#### C++11
* TBD

#### 非標準の拡張
* 使わない
* 例えば、以下の機能
```
GCCの__attribute__や、__builtin_prefetchのようなintrinsic関数、Foo f = {.field = 3}のようなdesignated initializer、インラインアセンブリ、__COUNTER__、__PRETTY_FUNCTION__、foo = ({ int x; Bar(&x); x })のようなcompound statement expression、可変長配列とalloca()、「エルビス演算子」a?:bなど以下のようなもの
```
#### エイリアス
* 以下、例
```
typedef Foo Bar;
using Bar = Foo;
using other_namespace::Foo;
```
* 新しいコードにおいては、typedefよりもusingを使う
* 実装においてタイピングする文字の数を減らすためにpublicなAPIとしてエイリアスを配置してはいけない
* .cc内であれば以下はOK
```
using foo::Bar;
```

### 命名規則
#### 全般的な命名規則
* OK
```
int price_count_reader;    // 省略されていないのでOK
int num_errors;            // 「num」は広く行き渡った省略系なのでOK
int num_dns_connections;   // 多くの人は「DNS」の意味を知っているからOK
```
* NG
```
int n;                     // 変数の目的がわからないのでダメ.
int nerr;                  // 曖昧な省略形なのでダメ
int n_comp_conns;          // 曖昧な省略形なのでダメ
int wgc_connections;       // グループ内のメンバーしか「wgc」の意味がわからないのでダメ
int pc_reader;             // 「pc」にはたくさんの意味があるのでダメ
int cstmr_id;              // 文字を削っているのでダメ
```
#### ファイル名
* ファイル名はすべて小文字で、アンダースコア(\_)とダッシュ(-)を含むことができが基本はアンダースコア。
```
my_useful_class.cc
my-useful-class.cc
myusefulclass.cc
myusefulclass_test.cc // _unittest や _regtest は廃止
```
* C++のファイルは.ccで終わり、ヘッダは.hで終わる

#### 型名
* 型の名前は大文字で始まり、単語の区切りごとに大文字にする。たとえば、MyExcitingClass、MyExcitingEnum。
* 型(クラス、構造体、型のエイリアス、列挙型、テンプレート引数)の名前はすべて同じ命名規則に従う。

#### 変数名
* 変数名(関数の引数も含む)や、データメンバ名は、小文字で始め単語の間にアンダースコアを使う。
* クラス(構造体は含まず)のデータメンバは、末尾にアンダースコアをつける。
* 構造体のデータメンバは、末尾にアンダースコアをつけない。

#### 定数名
* constexprあるいはconstとして宣言され、プログラムの始めから終わりまで値が変わらない変数は、頭に「k」を付けて、大文字小文字を織り交ぜて宣言する。
* 大文字化できない一部のケースにおいては、アンダースコアを用いることができます。 
* 以下に例
```
const int kAndroid8_0_0 = 24;  // Android 8.0.0
```
* 静的な記憶域期間を持つ変数(つまり、静的変数やグローバル変数。詳細はStorage Durationを参照)は、この方法で命名する。

#### 関数名
* 通常の関数は、大文字小文字を織り交ぜて命名する
* アクセッサ(Getter)やミューテータ(Setter)は変数名のように名前を付けてもよい。

#### 名前空間の名前
* 名前空間名はすべて小文字にする。

#### 列挙型の名前
* 列挙型(スコープ内のもそうでないものも)は、定数(kEnumName)かマクロ(ENUM_NAME)のどちらかのルールに従う。
* 新しいコードは基本定数(kEnumName)のルールに従う
* 以下例
```
enum UrlTableErrors {
  kOK = 0,
  kErrorOutOfMemory,
  kErrorMalformedInput,
};
```

#### マクロ名
```
#define ROUND(x) ...
```

#### 命名規則の例外
* 既存のルールに従う

### コメント
* TBD

### コードのフォーマット
#### 行の長さ
* 最大80文字

#### 非アスキー文字
* ascii推奨
* UTF-8で

#### スペースか、タブか
* スペースのみを使用。インデント1つにつき、スペースは2つ。

#### 関数宣言と関数定義
* 以下参照
```
ReturnType ClassName::FunctionName(Type par_name1, Type par_name2) {
  DoSomething();
  ...
}

ReturnType ClassName::ReallyLongFunctionName(Type par_name1, Type par_name2,
                                             Type par_name3) {
  DoSomething();
  ...
}

ReturnType LongClassName::ReallyReallyReallyLongFunctionName(
    Type par_name1,  // インデントはスペース 4個
    Type par_name2,
    Type par_name3) {
  DoSomething();  // インデントはスペース 2個
  ...
}
```
* 使われない引数でも、意味が明らかでない場合は、関数定義の引数名をコメントアウトする。
```
class Shape {
 public:
  virtual void Rotate(double radians) = 0;
};

class Circle : public Shape {
 public:
  void Rotate(double radians) override;
};

void Circle::Rotate(double /*radians*/) {}
```

#### ラムダ式
```
int x = 0;
auto x_plus_n = [&x](int n) -> int { return x + n; }
```

#### 関数呼び出し
* 以下参照
```
bool result = DoSomething(argument1, argument2, argument3);

bool result = DoSomething(averyveryveryverylongargument1,
                          argument2, argument3);
                          
if (...) {
  ...
  ...
  if (...) {
    bool result = DoSomething(
        argument1, argument2,  // スペース4つでインデント
        argument3, argument4);
    ...
  }

// ウィジェットを3x3行列で変形する
my_widget.Transform(x1, x2, x3,
                    y1, y2, y3,
                    z1, z2, z3);
```

#### 波カッコによる初期化子リスト
* 関数呼び出しと同じフォーマット

#### 条件文
* ifについては以下の通り
```
if (condition) {  // 丸カッコの中にはスペースを入れない。
  ...  // スペース2つでインデント
} else if (...) {  // elseは、閉じ波カッコと同じ行におく。
  ...
} else {
  ...
}
```
#### ループとswitch文
* switch文は以下のフォーマット
```
switch (var) {
  case 0: {  // スペース2つでインデント
    ...      // スペース4つでインデント
    break;
  }
  case 1: {
    ...
    break;
  }
  default: {
    assert(false);
  }
}
```
* caseのfall-throughにはABSL_FALLTHROUGH_INTENDED(defined in absl/base/macros.h)を使う
```
switch (x) {
  case 41:  // No annotation needed here.
  case 43:
    if (dont_be_picky) {
      // Use this instead of or along with annotations in comments.
      ABSL_FALLTHROUGH_INTENDED;
    } else {
      CloseButNoCigar();
      break;
    }
  case 42:
    DoSomethingSpecial();
    ABSL_FALLTHROUGH_INTENDED;
  default:
    DoSomethingGeneric();
    break;
}
```
* for文は波かっこはつけてもつけなくてもよいが、（個人的に）つける
```
for (int i = 0; i < kSomeNumber; ++i) {
  printf("I take it back\n");
}
```
* ループ本体が空の場合
  * OK
```
  while (condition) {
  // falseが変えるまでテストを続ける。
}
for (int i = 0; i < kSomeNumber; ++i) {}  // OK。新しい1行でもOK。
while (condition) continue;  // OK。continueで、ロジックがないことを示す。
```
  * NG
```
while (condition);  // ダメ。do-whileループの一部に見える。
```

#### ポインタと参照の表現
* 変数の複数宣言は、それらの中に1つでもポインタや参照が含まれる場合はNG

#### ブーリアンの表現
* &&や||などは行末が一般的

#### 戻り値
* 不必要に丸カッコで囲まない

#### 変数と配列の初期化
* =か、()か、{}のどれでもOK。
* 例えば、std::vectorのときは挙動が違う
```
std::vector<int> v(100, 1);  // 中身は「1」が100個。
std::vector<int> v{100, 1};  // 中身は「100」と「1」の2個。
```

#### プリプロセッサディレクティブ
* たとえプリプロセッサディレクティブをインデントされているコードの中に書く場合であっても、ディレクティブは行頭に記述する

#### クラスのフォーマット
```
class MyClass : public OtherClass {
 public:      // スペース1つでインデント！
  MyClass();  // スペース2つでインデント(いつもの)
  explicit MyClass(int var);
  ~MyClass() {}

  void SomeFunction();
  void SomeFunctionThatDoesNothing() {
  }

  void set_some_var(int var) { some_var_ = var; }
  int some_var() const { return some_var_; }

 private:
  bool SomeInternalFunction();

  int some_var_;
  int some_other_var_;
};
```
#### コンストラクタの初期化子リスト
```
// 1行にすべて収まるとき
MyClass::MyClass(int var) : some_var_(var) {
  DoSomething();
}

// 1行に収まらない場合は、コロンの手前で行を区切り、
// スペース4つでインデントしなくてはならない。
MyClass::MyClass(int var)
    : some_var_(var), some_other_var_(var + 1) {
  DoSomething();
}

// 初期化子リストが複数に分かれる場合は、
// 各変数ごとに1行を使うようにし、それらを整列させる。
MyClass::MyClass(int var)
    : some_var_(var),             // スペース4つでインデント。
      some_other_var_(var + 1) {  // 行頭は揃える。
  DoSomething();
}

// 他のコードブロックと同様に、1行に収まる場合は
// 閉じ波カッコと開き波カッコとを同じ行においてもよい。
MyClass::MyClass(int var)
    : some_var_(var) {}
```

#### 名前空間のフォーマット
* 名前空間内の内容はインデントしない
* ネストされた名前空間を宣言するときは、各名前空間ごとに別の行にわける。
```
namespace {

void foo() {  // 正しい。名前空間ではインデントしない。
  ...
}

}  // namespace
```

#### 水平方向の空白
##### 全般
```
void f(bool b) {  // 開き波カッコの前には常にスペースをおく。
  ...

int i = 0;  // セミコロンの前にスペースはおかない。

// 波カッコ初期化子リストの内側はスペースはおいてもおかなくてもよい。
// ただし、スペースをいれる場合は必ず左右の両方におく。
int x[] = { 0 };
int x[] = {0};

// 継承や初期化子のコロンの前後にはスペースをおく。
class Foo : public Bar {
 public:
  // インライン関数の実装において、波カッコと実装の間にはスペースをおく。
  Foo(int b) : Bar(), baz_(b) {}  // 空の実装にはスペースをおかない。
  void Reset() { baz_ = 0; }  // 波カッコと実装との間にはスペースをおく。
  ...
```
##### ループと条件式
```
if (b) {          // 条件文やループキーワードの後ろにはスペースをおく。
} else {          // elseの前後にはスペースをおく。
}
while (test) {}   // 丸カッコの内側には通常はスペースをおかない。
switch (i) {
for (int i = 0; i < 5; ++i) {

// ループ文と条件式の丸カッコの内側には、スペースをおいてもかまわないが、
// そのようなケースはほとんどない。周りとの一貫性を保つこと。
switch ( i ) {
if ( test ) {
for ( int i = 0; i < 5; ++i ) {

// ループでは、常にセミコロンの後にスペースをおく。
// セミコロンの前にもスペースをおいてもかまわないが、
// そのようなケースもまたほとんどない。
for ( ; i < 5 ; ++i) {
  ...

// レンジベースのループでは、常にコロンの前後にスペースをおく。
for (auto x : counts) {
  ...
}
switch (i) {
  case 1:         // caseのコロンの前にはスペースをおかない。
    ...
  case 2: break;  // コロンの後ろにコードがある場合はスペースをおく。
```

##### 演算子
```
// 代入演算子の前後には常にスペースをおく。
x = 0;

// その他の二項演算子の前後には、通常はスペースをおくが、
// 項の前後のスペースは、適宜削除してもかまわない。
// 丸カッコを使う場合は、その内側にはスペースをおくべきでない。
v = w * x + y / z;
v = w*x + y/z;
v = w * (x + z);

// 単項演算子においては、その引数との間にスペースはおかない。
x = -5;
++x;
if (x && !y)
  ...
```

##### テンプレートとキャスト
```
// 山括弧の内側(< and >)にはスペースをおかない。
// キャストにおける<の前や、>と(との間にもスペースをおかない。
std::vector<string> x;
y = static_cast<char*>(x);
```

#### 垂直方向の空白
* 垂直方向の空白は最低限
* 関数と関数との間の空行は1行か2行
* 基本的な原則は「より多くのコードが1画面内に収まるようにすれば、
プログラムのコントロールフローが追いかけやすく理解しやすくなる」というもの
