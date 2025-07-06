# Properties | プロパティ
SpatialDistortionのプロパティ解説です。<br>
(独自のプロパティ以外の解説は省略します。)


## Rendering
|Property|Description|
|:--|:--|
|Culling Mode|カリングの方法を指定するプロパティです。<br>`None` \| ポリゴンの両面を描写します。<br>`Back` \| ポリゴンの裏面を描写しません。<br>`Front` \| ポリゴンの表面を描写しません。|
|Z Write|デプスバッファの書き込みを許可するかを指定します。|
|Flip Texcoord(Feature)|Texcoord(UV)の反転ができます。|
|Forced Z Scale Zero|モデルのZ方向のスケールを0にします。|
|Billboard Mode(Feature)|当シェーダーをパーティクルで使用する場合はOffにしてください。<br>無効時、Particle Systemのカラー設定のアルファ値が、歪みの効果量の影響を受けるようになります。<br>これによりParticle Systemの設定に応じて柔軟な制御が可能です。|
|Stereo Merge Mode(Feature) | ステレオレンダリング時に左右のカメラの位置の中間を取って描写することができます。<br>`None` \| 何も平均化しません。<br>`Position` \| 座標を中間にします。左右で同じ位置に描写されるため、奥行きが分からなくなるような錯覚を受けます。<br>GrabPassを使用し、極端に景色を歪ませるような用途に対して利用すると、スレテオレンダリング時の描写の左右差を抑えることができる可能性があります。<br>`Rotation` \| 向きを中間にします。**Pimax**といった、左右のカメラで異なる向きを持つ特殊な描写環境に対して調整する目的で使用されます。<br>`Position_Rotation` \| 座標と向きを中間にします。|
|Preview Mode(Feature)|主にデバッグ利用を想定した描写モードです。+の変化は赤に、-の変化は緑として表示されます。|


## Distortion
|Property|Description|
|:--|:--|
|Distortion Amount|歪みの強度を指定します。<br>強すぎる歪みは健康上の問題を引き起こしかねないため、適度な強さでお願いします。|
|In Mask|中心から歪みの描写を抑えるマスクを広げます。|
|Scale|excoord(UV)基準でのスケールを指定します。後述のスケール関連のパラメータを考えると重要性は低いかもしれません。|
|Offset X<br>Offset Y|Texcoord(UV)基準のオフセットを指定します。|
|Line Scale|放射状のノイズの放射のスケールを指定します。|
|Line Phase Speed|放射状のノイズ周期の変化の速度を指定します。|
|Phase Scale|中心から外側にかけたノイズ周期のスケールを指定します。|
|Phase Speed|中心から外側にかけたノイズ周期の変化の速度を指定します。|
|||

## DirtyNoise
|Property|Description|
|:--|:--|
|Disable DirtyNoise(Feature)|歪みをより不安定な描写にするためのDirtyNoiseを無効にします。<br>DirtyNoiseが不用な場合はチェックを入れると、軽量化も期待できます。|
|DirtyNoise Amount Power|DirtyNoiseをべき乗で制御します。強くすると+値と-値が極端になります。|
|DirtyNoise Amount Remove|DirtyNoiseを指定した値分弱めます。微調整用のプロパティです。|
|DirtyNoise Speed|DirtyNoiseのノイズ周期の変化の速度を指定します。|
|DirtyNoise 1st Mask Scale<br>DirtyNoise 2nd Mask Scale|二つのマスク用のノイズのスケールを指定します。<br>1stと2ndで違うスケールを指定すると、よりランダム性が生まれます。|
|DirtyNoise Scale|上記の二つのマスクノイズ上で描写されるノイズのスケールを指定します。|
|DirtyNoise Threshold|DirtyNoiseが占める割合を指定します。|

## Chromatic Aberration
|Property|Description|
|:--|:--|
|Disable Chromatic Aberration(Feature)|ノイズの揺らぎに応じた色ずれの表現を無効にします。<br>処理そのものを無効にするため、軽量化に繋がります。|
|Chromatic Aberration Amount|色ずれの強度を指定します。|
|Red X<br>Red Y<br>Green X<br>Green Y<br>Blue X<br>Blue Y|それぞれ、赤、緑、青の色要素を任意の方向へずらせます。|
|DirtyNoise Move Amount|DirtyNoiseのスクロール速度を指定します。|
|DirtyNoise Time Scale X<br>DirtyNoise Time Scale Y|DirtyNoiseのXY方向へのスクロール周期及びスクロール時間のスケールを指定します。<br>それぞれを1にすると、円を描くような回り方をし、それぞれの値を周期が合いにくい値に設定するとスクロールの仕方が連続したループに感じにくくなります。|