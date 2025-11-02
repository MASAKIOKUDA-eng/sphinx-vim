# Sphinx-Vim 使用方法

## インストール方法

### 方法1: 手動インストール

```bash
# このリポジトリをVimのruntimepathにコピー
cd ~/.vim
git clone https://github.com/yourusername/sphinx-vim.git

# または、シンボリックリンクを作成
ln -s /path/to/sphinx-vim/autoload ~/.vim/autoload/sphinx
ln -s /path/to/sphinx-vim/ftplugin/rst.vim ~/.vim/ftplugin/rst.vim
```

### 方法2: プラグインマネージャーを使用

#### vim-plug
```vim
" ~/.vimrc に追加
Plug 'yourusername/sphinx-vim'
```

#### dein.vim
```vim
call dein#add('yourusername/sphinx-vim')
```

#### packer.nvim (Neovim)
```lua
use 'yourusername/sphinx-vim'
```

## 基本的な使い方

### 1. reStructuredTextファイルを開く

```bash
vim example.rst
```

または、現在のディレクトリで：
```bash
vim example.rst
```

### 2. ディレクティブを補完する

1. 新しい行で `.. ` と入力（ドット2つ + スペース）
2. ディレクティブ名の一部を入力（例: `cod`）
3. **Ctrl-X Ctrl-O** を押す（挿入モードで）
4. 補完メニューから選択

### 補完の例

```
.. cod<Ctrl-X Ctrl-O>
```
↓
```
.. code-block::
.. codeauthor::
```

```
.. not<Ctrl-X Ctrl-O>
```
↓
```
.. note::
```

### 3. 補完メニューの操作

- **Ctrl-N**: 次の候補
- **Ctrl-P**: 前の候補
- **Enter**: 選択した候補を確定
- **Ctrl-E**: 補完をキャンセル

## 利用可能なディレクティブ

55個以上のSphinxディレクティブに対応：

- **警告系**: note, warning, tip, important, caution, danger, error, hint
- **コード**: code-block, literalinclude, highlight
- **画像**: image, figure
- **テーブル**: table, csv-table, list-table
- **構造**: toctree, contents, sidebar, topic
- **バージョン情報**: versionadded, versionchanged, deprecated
- その他多数...

## トラブルシューティング

### 補完が動かない場合

1. ファイルタイプが正しく設定されているか確認：
   ```vim
   :set filetype?
   ```
   結果: `filetype=rst` であるべき

2. omnifuncが設定されているか確認：
   ```vim
   :set omnifunc?
   ```
   結果: `omnifunc=sphinx#completion#complete` であるべき

3. autoloadファイルが読み込まれているか確認：
   ```vim
   :echo exists('*sphinx#completion#complete')
   ```
   結果: `1` であるべき

### 手動でomnifuncを設定

必要であれば、.vimrcに追加：
```vim
autocmd FileType rst setlocal omnifunc=sphinx#completion#complete
```

## カスタマイズ

### 補完オプションの変更

ftplugin/rst.vimを編集して、completeoptを変更できます：

```vim
setlocal completeopt=menuone,noinsert,noselect,preview
```

### ディレクティブの追加

autoload/sphinx/completion.vimの`sphinx#completion#directives()`関数に
ディレクティブを追加できます。

## テスト方法

自動テストを実行：
```bash
vim -u run_tests.vim -N -n -i NONE
```

対話的テストを実行：
```bash
vim -u test_completion.vim
```
