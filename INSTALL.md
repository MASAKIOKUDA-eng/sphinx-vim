# インストール方法

sphinx-vimを使用するには、プラグインをVimのruntimepathに追加する必要があります。

## 方法1: プラグインマネージャーを使用（推奨）

### vim-plug

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

### dein.vim

```vim
call dein#begin()
call dein#add('/path/to/sphinx-vim')  " ← 実際のパスに変更
call dein#end()

filetype plugin on
```

### Vundle

```vim
call vundle#begin()
Plugin 'file:///path/to/sphinx-vim'  " ← 実際のパスに変更
call vundle#end()

filetype plugin on
```

## 方法2: 手動インストール

`.vimrc` または `init.vim` に以下を追加：

```vim
" sphinx-vimをruntimepathに追加（実際のパスに変更）
set runtimepath+=/path/to/sphinx-vim

" filetypeプラグインを有効化（必須）
filetype plugin on
```

**例**:
```vim
" Windows
set runtimepath+=C:/Users/YourName/Documents/sphinx-vim

" Linux/Mac
set runtimepath+=~/projects/sphinx-vim
```

**重要**: `filetype plugin on` がないと、ftpluginが読み込まれず、omnifuncが設定されません。

## 方法3: Vimのプラグインディレクトリにコピー

プラグインディレクトリにファイルを直接コピーします。

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

## インストール確認

1. Vimを再起動
2. `.rst` ファイルを開く（または新規作成）
3. 以下のコマンドで確認：

```vim
:set filetype?
" → 'filetype=rst' と表示されるはず

:set omnifunc?
" → 'omnifunc=sphinx#completion#complete' と表示されるはず
```

## トラブルシューティング

### 「omnifuncがありません」エラーが出る

**原因**: ftpluginが実行されていない

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

ftdetect が動作していません。以下を確認：

1. `filetype on` が設定されているか
2. ファイルの拡張子が `.rst` または `.rest` か
3. 手動でリロード：
   ```vim
   :filetype detect
   ```

### それでも動作しない場合

1. Vimのバージョン確認：
   ```vim
   :version
   ```
   Vim 7.4以降が必要

2. 診断スクリプトを実行：
   ```vim
   :edit test.rst
   :source check_real_environment.vim
   ```

3. デモで動作確認：
   ```cmd
   vim -u demo.vim
   ```

## 最小設定例

以下を `.vimrc` に追加すれば動作します：

```vim
" Vimの基本設定
set nocompatible
filetype plugin on
syntax on

" sphinx-vimのパスを追加（実際のパスに変更）
set runtimepath+=C:/Users/inuin/OneDrive/ドキュメント/GitHub/sphinx-vim
```

保存後、Vimを再起動して `.rst` ファイルを開けば補完が使えます。
