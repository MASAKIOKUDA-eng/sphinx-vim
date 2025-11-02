# セットアップ方法（実環境で使う）

## 現在の状態

「omnifuncがありません」というエラーが出る理由：
- プラグインが正しく動作していない（×）
- プラグインがVimに読み込まれていない（○）← これが原因

## すぐに試す（インストール不要）

### 方法1: テストスクリプトを使う

```cmd
cd C:\Users\inuin\OneDrive\ドキュメント\GitHub\sphinx-vim
QUICK_START_REAL.bat
```

または

```cmd
cd C:\Users\inuin\OneDrive\ドキュメント\GitHub\sphinx-vim
vim -u test_insert_mode.vim
```

Vimが開いたら：
1. **`i`** を押してINSERTモードに入る
2. 6行目（`.. ` の行）に移動
3. **`A`** で行末へ
4. **`Ctrl-X`** を押す
5. **`Ctrl-O`** を押す
6. 補完メニューが表示される！

### 方法2: 最小設定で起動

```cmd
vim -u NONE -c "set rtp+=C:/Users/inuin/OneDrive/ドキュメント/GitHub/sphinx-vim" -c "filetype plugin on" test.rst
```

Vim内で：
```vim
:set filetype=rst
```

その後、上記の手順で補完を試す。

## 恒久的にインストール（毎回使えるようにする）

### Windows (.vimrc の場所)

Vimの設定ファイルは以下のいずれか：
- `C:\Users\inuin\_vimrc`
- `C:\Users\inuin\.vimrc`
- `%USERPROFILE%\_vimrc`

**確認方法**（Vim内で）：
```vim
:echo $MYVIMRC
```

### 設定内容

`_vimrc` または `.vimrc` に以下を追加：

```vim
" Vimの基本設定
set nocompatible
filetype plugin on
syntax on

" sphinx-vim を読み込む
set runtimepath+=C:/Users/inuin/OneDrive/ドキュメント/GitHub/sphinx-vim
```

**重要**: パスは環境に合わせて変更してください。

### 設定を反映

1. Vimを完全に終了
2. 再起動
3. `.rst` ファイルを開く

これで自動的に補完が使えます！

## 動作確認

Vimで `.rst` ファイルを開いて：

```vim
:set filetype?
```
→ `filetype=rst` と表示される

```vim
:set omnifunc?
```
→ `omnifunc=sphinx#completion#complete` と表示される

どちらも正しければ、補完が使えます！

## トラブルシューティング

### まだ「omnifuncがありません」が出る

1. **確認**: `.vimrc` を作成・編集しましたか？
2. **確認**: Vimを再起動しましたか？
3. **確認**: ファイルの拡張子は `.rst` ですか？

### filetypeが自動設定されない

Vim内で手動で設定：
```vim
:set filetype=rst
```

その後は補完が使えるはずです。

### .vimrc がどこにあるかわからない

Vim内で実行：
```vim
:echo $MYVIMRC
```

何も表示されない場合は、作成します：
```cmd
notepad %USERPROFILE%\_vimrc
```

上記の設定内容を貼り付けて保存。

## 最も簡単な.vimrc

以下をコピー＆ペーストするだけ：

```vim
set nocompatible
filetype plugin on
syntax on
set runtimepath+=C:/Users/inuin/OneDrive/ドキュメント/GitHub/sphinx-vim
```

これだけで動きます！

---

**補足**: テストスクリプト（`test_insert_mode.vim`）では正常に動作することが確認できています。通常のVimで動かないのは、プラグインが読み込まれていないだけです。上記の設定を行えば、問題なく使えます。
