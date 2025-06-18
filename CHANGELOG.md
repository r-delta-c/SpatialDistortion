# Change Log

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.0.0-exp.1] 2025/06/18
### Changed
- ステレオレンダリング用の補正処理をDeltaField-Shader-CommonsにIncludeとして移行。
- カメラとの距離に応じて歪みの強度が変化するようにしました。
- `shader_feature`を`shader_feature_local`に変更。

### Removed
- `_DistortionCloseRangeLimit`の削除。歪みが補正されるようになったため不要になりました。

### Fixed
- Single Pass Instanced環境下で正常に動作しない不具合を修正。
- 一部のキーワードが適切に動作しない不具合を修正。



## [OldLog]
```
prototype-1.0 限定公開 2025/04/01
シェーダー名を変更。
Space Distortion -> Spacial Distortion

Particle Billboard Mode(Feature)を有効にした状態で、Particle Systemのアルファ値を参照する仕様に変更。
shader_featureの状態分岐が不足していた不具合を修正。


dev-1.0 限定公開 2025/02/26
```

<!--
## [Unreleased]

[Unreleased]: https://github.com/r-delta-c/SpacialDistortion/compare/0.0.0-exp.1...1.0.0

-->