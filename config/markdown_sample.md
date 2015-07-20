#Markdown記法について

###Kiitaで利用可能なMarkdown記法のチートシートです。

Markdown記法の原文については、[Daring Fireball: Markdown Syntax Documentation]
(http://daringfireball.net/projects/markdown/syntax.php)をご覧下さい。
また、コードに関する記法は[GitHub Flavored Markdown](http://github.github.com/github-flavored-markdown/)に準拠しています。
## Code - コードの挿入

たとえば、Rubyで記述したコードをファイル名「kiita.rb」として記録したいときは、**バッククオート**を使用して以下のように投稿するとシンタックスハイライトが適用されます。
**コードブロック上下に空行を挿入しないと正しく表示されないことがあります。**

> (空行)
> \`\`\`ruby:kiita.rb
> puts 'The best app to log and share programming knowledge.'
> \`\`\`
> (空行)

**結果**

```ruby:kiita.rb
puts 'The best app to log and share programming knowledge.'
```

また、コードをインライン表示することも可能です。

> \` puts 'kiita'` はプログラマのための知識記録サービスです。

**結果**

` puts 'kiita'` はプログラマのための知識記録サービスです。

### シンタックスハイライト可能な言語
kiitaで現在シンタックスハイライト可能な言語/ファイル形式は以下です。
基本的には上記のフォーマットに従って言語名/ファイル形式を小文字で書くと適用されますが、例外的なものについては下記の括弧で括った中の表記を利用してください。

> 例: C++のハイライト
> \`\`\`cpp
> print("hello\n");
> \`\`\`

Bash, C#(cs), C++(cpp), CSS, Diff, HTML, XML, Ini, Java, Javascript, PHP, Perl, Python, Ruby, SQL, 1C, AVR Assembler(avrasm), Apache, Axapta, CMake, DOS .bat(dos), Delphi, Django, Erlang, Erlang, REPL, Go, Haskell, Lisp, Lua, MEL, Nginx, Objective C(objectivec), Parser3, Python, profile, Scala, Smalltalk, TeX, VBScript, VHDL, Vala


## Format Text - テキストの装飾

### Headers - 見出し

* \# これはH1タグです
* \## これはH2タグです
* \###### これはH6タグです

### Emphasis - 強調

* \*これはイタリック体です*
* \_これもイタリック体です_
* _これは_イタリック体になりません
* \*\*これは太字です**
* \_\_これも太字です__

## Lists - リスト

### 順序なしリスト

* 文頭に「*」「+」「-」のいずれかを入れると順序なしリストになります
* 要点をまとめる際に便利です
* リストを挿入する際は、**リストの上下に空行がないと正しく表示されません**

### 順序つきリスト

1.  文頭に「数字.」を入れると順序つきリストになります
2.  1.2.3.と入れていくといい具合です
3.  リストを挿入する際は、**リストの上下に空行がないと正しく表示されません**

## Blockquotes - 引用

> \> 文頭に>を置くことで引用になります。
> \> 複数行にまたがる場合、改行のたびにこの記号を置く必要があります。
> \> **引用の上下にはリストと同じく空行がないと正しく表示されません**
> \> 引用の中に別のMarkdownを使用することも可能です。

> > これはネストされた引用です。

## Horizontal rules - 水平線

下記は全て水平線として表示されます

> \* * *
> \***
> \*****
> \- - -
> \---------------------------------------

## Links - リンク

* \[リンクテキスト](URL "タイトル") 
    * タイトル付きのリンクを投稿できます。

**例**

> *Markdown:* \[Qiita]\(http://qiita.com "Qiita")
> *結果:* [Qiita](http://qiita.com "Qiita")

* \[リンクテキスト](URL) 
    * こちらはタイトル無しのリンクになります。

**例**

> *Markdown:* \[Qiita]\(http://qiita.com)
> *結果:* [Qiita](http://qiita.com)

## Images - 画像埋め込み

* \![代替テキスト]\(画像のURL)
    * タイトル無しの画像を埋め込む
* \![代替テキスト]\(画像のURL "画像タイトル")
    * タイトル有りの画像を埋め込む

**例**

> *Markdown:* \![Qiita]\(http://qiita.com/favicon.png "Qiita")
> *結果:*
> ![Qiita](http://qiita.com/favicon.png "Qiita")

## Tables - テーブル
```
| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       |        This |     This     |
| column     |      column |    column    |
| will       |        will |     will     |
| be         |          be |      be      |
| left       |       right |    center    |
| aligned    |     aligned |   aligned    |
```

上記のように書くと、以下のように表示されます。

| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       |        This |     This     |
| column     |      column |    column    |
| will       |        will |     will     |
| be         |          be |      be      |
| left       |       right |    center    |
| aligned    |     aligned |   aligned    |

## その他

バックスラッシュ[\\]をMarkdownの前に挿入することで、Markdownをエスケープ(無効化)することができます。

**例**

> \# H1
> エスケープされています
