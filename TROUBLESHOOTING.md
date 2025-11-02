# トラブルシューティング

## 問題: Ctrl-X Ctrl-O を押しても補完が表示されない

### 診断ツールを使う（推奨）

```bash
diagnose.bat
```

または

```bash
vim -u diagnose.vim
```

これで問題を特定できます。

### よくある原因と解決策

#### 1. 補完機能自体はテストで動作確認済み

自動テストを実行すると、補完機能は正常に動作します：

```bash
vim -u test_output.vim -N -n -i NONE && cat diagnostic_output.txt
```

結果:
```
✓ findstart OK
matches for 'cod': 2
✓ Got matches!
  - code-block::
  - codeauthor::
```

つまり、**機能自体は問題なし**です。

#### 2. Ctrl-X Ctrl-O の正しい押し方

多くの場合、キーの押し方が原因です：

**正しい方法:**
1. **Ctrl キーを押し続ける**
2. **Ctrl を押したまま X を押す**
3. **Ctrl を押したまま O を押す**
4. **Ctrl を離す**

**間違った方法:**
- ✗ Ctrl-X を押して、離してから Ctrl-O を押す
- ✗ Ctrl-X-O を同時に押す
- ✗ Ctrl-XO（OをCtrl押さずに）

#### 3. INSERT モードになっているか確認

補完は**INSERT モード**でのみ動作します：

- 画面下部に `-- INSERT --` または `-- 挿入 --` が表示されているか確認
- 表示されていない場合は `i` キーを押す

#### 4. カーソル位置の確認

カーソルは `.` の行にある必要があります：

```
.. cod
     ↑ カーソルはここ（dの後）
```

**正しい位置に移動する方法:**
1. NORMALモードで、該当行に移動（j, kキー）
2. `$` キーで行末に移動
3. `i` キーでINSERTモードに入る

#### 5. メッセージの確認

Vimは補完に関するメッセージを表示することがあります：

**よくあるメッセージ:**
- `-- Omni completion (^O^N^P)` = 補完モードに入った（正常）
- `Pattern not found` = マッチなし
- `Already at the only match` = 1つだけマッチ

画面下部のメッセージを確認してください。

#### 6. completeopt の設定

以下を試してください：

```vim
:set completeopt?
```

推奨設定:
```vim
:set completeopt=menuone,noinsert,noselect
```

#### 7. ファイルタイプの確認

```vim
:set filetype?
```

結果は `filetype=rst` である必要があります。

違う場合:
```vim
:setfiletype rst
```

#### 8. omnifunc の確認

```vim
:set omnifunc?
```

結果は `omnifunc=sphinx#completion#complete` である必要があります。

違う場合:
```vim
:setlocal omnifunc=sphinx#completion#complete
```

### デバッグ手順

#### ステップ1: 診断モードで確認

```bash
diagnose.bat
```

1. ファイルが開いたら SPACE キーを押す
2. 11行目 (`.. cod`) に移動
3. `A` キーを押す（行末でINSERTモードに入る）
4. 画面下部に `-- INSERT --` が表示されることを確認
5. **Ctrl を押したまま X, O と順に押す**
6. 補完メニューが表示されるか確認

表示されない場合:
7. Esc キーを押す
8. F3 キーを押して診断情報を見る
9. F4 キーを押して手動テストを実行

#### ステップ2: 最小構成でテスト

```bash
vim -u NONE -N -c "set rtp+=." -c "filetype plugin on" example.rst
```

これで開いて:
```vim
:setlocal omnifunc=sphinx#completion#complete
```

その後、補完を試す。

### よくある質問

**Q: "Pattern not found" と表示される**

A: これは以下の原因が考えられます:
- 入力した文字列にマッチするディレクティブがない
- カーソル位置が `.. ` で始まる行にない

**Q: 何も表示されない**

A: 以下を確認:
1. INSERTモードか？（画面下部確認）
2. `.. ` で始まる行か？
3. Ctrl-X Ctrl-O を正しく押したか？

**Q: メニューが一瞬表示されてすぐ消える**

A: 以下を試してください:
```vim
:set completeopt=menuone,longest
```

これでメニューが残るはずです。

### それでも動かない場合

以下の情報を添えて報告してください：

1. 診断ツールの出力（F3, F4 の結果）
2. Vimのバージョン（`:version`）
3. 実行したコマンド
4. 表示されたエラーメッセージ

診断情報を取得：
```bash
vim -u diagnose.vim
```

F3, F4 を押して情報を確認してください。
