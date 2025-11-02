# sphinx-vim

VimでSphinx reStructuredTextのディレクティブ補完を提供するプラグイン

## 🚀 今すぐ試す（インストール不要）

### Windows
```cmd
demo.bat
```

### Mac/Linux
```bash
vim -u demo.vim
```

デモが起動したら：
1. **`i` キーを押す** → 画面下部に `-- INSERT --` と表示される
2. **Ctrl-X Ctrl-O を押す** → 補完メニューが表示される
3. **↓↑ キーで選択、Enterで確定**
4. **Esc キーで終了**

## ✨ 機能

- 55個以上のSphinxディレクティブの自動補完
- `.. code-block::`, `.. note::`, `.. warning::` など
- omnifunc補完による快適な入力体験
- .rstファイルを開くだけで自動的に有効化

## 📦 インストール

### 方法1: プラグインマネージャーを使用（推奨）

#### vim-plug

`.vimrc` または `init.vim` に以下を追加：

```vim
call plug#begin()
Plug '/path/to/sphinx-vim'  " ← 実際のパスに変更
call plug#end()

filetype plugin on
```

**例**:
```vim
" Windows
Plug 'C:/Users/YourName/Documents/sphinx-vim'

" Linux/Mac
Plug '~/projects/sphinx-vim'
```

保存後、Vimを再起動して `:PlugInstall` を実行。

#### dein.vim

```vim
call dein#begin()
call dein#add('/path/to/sphinx-vim')
call dein#end()

filetype plugin on
```

#### Vundle

```vim
call vundle#begin()
Plugin 'file:///path/to/sphinx-vim'
call vundle#end()

filetype plugin on
```

### 方法2: 手動インストール（最も簡単）

`.vimrc` または `init.vim` に以下を追加：

```vim
" Vimの基本設定
set nocompatible
filetype plugin on
syntax on

" sphinx-vimをruntimepathに追加（実際のパスに変更）
set runtimepath+=/path/to/sphinx-vim
```

**例**:
```vim
" Windows
set runtimepath+=C:/Users/YourName/Documents/sphinx-vim

" Linux/Mac
set runtimepath+=~/projects/sphinx-vim
```

**重要**: `filetype plugin on` がないと、ftpluginが読み込まれず、補完が動作しません。

### 方法3: Vimのプラグインディレクトリにコピー

**Windows**:
```cmd
cd /path/to/sphinx-vim
xcopy /E /I autoload %USERPROFILE%\vimfiles\autoload
xcopy /E /I ftdetect %USERPROFILE%\vimfiles\ftdetect
xcopy /E /I ftplugin %USERPROFILE%\vimfiles\ftplugin
```

**Linux/Mac**:
```bash
cd /path/to/sphinx-vim
cp -r autoload ~/.vim/
cp -r ftdetect ~/.vim/
cp -r ftplugin ~/.vim/
```

その後、`.vimrc` に追加：
```vim
filetype plugin on
```

### .vimrc の場所

**確認方法**（Vim内で）：
```vim
:echo $MYVIMRC
```

**一般的な場所**：
- Windows: `%USERPROFILE%\_vimrc` または `%USERPROFILE%\.vimrc`
- Linux/Mac: `~/.vimrc`

何も表示されない場合は、作成します：
```cmd
# Windows
notepad %USERPROFILE%\_vimrc

# Linux/Mac
vim ~/.vimrc
```

## 📖 使い方

### 基本操作

1. `.rst` ファイルを開く
2. `.. ` と入力（ドット2つ + スペース）
3. ディレクティブ名の一部を入力（例: `cod`）
4. **Ctrl-X Ctrl-O** で補完（INSERTモードで）
5. 候補を選択して Enter

### Vimモード（重要）

- **NORMALモード**: `i` キーでINSERTモードへ
- **INSERTモード**: `Esc` キーでNORMALモードへ
- 画面下部に `-- INSERT --` が表示されているか確認！

### 補完例

```rst
.. code-block:: python

   def hello():
       print("Hello, Sphinx!")

.. note::
   これはノートです。

.. warning::
   これは警告です。
```

詳しくは [QUICKSTART.md](QUICKSTART.md) を参照してください。

## ✅ インストール確認

Vimで `.rst` ファイルを開いて、以下のコマンドを実行：

```vim
:set filetype?
```
→ `filetype=rst` と表示される

```vim
:set omnifunc?
```
→ `omnifunc=sphinx#completion#complete` と表示される

どちらも正しければ、補完が使えます！

## 🧪 テスト

```bash
# Windows
test.bat

# Mac/Linux
vim -u run_tests.vim -N -n -i NONE
```

すべてのテストが通れば、正しくインストールされています。

## 🔧 トラブルシューティング

### 「omnifuncがありません」エラーが出る

**原因**: プラグインがVimに読み込まれていない

**解決方法**:

1. `.vimrc` に `filetype plugin on` があるか確認
2. プラグインがruntimepathに含まれているか確認：
   ```vim
   :set runtimepath?
   ```
   sphinx-vimのパスが表示されるはず

3. 手動でfiletypeを設定：
   ```vim
   :set filetype=rst
   ```

4. 診断スクリプトを実行：
   ```vim
   :source check_real_environment.vim
   ```

### filetypeが自動設定されない

1. `filetype on` が設定されているか確認
2. ファイルの拡張子が `.rst` または `.rest` か確認
3. 手動でリロード：
   ```vim
   :filetype detect
   ```

### 補完メニューが表示されない

1. INSERTモードにいるか確認（画面下部に `-- INSERT --` 表示）
2. `.. ` で始まる行にいるか確認（ドット2つ + スペース）
3. カーソルがスペースの後にあるか確認

### それでも動作しない場合

1. Vimのバージョン確認：
   ```vim
   :version
   ```
   Vim 7.4以降が推奨

2. デモで動作確認：
   ```cmd
   # Windows
   demo.bat

   # Mac/Linux
   vim -u demo.vim
   ```
   デモで動けば、インストールの問題です。

3. 詳細は [TROUBLESHOOTING.md](TROUBLESHOOTING.md) を参照

## 📁 ファイル構成

```
sphinx-vim/
├── autoload/sphinx/completion.vim  # 補完機能の実装
├── ftdetect/rst.vim                # reStructuredTextファイルタイプ検出
├── ftplugin/rst.vim                # reStructuredText設定
├── demo.vim / demo.bat             # 対話的デモ
├── run_tests.vim                   # 自動テスト
├── example.rst                     # 使用例
├── .gitignore                      # Git除外設定
├── QUICKSTART.md                   # クイックスタートガイド
├── USAGE.md                        # 詳細な使用方法
└── TROUBLESHOOTING.md              # トラブルシューティング
```

## 💡 ヒント

- **補完が出ない**: `.. ` で始まる行にいることを確認
- **入力できない**: `i` キーでINSERTモードに入る
- **終了方法**: Esc → `:q` → Enter

## 🤝 コントリビューション

プルリクエストやイシューを歓迎します！

## 📄 ライセンス

MIT License
