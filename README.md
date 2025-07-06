# SpatialDistortion
Copyright (c) 2025, DeltaField



## Overview | 概要
Name: SpatialDistortion<br>
Version: 0.0.1-exp.1<br>

GrabPassを利用した様々な揺らぎを表現するシェーダーです。
<br>
以下の機能を特徴としています。
* 放射状に展開されるノイズをベースに、プロシージャルな空間の揺らぎを描写。
* ノイズの揺らぎに応じた色ずれの演出。
* ビルボード描写が可能。

## Requirements | 環境要件
現在、以下の環境で動作を確認しています。
* Unity 2022.3
* Built-in Render Pipeline
* Unity XR Single-pass Instanced

以下のパッケージが必要です。インストール時に自動的にインポートされます。
* [DeltaField-Shader-Commons](https://github.com/r-delta-c/DeltaField-Shader-Commons)


## Caution | 警告
* フレームバッファ等で描写されたものを、任意に歪ませる性質上、内容次第では視界への刺激が強くなるシェーダーです。<br>
特に**VR環境上**では、視認によって健康上の問題を引き起こす可能性があるため、用途に応じて描写の確認は怠らないでください。

* 加えてシェーダーの仕様上、距離に応じて描写のされ方及び歪みの強度が変動します。<br>特に**至近時に視認した場合**の見え方は慎重に検証してください。

* Stereo Merge Mode(Feature)というVR環境上での状況に応じた描写の補正も加えている点も、上記と同様ご留意ください。<br>また、このシェーダーを二次配布する場合は、上記の注意喚起を配布先にも提示することを強く推奨します。

* 動作保証外として、実際に検証ができなかった環境があります。<br>***Pimaxといったステレオ描写が特殊な機器等***<br><br>正常な動作を確認できていないため、保証はできかねます。ご了承ください。

* **当シェーダーを使用したマテリアルを複数使用、表示させる。もしくはそういった環境で使用する想定がある用途について。**<br>
当シェーダーはShaderlabの機能の一つであるGrabPassを使用していますが、仕様により上記のような状況に置いて、描写がおかしくなる場合があります。<br>
考えられる原因はシェーダー内で定義した、**GrabPass用の名称の重複**により発生する問題です。<br><br>
VRChatなどの環境では不特定多数のGrabPassの名称と競合するリスクは存在しますので、シェーダー内の特定の文字列を変更するのを推奨します。<br>
GrabPassブロック内、defineで指定する名称は***必ず同名***になるようにしてください。(末尾の_STは付与したままにしてください。)<br>

```
// 例(GrabPassブロック)
GrabPass{
    "_DELTAFIELD_GB_SPACE_DIST_777"
}

// ↓↓↓

GrabPass{
    "_WATAGASHI_KARAAGE_UNAGI"
}

// 例(define)

#define GRABPASS_ID _DELTAFIELD_GB_SPACE_DIST_777
#define GRABPASS_ID_ST _DELTAFIELD_GB_SPACE_DIST_777_ST

// ↓↓↓

#define GRABPASS_ID _WATAGASHI_KARAAGE_UNAGI
#define GRABPASS_ID_ST _WATAGASHI_KARAAGE_UNAGI_ST

```

## Installation instructions | インストール方法
### VPM - ***推奨***
[Package Listing WEB](https://r-delta-c.github.io/vpm_repository/)へ移動し、**Add to VCC**というボタンを押して、VRChat Creator Companionを開きます。<br>
リポジトリを加えましたら、導入したいプロジェクトのManage Packagesを開き、一覧に加わっているMeshHologramをインストールしてください。

### Package Manager - ***推奨***
Unityのタブメニューから、**Window -> Package Manager**を押してPackage Managerを開きます。<br>
Package Managerの左上にある**+**ボタンを押して、**Add package from git URL...**を押します。<br>
開かれた入力ダイアログに以下のリンクを張り付けて、**Add**を押して加えてください。<br>
```
https://github.com/r-delta-c/SpatialDistortion.git
```
**[Requirements | 環境要件]に前提パッケージが記載されていた場合は、先にそちらをインポートしてください。**

### .unitypackage
[リリースデータ](https://github.com/r-delta-c/SpatialDistortion/releases)から任意のバージョンを探して、Assets内の末尾が **.unitypackage**になっているデータをDLしてください。<br>
DLした.unitypackageは、起動したUnity上へ**ドラッグ&ドロップ**することでインポートできます。



## How to Use | 使い方
以下のページを参照してください。<br>
[Properties | プロパティ](https://github.com/r-delta-c/SpatialDistortion/blob/main/Documentation~/properties.md "Documentation~/properties.md")

## License | ライセンス
このシェーダーはMIT Licenseによって提供されます。
LICENSE.mdの内容に則ってご利用ください。
