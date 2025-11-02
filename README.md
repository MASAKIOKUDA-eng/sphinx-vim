# sphinx-vim

VimでSphinx reStructuredTextのディレクティブ補完を提供するプラグイン

## 🚀 今すぐ試す（最も簡単）

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

詳しくは [QUICKSTART.md](QUICKSTART.md) を参照してください。

## 🧪 テスト

```bash
# Windows
test.bat

# Mac/Linux
vim -u run_tests.vim -N -n -i NONE
```

すべてのテストが通れば、正しくインストールされています。

## 📁 ファイル構成

```
sphinx-vim/
├── autoload/sphinx/completion.vim  # 補完機能の実装
├── ftdetect/rst.vim                # reStructuredTextファイルタイプ検出
├── ftplugin/rst.vim                # reStructuredText設定
├── demo.vim                        # 対話的デモ
├── run_tests.vim                   # 自動テスト
├── example.rst                     # 使用例
├── .gitignore                      # Git除外設定
├── QUICKSTART.md                   # クイックスタートガイド
└── USAGE.md                        # 詳細な使用方法
```

## 💡 ヒント

- **補完が出ない**: `.. ` で始まる行にいることを確認
- **入力できない**: `i` キーでINSERTモードに入る
- **終了方法**: Esc → `:q` → Enter

## 📄 ライセンス

MIT License
