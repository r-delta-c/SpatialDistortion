Shader "DeltaField/shaders/SpatialDistortion"{
    Properties{
        [Header(Rendering)]
        [Space(16)]
        [Enum(UnityEngine.Rendering.CullMode)]
        _Cull("Culling Mode",Float)=0.0
        [KeywordEnum(Off,On)]
        _ZWrite("Z Write",Float)=0.0
        [Space(16)]
        [KeywordEnum(None,Flip X,Flip Y,Flip XY)]
        _FlipTexcoord("Flip Texcoord(Feature)",Float)=0.0
        [MaterialToggle]_Forced_Z_Scale_Zero("Forced Z Scale Zero",Float)=1.0
        [Toggle(_BILLBOARD_MODE)]
        _BillboardMode("Billboard Mode(Feature)",Float)=0.0
        [KeywordEnum(None,Position,Rotation,Position_Rotation)]
        _StereoMergeMode("Stereo Merge Mode(Feature)",Int)=2
        [Toggle(_PREVIEW_MODE)]
        _PreviewMode("Preview Mode(Feature)",Float)=0.0
        [Space(16)]
        [Header(Distortion)]
        [Space(16)]
        _DistortionAmount("Distortion Amount",Float)=0.3
        _InMask("In Mask",Range(0.0,1.3))=0.0
        _Scale("Scale",Float)=1.0
        _Offset_X("Offset X",Float)=0.0
        _Offset_Y("Offset Y",Float)=0.0
        [Space(16)]
        _LineScale("Line Scale",Float)=10.0
        _LinePhaseSpeed("Line Phase Speed",Float)=4.0
        _PhaseScale("Phase Scale",Float)=10.0
        _PhaseSpeed("Phase Speed",Float)=100.0
        [Space(16)]
        [Header(Dirty Noise)]
        [Space(16)]
        [Toggle(_DISABLE_DIRTYNOISE)]
        _DisableDirtyNoise("Disable DirtyNoise(Feature)",Float)=0.0
        _DirtyNoiseAmount_P("DirtyNoise Power Amount",Float)=4.0
        _DirtyNoiseAmount_R("DirtyNoise Remove Amount",Float)=0.1
        _DirtyNoiseSpeed("DirtyNoise Speed",Float)=32.0
        [Space(16)]
        _DirtyNoise1stMaskScale("DirtyNoise 1st Mask Scale",Float)=5.0
        _DirtyNoise2ndMaskScale("DirtyNoise 2st Mask Scale",Float)=11.0
        _DirtyNoiseScale("DirtyNoise Scale",Float)=192.0
        _DirtyNoiseThreshold("DirtyNoise Threshold",Range(-1.0,1.0))=0.0
        [Space(16)]
        [Header(Chromatic)]
        [Space(16)]
        [Toggle(_DISABLE_CHROMATIC_A)]
        _Disable_Chromatic_A("Disable Chromatic Aberration(Feature)",Float)=0.0
        _ChromaticAAmount("Chromatic Aberration Amount",Float)=0.3
        _ChromaticA_R_X("Red X",  Range(-1.0,1.0))= 0.21
        _ChromaticA_R_Y("Red Y",  Range(-1.0,1.0))=-0.16
        _ChromaticA_G_X("Green X",Range(-1.0,1.0))=-0.17
        _ChromaticA_G_Y("Green Y",Range(-1.0,1.0))= 0.17
        _ChromaticA_B_X("Blue X", Range(-1.0,1.0))=-0.16
        _ChromaticA_B_Y("Blue Y", Range(-1.0,1.0))=-0.10
        [Space(16)]
        _DirtyNoiseMoveAmount("DirtyNoise Move Amount",Float)=20.0
        _DirtyNoiseTimeScaleX("DirtyNoise Time Scale X",Range(1.0,2.0))=1.027
        _DirtyNoiseTimeScaleY("DirtyNoise Time Scale Y",Range(1.0,2.0))=1.191
    }
    SubShader{
        Tags{"RenderType"="Transparent" "Queue"="Transparent" "LightMode"="ForwardBase"}
        Cull [_Cull]
        ZWrite [_ZWrite]

        GrabPass{
            //Unique names recommended.
            //重複しづらい名称を推奨します。
            // "(NAME)"
            ///////////////////////////////
            "_DELTAFIELD_GB_SPACE_DIST_777"
            ///////////////////////////////
        }

        Pass{
            HLSLPROGRAM

            //Unique names recommended.
            //重複しづらい名称を推奨します。
            // #define GRABPASS_ID (NAME)
            // #define GRABPASS_ID_ST (NAME)_ST
            ////////////////////////////////////////
            #define GRABPASS_ID _DELTAFIELD_GB_SPACE_DIST_777
            #define GRABPASS_ID_ST _DELTAFIELD_GB_SPACE_DIST_777_ST
            ////////////////////////////////////////

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            #pragma shader_feature_local _STEREOMERGEMODE_NONE _STEREOMERGEMODE_POSITION _STEREOMERGEMODE_ROTATION _STEREOMERGEMODE_POSITION_ROTATION

            #pragma shader_feature_local _FLIPTEXCOORD_NONE _FLIPTEXCOORD_FLIP_X _FLIPTEXCOORD_FLIP_Y _FLIPTEXCOORD_FLIP_XY
            #pragma shader_feature_local _ _PREVIEW_MODE
            #pragma shader_feature_local _ _BILLBOARD_MODE
            #pragma shader_feature_local _ _DISABLE_DIRTYNOISE
            #pragma shader_feature_local _ _DISABLE_CHROMATIC_A
            
            struct appdata{
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                fixed4 color : COLOR;

                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f{
                float4 vertex : SV_POSITION;
                float4 uvgrab :TEXCOORD0;
                float2 texcoord : TEXCOORD1;
                float2 uv_noise : TEXCOORD2;
                float distance_camera : TEXCOORD3;
                fixed alpha : TEXCOORD4;

                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            UNITY_DECLARE_SCREENSPACE_TEXTURE(GRABPASS_ID);
            float4 GRABPASS_ID_ST;

            float _DistortionAmount;
            float _InMask;
            float _Scale;
            float _Offset_X;
            float _Offset_Y;

            float _LineScale;
            float _LinePhaseSpeed;
            float _PhaseScale;
            float _PhaseSpeed;

            float _Forced_Z_Scale_Zero;

            float _DirtyNoiseAmount_P;
            float _DirtyNoiseAmount_R;
            float _DirtyNoiseSpeed;
            float _DirtyNoiseScale;
            float _DirtyNoise1stMaskScale;
            float _DirtyNoise2ndMaskScale;
            float _DirtyNoiseThreshold;
            float _DirtyNoiseMoveAmount;
            float _DirtyNoiseTimeScaleX;
            float _DirtyNoiseTimeScaleY;

            float _ChromaticAAmount;
            float _ChromaticA_R_X;
            float _ChromaticA_R_Y;
            float _ChromaticA_G_X;
            float _ChromaticA_G_Y;
            float _ChromaticA_B_X;
            float _ChromaticA_B_Y;

            float t;
            float amount;
            float2 uvgrab;
            float2 texcoord;
            float alpha;
            float distance_camera;

            #include "Packages/com.deltafield.shader_commons/Includes/macro_stereo_merge.hlsl"

            #include "Packages/com.deltafield.shader_commons/Includes/functions_math.hlsl"
            #include "Packages/com.deltafield.shader_commons/Includes/functions_random.hlsl"
            #include "Packages/com.deltafield.shader_commons/Includes/functions_stereo_merge.hlsl"

            #ifdef _FLIPTEXCOORD_FLIP_X
                #define FLIP_TEX float2(-2.0,2.0)
            #elif _FLIPTEXCOORD_FLIP_Y
                #define FLIP_TEX float2(2.0,-2.0)
            #elif _FLIPTEXCOORD_FLIP_XY
                #define FLIP_TEX -2.0
            #else
                #define FLIP_TEX 2.0
            #endif

            v2f vert(appdata v){
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f,o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                float dist = 0.0;
                #ifdef _BILLBOARD_MODE
                    o.alpha = 1.0;
                    float4x4 Stereo_Merge_Matrix_V = DEFINE_STEREO_MERGE_MATRIX_V;
                    float4x4 Billboard_Matrix_M = {
                        1.0,0.0,0.0,0.0,
                        0.0,1.0,0.0,0.0,
                        0.0,0.0,1.0,0.0,
                        0.0,0.0,0.0,1.0
                    };

                    Billboard_Matrix_M._m00_m10_m20 = Stereo_Merge_Matrix_V[0].xyz*length(unity_ObjectToWorld._m00_m10_m20);
                    Billboard_Matrix_M._m01_m11_m21 = Stereo_Merge_Matrix_V[1].xyz*length(unity_ObjectToWorld._m01_m11_m21);
                    Billboard_Matrix_M._m02_m12_m22 = -Stereo_Merge_Matrix_V[2].xyz*length(unity_ObjectToWorld._m02_m12_m22)*(1.0-_Forced_Z_Scale_Zero);
                    Billboard_Matrix_M._m03_m13_m23 = unity_ObjectToWorld._m03_m13_m23;

                    o.vertex = mul(Billboard_Matrix_M,v.vertex);
                    o.distance_camera = max(CAMERA_DISTANCE_MACRO,1e-4);
                    o.vertex = mul(Stereo_Merge_Matrix_V,o.vertex);
                    o.vertex = mul(UNITY_MATRIX_P,o.vertex);
                #else
                    o.alpha = v.color.a;
                    o.vertex = mul(UNITY_MATRIX_M,v.vertex);
                    o.distance_camera = max(CAMERA_DISTANCE_MACRO,1e-4);
                    o.vertex = mul(DEFINE_STEREO_MERGE_MATRIX_V,o.vertex);
                    o.vertex = mul(UNITY_MATRIX_P,o.vertex);
                #endif

                o.uvgrab = ComputeGrabScreenPos(o.vertex);
                o.texcoord = (v.texcoord-0.5)*FLIP_TEX;
                o.uv_noise = float2(o.texcoord.x+_Offset_X,o.texcoord.y+_Offset_Y)*_Scale;
                return o;
            }

/////////////////////////////////////////////////////////////////////////////////////

            float ConstNoise(float2 tex, float2 offset){
                float r;
                tex += float2(offset);
                float deg = atan2(tex.x,tex.y);
                float length_t = length(tex)-t*_PhaseSpeed;

                float2 loop_r = float2(sin(deg),cos(deg))                   *_LineScale + (t*_LinePhaseSpeed);
                float2 loop_t = float2(sin(length_t),cos(length_t))         *_PhaseScale;

                float speedline = PerlinNoise(loop_t+PerlinNoise(loop_r)*5.0);

                #ifdef _DISABLE_DIRTYNOISE
                    return speedline*2.0-0.5;
                #else
                    float2 loop_dirty = float2(tex.x+sin(t*_DirtyNoiseTimeScaleX)*_DirtyNoiseMoveAmount,tex.y+cos(t*_DirtyNoiseTimeScaleY)*_DirtyNoiseMoveAmount);

                    float dirty_area = 
                        saturate(
                            (sin((PerlinNoise(loop_dirty*_DirtyNoise1stMaskScale) + t * _DirtyNoiseSpeed)*UNITY_PI)+
                             sin((PerlinNoise(loop_dirty*_DirtyNoise2ndMaskScale) + t * _DirtyNoiseSpeed)*UNITY_PI+UNITY_PI)) *
                            0.5+_DirtyNoiseThreshold+0.5);

                    float dirty = dirty_area > 0.7 ? PerlinNoise(loop_dirty*_DirtyNoiseScale): 0.0;
                    dirty = lerp(0.0,PerlinNoise(loop_dirty*_DirtyNoiseScale),saturate(pow(dirty_area,_DirtyNoiseAmount_P)-_DirtyNoiseAmount_R));

                    r = speedline + dirty;
                    return r*2.0-0.7;
                #endif
            }

            float3 GenSpeedLine(float2 tex, float2 offset){
                return UNITY_SAMPLE_SCREENSPACE_TEXTURE(GRABPASS_ID,UnityStereoScreenSpaceUVAdjust(uvgrab + ConstNoise(tex,float2(offset.x,offset.y))*alpha*amount/distance_camera, GRABPASS_ID_ST));
            }

            fixed4 frag(v2f i) : SV_TARGET{
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                t = _Time;
                distance_camera = i.distance_camera;
                amount = _DistortionAmount*0.03;
                #ifdef _DISABLE_CUSTOM_BILLBOARD
                    amount *= 6.0;
                #endif
                float4 c = float4(0.0,0.0,0.0,1.0);

                uvgrab = i.uvgrab.xy / i.uvgrab.w;

                float tex_length = min(1.0,length(i.texcoord));
                alpha = saturate(1.0 - (tex_length < 0.5 ? 2.0*tex_length*tex_length : 1.0 - pow(-2.0*tex_length + 2.0, 2.0)*0.5));
                alpha *= saturate(1.0 - (-tex_length+_InMask)*4.0);

                #ifdef _PREVIEW_MODE
                    float2 preview = ConstNoise(i.uv_noise,float2(0.0,0.0))*alpha*i.alpha/distance_camera;
                    c.rg = float2(max(0.0,preview.x),abs(min(0.0,preview.y))); 
                #else
                    #ifdef _DISABLE_CHROMATIC_A
                        c.rgb = GenSpeedLine(i.uv_noise,float2(0.0,0.0));
                    #else
                        float chromatic_amount = _ChromaticAAmount/distance_camera;
                        float2 red   = float2(_ChromaticA_R_X*chromatic_amount,_ChromaticA_R_Y*chromatic_amount);
                        float2 green = float2(_ChromaticA_G_X*chromatic_amount,_ChromaticA_G_Y*chromatic_amount);
                        float2 blue  = float2(_ChromaticA_B_X*chromatic_amount,_ChromaticA_B_Y*chromatic_amount);
                        float3 cr = GenSpeedLine(i.uv_noise,red);
                        float3 cg = GenSpeedLine(i.uv_noise,green);
                        float3 cb = GenSpeedLine(i.uv_noise,blue);
                        c = float4(cr.r,cg.g,cb.b,i.alpha);
                    #endif
                #endif

                return saturate(c);
            }
            ENDHLSL
        }
    }
}