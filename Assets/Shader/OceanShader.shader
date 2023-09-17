Shader "Ocean Toolkit/Ocean Shader" {
Properties {
 ot_NormalMap0 ("Normal Map 0", 2D) = "blue" { }
 ot_NormalMap1 ("Normal Map 1", 2D) = "blue" { }
 ot_FoamMap ("Foam Map", 2D) = "white" { }
 ot_AbsorptionCoeffs ("Absorption Coeffs", Vector) = (3.000000,20.000000,50.000000,1.000000)
 ot_DetailFalloffStart ("Detail Falloff Start", Float) = 60.000000
 ot_DetailFalloffDistance ("Detail Falloff Distance", Float) = 40.000000
 ot_DetailFalloffNormalGoal ("Detail Falloff Normal Goal", Float) = 0.200000
 ot_AlphaFalloff ("Alpha Falloff", Float) = 1.000000
 ot_FoamFalloff ("Foam Falloff", Float) = 2.000000
 ot_FoamStrength ("Foam Strength", Float) = 1.200000
 ot_FoamAmbient ("Foam Ambient", Float) = 0.300000
 ot_ReflStrength ("Reflection Strength", Float) = 0.900000
 ot_RefrStrength ("Refraction Strength", Float) = 1.000000
 ot_RefrColor ("Refraction Color", Color) = (1.000000,0.000000,0.000000,1.000000)
 ot_RefrNormalOffset ("Refraction Normal Offset", Float) = 0.050000
 ot_RefrNormalOffsetRamp ("Refraction Normal Offset Ramp", Float) = 2.000000
 ot_FresnelPow ("Fresnel Pow", Float) = 4.000000
 ot_SunColor ("Sun Color", Color) = (1.000000,0.950000,0.600000,1.000000)
 ot_SunPow ("Sun Power", Float) = 100.000000
 ot_DeepWaterColorUnlit ("Deep Water Color", Color) = (0.045000,0.150000,0.300000,1.000000)
 ot_DeepWaterAmbientBoost ("Deep Water Ambient Boost", Float) = 0.300000
 ot_DeepWaterIntensityZenith ("Deep Water Intensity Zenith", Float) = 1.000000
 ot_DeepWaterIntensityHorizon ("Deep Water Intensity Horizon", Float) = 0.400000
 ot_DeepWaterIntensityDark ("Deep Water Intensity Dark", Float) = 0.100000
}
SubShader { 
 Tags { "QUEUE"="Transparent-10" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 GrabPass {
  "_Refraction"
 }
 Pass {
  Tags { "QUEUE"="Transparent-10" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 39691
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp float ot_OceanPosition;
					uniform highp vec4 ot_WaveScales;
					uniform highp vec4 ot_WaveExponents;
					uniform highp vec4 ot_WaveOffsets;
					uniform highp vec4 ot_WaveDirection01;
					uniform highp vec4 ot_WaveDirection23;
					uniform highp vec4 ot_WaveConstants;
					uniform highp vec4 ot_WaveDerivativeConstants;
					uniform highp mat4 ot_Proj;
					uniform highp mat4 ot_InvView;
					uniform highp vec3 ot_ViewCorner0;
					uniform highp vec3 ot_ViewCorner1;
					uniform highp vec3 ot_ViewCorner2;
					uniform highp vec3 ot_ViewCorner3;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 worldVertex_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = ot_ViewCorner0;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = ot_ViewCorner1;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = ot_ViewCorner2;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = ot_ViewCorner3;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/((ot_Proj * tmpvar_2).w));
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0/((ot_Proj * tmpvar_3).w));
					  highp float tmpvar_8;
					  tmpvar_8 = (1.0/((ot_Proj * tmpvar_4).w));
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0/((ot_Proj * tmpvar_5).w));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (mix (mix (
					    (ot_ViewCorner0 * tmpvar_6)
					  , 
					    (ot_ViewCorner3 * tmpvar_9)
					  , _glesVertex.yyy), mix (
					    (ot_ViewCorner1 * tmpvar_7)
					  , 
					    (ot_ViewCorner2 * tmpvar_8)
					  , _glesVertex.yyy), _glesVertex.xxx) / mix (mix (tmpvar_6, tmpvar_9, _glesVertex.y), mix (tmpvar_7, tmpvar_8, _glesVertex.y), _glesVertex.x));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (ot_InvView * tmpvar_10).xyz;
					  worldVertex_1.xz = tmpvar_11.xz;
					  highp vec4 tmpvar_12;
					  tmpvar_12.x = dot (ot_WaveDirection01.xy, tmpvar_11.xz);
					  tmpvar_12.y = dot (ot_WaveDirection01.zw, tmpvar_11.xz);
					  tmpvar_12.z = dot (ot_WaveDirection23.xy, tmpvar_11.xz);
					  tmpvar_12.w = dot (ot_WaveDirection23.zw, tmpvar_11.xz);
					  highp vec4 tmpvar_13;
					  tmpvar_13.x = ot_WaveDirection01.x;
					  tmpvar_13.y = ot_WaveDirection01.z;
					  tmpvar_13.z = ot_WaveDirection23.x;
					  tmpvar_13.w = ot_WaveDirection23.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = ot_WaveDirection01.y;
					  tmpvar_14.y = ot_WaveDirection01.w;
					  tmpvar_14.z = ot_WaveDirection23.y;
					  tmpvar_14.w = ot_WaveDirection23.w;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((sin(
					    ((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants)
					  ) * 0.5) + 0.5);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = cos(((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants));
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(1.0, 0.0);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (ot_WaveExponents - 0.99);
					  tmpvar_17.y = dot ((tmpvar_13 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 1.0);
					  tmpvar_19.y = dot ((tmpvar_14 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  worldVertex_1.y = (ot_OceanPosition + dot (ot_WaveScales, pow (tmpvar_15, ot_WaveExponents)));
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldVertex_1;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_MatrixVP * tmpvar_20);
					  highp vec4 o_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_21 * 0.5);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_23.x;
					  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
					  o_22.xy = (tmpvar_24 + tmpvar_23.w);
					  o_22.zw = tmpvar_21.zw;
					  gl_Position = tmpvar_21;
					  xlv_TEXCOORD0 = o_22;
					  xlv_TEXCOORD1 = worldVertex_1;
					  xlv_TEXCOORD2 = normalize(((tmpvar_19.yzx * tmpvar_17.zxy) - (tmpvar_19.zxy * tmpvar_17.yzx)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_shader_texture_lod : enable
					lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
					{
					#if defined(GL_EXT_shader_texture_lod)
						return textureCubeLodEXT(sampler, coord, lod);
					#else
						return textureCube(sampler, coord, lod);
					#endif
					}
					
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ProjectionParams;
					uniform lowp samplerCube unity_SpecCube0;
					uniform mediump vec4 unity_SpecCube0_HDR;
					uniform sampler2D _CameraDepthNormalsTexture;
					uniform highp vec3 ot_LightDir;
					uniform highp vec3 ot_DeepWaterColor;
					uniform sampler2D ot_NormalMap0;
					uniform sampler2D ot_NormalMap1;
					uniform sampler2D ot_FoamMap;
					uniform highp vec4 ot_NormalMap0_ST;
					uniform highp vec4 ot_NormalMap1_ST;
					uniform highp vec4 ot_FoamMap_ST;
					uniform highp vec4 ot_AbsorptionCoeffs;
					uniform highp float ot_DetailFalloffStart;
					uniform highp float ot_DetailFalloffDistance;
					uniform highp float ot_DetailFalloffNormalGoal;
					uniform highp float ot_AlphaFalloff;
					uniform highp float ot_FoamFalloff;
					uniform highp float ot_FoamStrength;
					uniform highp float ot_FoamAmbient;
					uniform highp float ot_ReflStrength;
					uniform highp float ot_RefrStrength;
					uniform highp vec4 ot_RefrColor;
					uniform highp float ot_FresnelPow;
					uniform highp vec3 ot_SunColor;
					uniform highp float ot_SunPow;
					uniform highp float ot_DeepWaterAmbientBoost;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 fineNormal1_1;
					  highp vec3 fineNormal0_2;
					  highp vec3 normal_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = ((xlv_TEXCOORD1.xz * ot_NormalMap0_ST.xy) + ot_NormalMap0_ST.zw);
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (ot_NormalMap0, tmpvar_4).xyz * 2.0) - 1.0).xzy;
					  fineNormal0_2 = tmpvar_5;
					  highp vec2 tmpvar_6;
					  tmpvar_6 = ((xlv_TEXCOORD1.xz * ot_NormalMap1_ST.xy) + ot_NormalMap1_ST.zw);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (ot_NormalMap1, tmpvar_6).xyz * 2.0) - 1.0).xzy;
					  fineNormal1_1 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (((xlv_TEXCOORD0.w - ot_DetailFalloffStart) / ot_DetailFalloffDistance), 0.0, 1.0);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(mix ((fineNormal0_2 + fineNormal1_1), vec3(0.0, 2.0, 0.0), vec3(clamp (
					    (tmpvar_8 - ot_DetailFalloffNormalGoal)
					  , 0.0, 1.0))));
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(mix (xlv_TEXCOORD2, vec3(0.0, 1.0, 0.0), vec3(tmpvar_8)));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = ((tmpvar_10.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_10.zxy * vec3(0.0, 1.0, 0.0)));
					  normal_3 = (((tmpvar_11 * tmpvar_9.x) + (tmpvar_10 * tmpvar_9.y)) + ((
					    (tmpvar_11.yzx * tmpvar_10.zxy)
					   - 
					    (tmpvar_11.zxy * tmpvar_10.yzx)
					  ) * tmpvar_9.z));
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
					  highp vec3 reflDir_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (tmpvar_12 - (2.0 * (
					    dot (normal_3, tmpvar_12)
					   * normal_3)));
					  reflDir_13.xz = tmpvar_14.xz;
					  reflDir_13.y = clamp (tmpvar_14.y, 0.0, 1.0);
					  highp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  mediump vec3 tmpvar_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = unity_SpecCube0_HDR;
					  tmpvar_17 = reflDir_13;
					  mediump vec3 tmpvar_19;
					  mediump vec4 hdr_20;
					  hdr_20 = tmpvar_18;
					  mediump vec4 tmpvar_21;
					  tmpvar_21.xyz = tmpvar_17;
					  tmpvar_21.w = ((tmpvar_16 * (1.7 - 
					    (0.7 * tmpvar_16)
					  )) * 6.0);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_17, tmpvar_21.w);
					  mediump vec4 tmpvar_23;
					  tmpvar_23 = tmpvar_22;
					  tmpvar_19 = ((hdr_20.x * tmpvar_23.w) * tmpvar_23.xyz);
					  tmpvar_15 = tmpvar_19;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
					  lowp vec4 tmpvar_25;
					  tmpvar_25 = texture2D (_CameraDepthNormalsTexture, tmpvar_24);
					  highp vec4 enc_26;
					  enc_26 = tmpvar_25;
					  highp float tmpvar_27;
					  tmpvar_27 = ((dot (enc_26.zw, vec2(1.0, 0.003921569)) * _ProjectionParams.z) - xlv_TEXCOORD0.w);
					  highp float tmpvar_28;
					  tmpvar_28 = clamp (dot (-(tmpvar_12), normal_3), 0.0, 1.0);
					  highp vec2 tmpvar_29;
					  tmpvar_29 = ((xlv_TEXCOORD1.xz * ot_FoamMap_ST.xy) + ot_FoamMap_ST.zw);
					  lowp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (ot_FoamMap, tmpvar_29);
					  highp float tmpvar_31;
					  tmpvar_31 = (((
					    (1.0 - pow (clamp ((tmpvar_27 / ot_FoamFalloff), 0.0, 1.0), 4.0))
					   * ot_FoamStrength) * clamp (
					    (ot_FoamAmbient + dot (normal_3, ot_LightDir))
					  , 0.0, 1.0)) * tmpvar_30.w);
					  highp float tmpvar_32;
					  tmpvar_32 = pow ((1.0 - tmpvar_28), ot_FresnelPow);
					  highp vec4 tmpvar_33;
					  tmpvar_33.xyz = (((1.0 - tmpvar_31) * (
					    (((tmpvar_32 * ot_ReflStrength) * tmpvar_15) + (((1.0 - tmpvar_32) * ot_RefrStrength) * mix (ot_RefrColor.xyz, (ot_DeepWaterColor * 
					      (1.0 + ((tmpvar_28 * tmpvar_28) * ot_DeepWaterAmbientBoost))
					    ), clamp (
					      (vec3(tmpvar_27) / ot_AbsorptionCoeffs.xyz)
					    , 0.0, 1.0))))
					   + 
					    (pow (clamp (dot (reflDir_13, ot_LightDir), 0.0, 1.0), ot_SunPow) * ot_SunColor)
					  )) + vec3(tmpvar_31));
					  tmpvar_33.w = clamp ((tmpvar_27 / ot_AlphaFalloff), 0.0, 1.0);
					  gl_FragData[0] = tmpvar_33;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp float ot_OceanPosition;
					uniform highp vec4 ot_WaveScales;
					uniform highp vec4 ot_WaveExponents;
					uniform highp vec4 ot_WaveOffsets;
					uniform highp vec4 ot_WaveDirection01;
					uniform highp vec4 ot_WaveDirection23;
					uniform highp vec4 ot_WaveConstants;
					uniform highp vec4 ot_WaveDerivativeConstants;
					uniform highp mat4 ot_Proj;
					uniform highp mat4 ot_InvView;
					uniform highp vec3 ot_ViewCorner0;
					uniform highp vec3 ot_ViewCorner1;
					uniform highp vec3 ot_ViewCorner2;
					uniform highp vec3 ot_ViewCorner3;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 worldVertex_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = ot_ViewCorner0;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = ot_ViewCorner1;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = ot_ViewCorner2;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = ot_ViewCorner3;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/((ot_Proj * tmpvar_2).w));
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0/((ot_Proj * tmpvar_3).w));
					  highp float tmpvar_8;
					  tmpvar_8 = (1.0/((ot_Proj * tmpvar_4).w));
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0/((ot_Proj * tmpvar_5).w));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (mix (mix (
					    (ot_ViewCorner0 * tmpvar_6)
					  , 
					    (ot_ViewCorner3 * tmpvar_9)
					  , _glesVertex.yyy), mix (
					    (ot_ViewCorner1 * tmpvar_7)
					  , 
					    (ot_ViewCorner2 * tmpvar_8)
					  , _glesVertex.yyy), _glesVertex.xxx) / mix (mix (tmpvar_6, tmpvar_9, _glesVertex.y), mix (tmpvar_7, tmpvar_8, _glesVertex.y), _glesVertex.x));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (ot_InvView * tmpvar_10).xyz;
					  worldVertex_1.xz = tmpvar_11.xz;
					  highp vec4 tmpvar_12;
					  tmpvar_12.x = dot (ot_WaveDirection01.xy, tmpvar_11.xz);
					  tmpvar_12.y = dot (ot_WaveDirection01.zw, tmpvar_11.xz);
					  tmpvar_12.z = dot (ot_WaveDirection23.xy, tmpvar_11.xz);
					  tmpvar_12.w = dot (ot_WaveDirection23.zw, tmpvar_11.xz);
					  highp vec4 tmpvar_13;
					  tmpvar_13.x = ot_WaveDirection01.x;
					  tmpvar_13.y = ot_WaveDirection01.z;
					  tmpvar_13.z = ot_WaveDirection23.x;
					  tmpvar_13.w = ot_WaveDirection23.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = ot_WaveDirection01.y;
					  tmpvar_14.y = ot_WaveDirection01.w;
					  tmpvar_14.z = ot_WaveDirection23.y;
					  tmpvar_14.w = ot_WaveDirection23.w;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((sin(
					    ((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants)
					  ) * 0.5) + 0.5);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = cos(((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants));
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(1.0, 0.0);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (ot_WaveExponents - 0.99);
					  tmpvar_17.y = dot ((tmpvar_13 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 1.0);
					  tmpvar_19.y = dot ((tmpvar_14 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  worldVertex_1.y = (ot_OceanPosition + dot (ot_WaveScales, pow (tmpvar_15, ot_WaveExponents)));
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldVertex_1;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_MatrixVP * tmpvar_20);
					  highp vec4 o_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_21 * 0.5);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_23.x;
					  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
					  o_22.xy = (tmpvar_24 + tmpvar_23.w);
					  o_22.zw = tmpvar_21.zw;
					  gl_Position = tmpvar_21;
					  xlv_TEXCOORD0 = o_22;
					  xlv_TEXCOORD1 = worldVertex_1;
					  xlv_TEXCOORD2 = normalize(((tmpvar_19.yzx * tmpvar_17.zxy) - (tmpvar_19.zxy * tmpvar_17.yzx)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_shader_texture_lod : enable
					lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
					{
					#if defined(GL_EXT_shader_texture_lod)
						return textureCubeLodEXT(sampler, coord, lod);
					#else
						return textureCube(sampler, coord, lod);
					#endif
					}
					
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ProjectionParams;
					uniform lowp samplerCube unity_SpecCube0;
					uniform mediump vec4 unity_SpecCube0_HDR;
					uniform sampler2D _CameraDepthNormalsTexture;
					uniform highp vec3 ot_LightDir;
					uniform highp vec3 ot_DeepWaterColor;
					uniform sampler2D ot_NormalMap0;
					uniform sampler2D ot_NormalMap1;
					uniform sampler2D ot_FoamMap;
					uniform highp vec4 ot_NormalMap0_ST;
					uniform highp vec4 ot_NormalMap1_ST;
					uniform highp vec4 ot_FoamMap_ST;
					uniform highp vec4 ot_AbsorptionCoeffs;
					uniform highp float ot_DetailFalloffStart;
					uniform highp float ot_DetailFalloffDistance;
					uniform highp float ot_DetailFalloffNormalGoal;
					uniform highp float ot_AlphaFalloff;
					uniform highp float ot_FoamFalloff;
					uniform highp float ot_FoamStrength;
					uniform highp float ot_FoamAmbient;
					uniform highp float ot_ReflStrength;
					uniform highp float ot_RefrStrength;
					uniform highp vec4 ot_RefrColor;
					uniform highp float ot_FresnelPow;
					uniform highp vec3 ot_SunColor;
					uniform highp float ot_SunPow;
					uniform highp float ot_DeepWaterAmbientBoost;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 fineNormal1_1;
					  highp vec3 fineNormal0_2;
					  highp vec3 normal_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = ((xlv_TEXCOORD1.xz * ot_NormalMap0_ST.xy) + ot_NormalMap0_ST.zw);
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (ot_NormalMap0, tmpvar_4).xyz * 2.0) - 1.0).xzy;
					  fineNormal0_2 = tmpvar_5;
					  highp vec2 tmpvar_6;
					  tmpvar_6 = ((xlv_TEXCOORD1.xz * ot_NormalMap1_ST.xy) + ot_NormalMap1_ST.zw);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (ot_NormalMap1, tmpvar_6).xyz * 2.0) - 1.0).xzy;
					  fineNormal1_1 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (((xlv_TEXCOORD0.w - ot_DetailFalloffStart) / ot_DetailFalloffDistance), 0.0, 1.0);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(mix ((fineNormal0_2 + fineNormal1_1), vec3(0.0, 2.0, 0.0), vec3(clamp (
					    (tmpvar_8 - ot_DetailFalloffNormalGoal)
					  , 0.0, 1.0))));
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(mix (xlv_TEXCOORD2, vec3(0.0, 1.0, 0.0), vec3(tmpvar_8)));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = ((tmpvar_10.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_10.zxy * vec3(0.0, 1.0, 0.0)));
					  normal_3 = (((tmpvar_11 * tmpvar_9.x) + (tmpvar_10 * tmpvar_9.y)) + ((
					    (tmpvar_11.yzx * tmpvar_10.zxy)
					   - 
					    (tmpvar_11.zxy * tmpvar_10.yzx)
					  ) * tmpvar_9.z));
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
					  highp vec3 reflDir_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (tmpvar_12 - (2.0 * (
					    dot (normal_3, tmpvar_12)
					   * normal_3)));
					  reflDir_13.xz = tmpvar_14.xz;
					  reflDir_13.y = clamp (tmpvar_14.y, 0.0, 1.0);
					  highp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  mediump vec3 tmpvar_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = unity_SpecCube0_HDR;
					  tmpvar_17 = reflDir_13;
					  mediump vec3 tmpvar_19;
					  mediump vec4 hdr_20;
					  hdr_20 = tmpvar_18;
					  mediump vec4 tmpvar_21;
					  tmpvar_21.xyz = tmpvar_17;
					  tmpvar_21.w = ((tmpvar_16 * (1.7 - 
					    (0.7 * tmpvar_16)
					  )) * 6.0);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_17, tmpvar_21.w);
					  mediump vec4 tmpvar_23;
					  tmpvar_23 = tmpvar_22;
					  tmpvar_19 = ((hdr_20.x * tmpvar_23.w) * tmpvar_23.xyz);
					  tmpvar_15 = tmpvar_19;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
					  lowp vec4 tmpvar_25;
					  tmpvar_25 = texture2D (_CameraDepthNormalsTexture, tmpvar_24);
					  highp vec4 enc_26;
					  enc_26 = tmpvar_25;
					  highp float tmpvar_27;
					  tmpvar_27 = ((dot (enc_26.zw, vec2(1.0, 0.003921569)) * _ProjectionParams.z) - xlv_TEXCOORD0.w);
					  highp float tmpvar_28;
					  tmpvar_28 = clamp (dot (-(tmpvar_12), normal_3), 0.0, 1.0);
					  highp vec2 tmpvar_29;
					  tmpvar_29 = ((xlv_TEXCOORD1.xz * ot_FoamMap_ST.xy) + ot_FoamMap_ST.zw);
					  lowp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (ot_FoamMap, tmpvar_29);
					  highp float tmpvar_31;
					  tmpvar_31 = (((
					    (1.0 - pow (clamp ((tmpvar_27 / ot_FoamFalloff), 0.0, 1.0), 4.0))
					   * ot_FoamStrength) * clamp (
					    (ot_FoamAmbient + dot (normal_3, ot_LightDir))
					  , 0.0, 1.0)) * tmpvar_30.w);
					  highp float tmpvar_32;
					  tmpvar_32 = pow ((1.0 - tmpvar_28), ot_FresnelPow);
					  highp vec4 tmpvar_33;
					  tmpvar_33.xyz = (((1.0 - tmpvar_31) * (
					    (((tmpvar_32 * ot_ReflStrength) * tmpvar_15) + (((1.0 - tmpvar_32) * ot_RefrStrength) * mix (ot_RefrColor.xyz, (ot_DeepWaterColor * 
					      (1.0 + ((tmpvar_28 * tmpvar_28) * ot_DeepWaterAmbientBoost))
					    ), clamp (
					      (vec3(tmpvar_27) / ot_AbsorptionCoeffs.xyz)
					    , 0.0, 1.0))))
					   + 
					    (pow (clamp (dot (reflDir_13, ot_LightDir), 0.0, 1.0), ot_SunPow) * ot_SunColor)
					  )) + vec3(tmpvar_31));
					  tmpvar_33.w = clamp ((tmpvar_27 / ot_AlphaFalloff), 0.0, 1.0);
					  gl_FragData[0] = tmpvar_33;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp float ot_OceanPosition;
					uniform highp vec4 ot_WaveScales;
					uniform highp vec4 ot_WaveExponents;
					uniform highp vec4 ot_WaveOffsets;
					uniform highp vec4 ot_WaveDirection01;
					uniform highp vec4 ot_WaveDirection23;
					uniform highp vec4 ot_WaveConstants;
					uniform highp vec4 ot_WaveDerivativeConstants;
					uniform highp mat4 ot_Proj;
					uniform highp mat4 ot_InvView;
					uniform highp vec3 ot_ViewCorner0;
					uniform highp vec3 ot_ViewCorner1;
					uniform highp vec3 ot_ViewCorner2;
					uniform highp vec3 ot_ViewCorner3;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 worldVertex_1;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = ot_ViewCorner0;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = ot_ViewCorner1;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = ot_ViewCorner2;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = ot_ViewCorner3;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/((ot_Proj * tmpvar_2).w));
					  highp float tmpvar_7;
					  tmpvar_7 = (1.0/((ot_Proj * tmpvar_3).w));
					  highp float tmpvar_8;
					  tmpvar_8 = (1.0/((ot_Proj * tmpvar_4).w));
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0/((ot_Proj * tmpvar_5).w));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (mix (mix (
					    (ot_ViewCorner0 * tmpvar_6)
					  , 
					    (ot_ViewCorner3 * tmpvar_9)
					  , _glesVertex.yyy), mix (
					    (ot_ViewCorner1 * tmpvar_7)
					  , 
					    (ot_ViewCorner2 * tmpvar_8)
					  , _glesVertex.yyy), _glesVertex.xxx) / mix (mix (tmpvar_6, tmpvar_9, _glesVertex.y), mix (tmpvar_7, tmpvar_8, _glesVertex.y), _glesVertex.x));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (ot_InvView * tmpvar_10).xyz;
					  worldVertex_1.xz = tmpvar_11.xz;
					  highp vec4 tmpvar_12;
					  tmpvar_12.x = dot (ot_WaveDirection01.xy, tmpvar_11.xz);
					  tmpvar_12.y = dot (ot_WaveDirection01.zw, tmpvar_11.xz);
					  tmpvar_12.z = dot (ot_WaveDirection23.xy, tmpvar_11.xz);
					  tmpvar_12.w = dot (ot_WaveDirection23.zw, tmpvar_11.xz);
					  highp vec4 tmpvar_13;
					  tmpvar_13.x = ot_WaveDirection01.x;
					  tmpvar_13.y = ot_WaveDirection01.z;
					  tmpvar_13.z = ot_WaveDirection23.x;
					  tmpvar_13.w = ot_WaveDirection23.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = ot_WaveDirection01.y;
					  tmpvar_14.y = ot_WaveDirection01.w;
					  tmpvar_14.z = ot_WaveDirection23.y;
					  tmpvar_14.w = ot_WaveDirection23.w;
					  highp vec4 tmpvar_15;
					  tmpvar_15 = ((sin(
					    ((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants)
					  ) * 0.5) + 0.5);
					  highp vec4 tmpvar_16;
					  tmpvar_16 = cos(((tmpvar_12 + ot_WaveOffsets) * ot_WaveConstants));
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(1.0, 0.0);
					  highp vec4 tmpvar_18;
					  tmpvar_18 = (ot_WaveExponents - 0.99);
					  tmpvar_17.y = dot ((tmpvar_13 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 1.0);
					  tmpvar_19.y = dot ((tmpvar_14 * ot_WaveDerivativeConstants), (pow (tmpvar_15, tmpvar_18) * tmpvar_16));
					  worldVertex_1.y = (ot_OceanPosition + dot (ot_WaveScales, pow (tmpvar_15, ot_WaveExponents)));
					  highp vec4 tmpvar_20;
					  tmpvar_20.w = 1.0;
					  tmpvar_20.xyz = worldVertex_1;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (unity_MatrixVP * tmpvar_20);
					  highp vec4 o_22;
					  highp vec4 tmpvar_23;
					  tmpvar_23 = (tmpvar_21 * 0.5);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_23.x;
					  tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
					  o_22.xy = (tmpvar_24 + tmpvar_23.w);
					  o_22.zw = tmpvar_21.zw;
					  gl_Position = tmpvar_21;
					  xlv_TEXCOORD0 = o_22;
					  xlv_TEXCOORD1 = worldVertex_1;
					  xlv_TEXCOORD2 = normalize(((tmpvar_19.yzx * tmpvar_17.zxy) - (tmpvar_19.zxy * tmpvar_17.yzx)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					#extension GL_EXT_shader_texture_lod : enable
					lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
					{
					#if defined(GL_EXT_shader_texture_lod)
						return textureCubeLodEXT(sampler, coord, lod);
					#else
						return textureCube(sampler, coord, lod);
					#endif
					}
					
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ProjectionParams;
					uniform lowp samplerCube unity_SpecCube0;
					uniform mediump vec4 unity_SpecCube0_HDR;
					uniform sampler2D _CameraDepthNormalsTexture;
					uniform highp vec3 ot_LightDir;
					uniform highp vec3 ot_DeepWaterColor;
					uniform sampler2D ot_NormalMap0;
					uniform sampler2D ot_NormalMap1;
					uniform sampler2D ot_FoamMap;
					uniform highp vec4 ot_NormalMap0_ST;
					uniform highp vec4 ot_NormalMap1_ST;
					uniform highp vec4 ot_FoamMap_ST;
					uniform highp vec4 ot_AbsorptionCoeffs;
					uniform highp float ot_DetailFalloffStart;
					uniform highp float ot_DetailFalloffDistance;
					uniform highp float ot_DetailFalloffNormalGoal;
					uniform highp float ot_AlphaFalloff;
					uniform highp float ot_FoamFalloff;
					uniform highp float ot_FoamStrength;
					uniform highp float ot_FoamAmbient;
					uniform highp float ot_ReflStrength;
					uniform highp float ot_RefrStrength;
					uniform highp vec4 ot_RefrColor;
					uniform highp float ot_FresnelPow;
					uniform highp vec3 ot_SunColor;
					uniform highp float ot_SunPow;
					uniform highp float ot_DeepWaterAmbientBoost;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 fineNormal1_1;
					  highp vec3 fineNormal0_2;
					  highp vec3 normal_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = ((xlv_TEXCOORD1.xz * ot_NormalMap0_ST.xy) + ot_NormalMap0_ST.zw);
					  lowp vec3 tmpvar_5;
					  tmpvar_5 = ((texture2D (ot_NormalMap0, tmpvar_4).xyz * 2.0) - 1.0).xzy;
					  fineNormal0_2 = tmpvar_5;
					  highp vec2 tmpvar_6;
					  tmpvar_6 = ((xlv_TEXCOORD1.xz * ot_NormalMap1_ST.xy) + ot_NormalMap1_ST.zw);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (ot_NormalMap1, tmpvar_6).xyz * 2.0) - 1.0).xzy;
					  fineNormal1_1 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (((xlv_TEXCOORD0.w - ot_DetailFalloffStart) / ot_DetailFalloffDistance), 0.0, 1.0);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(mix ((fineNormal0_2 + fineNormal1_1), vec3(0.0, 2.0, 0.0), vec3(clamp (
					    (tmpvar_8 - ot_DetailFalloffNormalGoal)
					  , 0.0, 1.0))));
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(mix (xlv_TEXCOORD2, vec3(0.0, 1.0, 0.0), vec3(tmpvar_8)));
					  highp vec3 tmpvar_11;
					  tmpvar_11 = ((tmpvar_10.yzx * vec3(1.0, 0.0, 0.0)) - (tmpvar_10.zxy * vec3(0.0, 1.0, 0.0)));
					  normal_3 = (((tmpvar_11 * tmpvar_9.x) + (tmpvar_10 * tmpvar_9.y)) + ((
					    (tmpvar_11.yzx * tmpvar_10.zxy)
					   - 
					    (tmpvar_11.zxy * tmpvar_10.yzx)
					  ) * tmpvar_9.z));
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((xlv_TEXCOORD1 - _WorldSpaceCameraPos));
					  highp vec3 reflDir_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (tmpvar_12 - (2.0 * (
					    dot (normal_3, tmpvar_12)
					   * normal_3)));
					  reflDir_13.xz = tmpvar_14.xz;
					  reflDir_13.y = clamp (tmpvar_14.y, 0.0, 1.0);
					  highp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  mediump vec3 tmpvar_17;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = unity_SpecCube0_HDR;
					  tmpvar_17 = reflDir_13;
					  mediump vec3 tmpvar_19;
					  mediump vec4 hdr_20;
					  hdr_20 = tmpvar_18;
					  mediump vec4 tmpvar_21;
					  tmpvar_21.xyz = tmpvar_17;
					  tmpvar_21.w = ((tmpvar_16 * (1.7 - 
					    (0.7 * tmpvar_16)
					  )) * 6.0);
					  lowp vec4 tmpvar_22;
					  tmpvar_22 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_17, tmpvar_21.w);
					  mediump vec4 tmpvar_23;
					  tmpvar_23 = tmpvar_22;
					  tmpvar_19 = ((hdr_20.x * tmpvar_23.w) * tmpvar_23.xyz);
					  tmpvar_15 = tmpvar_19;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
					  lowp vec4 tmpvar_25;
					  tmpvar_25 = texture2D (_CameraDepthNormalsTexture, tmpvar_24);
					  highp vec4 enc_26;
					  enc_26 = tmpvar_25;
					  highp float tmpvar_27;
					  tmpvar_27 = ((dot (enc_26.zw, vec2(1.0, 0.003921569)) * _ProjectionParams.z) - xlv_TEXCOORD0.w);
					  highp float tmpvar_28;
					  tmpvar_28 = clamp (dot (-(tmpvar_12), normal_3), 0.0, 1.0);
					  highp vec2 tmpvar_29;
					  tmpvar_29 = ((xlv_TEXCOORD1.xz * ot_FoamMap_ST.xy) + ot_FoamMap_ST.zw);
					  lowp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (ot_FoamMap, tmpvar_29);
					  highp float tmpvar_31;
					  tmpvar_31 = (((
					    (1.0 - pow (clamp ((tmpvar_27 / ot_FoamFalloff), 0.0, 1.0), 4.0))
					   * ot_FoamStrength) * clamp (
					    (ot_FoamAmbient + dot (normal_3, ot_LightDir))
					  , 0.0, 1.0)) * tmpvar_30.w);
					  highp float tmpvar_32;
					  tmpvar_32 = pow ((1.0 - tmpvar_28), ot_FresnelPow);
					  highp vec4 tmpvar_33;
					  tmpvar_33.xyz = (((1.0 - tmpvar_31) * (
					    (((tmpvar_32 * ot_ReflStrength) * tmpvar_15) + (((1.0 - tmpvar_32) * ot_RefrStrength) * mix (ot_RefrColor.xyz, (ot_DeepWaterColor * 
					      (1.0 + ((tmpvar_28 * tmpvar_28) * ot_DeepWaterAmbientBoost))
					    ), clamp (
					      (vec3(tmpvar_27) / ot_AbsorptionCoeffs.xyz)
					    , 0.0, 1.0))))
					   + 
					    (pow (clamp (dot (reflDir_13, ot_LightDir), 0.0, 1.0), ot_SunPow) * ot_SunColor)
					  )) + vec3(tmpvar_31));
					  tmpvar_33.w = clamp ((tmpvar_27 / ot_AlphaFalloff), 0.0, 1.0);
					  gl_FragData[0] = tmpvar_33;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					uniform 	float ot_OceanPosition;
					uniform 	vec4 ot_WaveScales;
					uniform 	vec4 ot_WaveExponents;
					uniform 	vec4 ot_WaveOffsets;
					uniform 	vec4 ot_WaveDirection01;
					uniform 	vec4 ot_WaveDirection23;
					uniform 	vec4 ot_WaveConstants;
					uniform 	vec4 ot_WaveDerivativeConstants;
					uniform 	vec4 hlslcc_mtx4ot_Proj[4];
					uniform 	vec4 hlslcc_mtx4ot_InvView[4];
					uniform 	vec3 ot_ViewCorner0;
					uniform 	vec3 ot_ViewCorner1;
					uniform 	vec3 ot_ViewCorner2;
					uniform 	vec3 ot_ViewCorner3;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner2.y;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner2.x + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner2.z + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner1.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner1.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner1.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat8 = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat8 = in_POSITION0.y * u_xlat8 + u_xlat4.x;
					    u_xlat1.xyz = u_xlat4.xxx * ot_ViewCorner1.xyz;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner3.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner3.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner3.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat12 = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner0.y;
					    u_xlat12 = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner0.x + u_xlat12;
					    u_xlat12 = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner0.z + u_xlat12;
					    u_xlat12 = u_xlat12 + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat13 = (-u_xlat12) + u_xlat4.x;
					    u_xlat13 = in_POSITION0.y * u_xlat13 + u_xlat12;
					    u_xlat2.xyz = vec3(u_xlat12) * ot_ViewCorner0.xyz;
					    u_xlat8 = u_xlat8 + (-u_xlat13);
					    u_xlat8 = in_POSITION0.x * u_xlat8 + u_xlat13;
					    u_xlat3.xyz = ot_ViewCorner2.xyz * u_xlat0.xxx + (-u_xlat1.xyz);
					    u_xlat1.xyz = in_POSITION0.yyy * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyw = ot_ViewCorner3.xyz * u_xlat4.xxx + (-u_xlat2.xyz);
					    u_xlat0.xyw = in_POSITION0.yyy * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyw) + u_xlat1.xyz;
					    u_xlat0.xyw = in_POSITION0.xxx * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat0.xyz = u_xlat0.xyw / vec3(u_xlat8);
					    u_xlat4.xz = u_xlat0.yy * hlslcc_mtx4ot_InvView[1].xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[0].xz * u_xlat0.xx + u_xlat4.xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[2].xz * u_xlat0.zz + u_xlat0.xy;
					    u_xlat0.xz = u_xlat0.xy + hlslcc_mtx4ot_InvView[3].xz;
					    u_xlat1.x = dot(ot_WaveDirection01.xy, u_xlat0.xz);
					    u_xlat1.y = dot(ot_WaveDirection01.zw, u_xlat0.xz);
					    u_xlat1.z = dot(ot_WaveDirection23.xy, u_xlat0.xz);
					    u_xlat1.w = dot(ot_WaveDirection23.zw, u_xlat0.xz);
					    u_xlat1 = u_xlat1 + ot_WaveOffsets;
					    u_xlat1 = u_xlat1 * ot_WaveConstants;
					    u_xlat2 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = log2(u_xlat1);
					    u_xlat3 = u_xlat1 * ot_WaveExponents;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat12 = dot(ot_WaveScales, u_xlat3);
					    u_xlat0.y = u_xlat12 + ot_OceanPosition;
					    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat3 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat0 = ot_WaveExponents + vec4(-0.99000001, -0.99000001, -0.99000001, -0.99000001);
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = u_xlat2 * u_xlat0;
					    u_xlat1.xy = ot_WaveDirection01.xz;
					    u_xlat1.zw = ot_WaveDirection23.xz;
					    u_xlat1 = u_xlat1 * ot_WaveDerivativeConstants;
					    u_xlat1.x = dot(u_xlat1, u_xlat0);
					    u_xlat2.xy = ot_WaveDirection01.yw;
					    u_xlat2.zw = ot_WaveDirection23.yw;
					    u_xlat2 = u_xlat2 * ot_WaveDerivativeConstants;
					    u_xlat1.z = dot(u_xlat2, u_xlat0);
					    u_xlat1.y = 0.0;
					    u_xlat0.xyz = (-u_xlat1.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SpecCube0_HDR;
					uniform 	vec3 ot_LightDir;
					uniform 	vec3 ot_DeepWaterColor;
					uniform 	vec4 ot_NormalMap0_ST;
					uniform 	vec4 ot_NormalMap1_ST;
					uniform 	vec4 ot_FoamMap_ST;
					uniform 	vec4 ot_AbsorptionCoeffs;
					uniform 	float ot_DetailFalloffStart;
					uniform 	float ot_DetailFalloffDistance;
					uniform 	float ot_DetailFalloffNormalGoal;
					uniform 	float ot_AlphaFalloff;
					uniform 	float ot_FoamFalloff;
					uniform 	float ot_FoamStrength;
					uniform 	float ot_FoamAmbient;
					uniform 	float ot_ReflStrength;
					uniform 	float ot_RefrStrength;
					uniform 	vec4 ot_RefrColor;
					uniform 	float ot_FresnelPow;
					uniform 	vec3 ot_SunColor;
					uniform 	float ot_SunPow;
					uniform 	float ot_DeepWaterAmbientBoost;
					uniform lowp sampler2D ot_NormalMap0;
					uniform lowp sampler2D ot_NormalMap1;
					uniform lowp sampler2D _CameraDepthNormalsTexture;
					uniform lowp sampler2D ot_FoamMap;
					uniform lowp samplerCube unity_SpecCube0;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec4 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec2 u_xlat10_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat12;
					float u_xlat18;
					float u_xlat20;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap0_ST.xy + ot_NormalMap0_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap0, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap1_ST.xy + ot_NormalMap1_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap1, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat10_1.xyz;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + vec3(0.0, 2.0, 0.0);
					    u_xlat18 = vs_TEXCOORD0.w + (-ot_DetailFalloffStart);
					    u_xlat18 = u_xlat18 / ot_DetailFalloffDistance;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat20 = u_xlat18 + (-ot_DetailFalloffNormalGoal);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
					#else
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat20) * u_xlat16_2.xyz + u_xlat16_0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz + vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * vec3(0.0, 1.0, 0.0);
					    u_xlat4.xyz = u_xlat2.yzx * vec3(1.0, 0.0, 0.0) + (-u_xlat4.xyz);
					    u_xlat0.xyw = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + u_xlat2.xyz;
					    u_xlat18 = dot((-u_xlat2.xyz), u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, ot_LightDir.xyz);
					    u_xlat0.x = u_xlat0.x + ot_FoamAmbient;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat1.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
					#else
					    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
					#endif
					    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat1.xwz, 0.0);
					    u_xlat6.x = dot(u_xlat1.xwz, ot_LightDir.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * ot_SunPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat16_5.x = u_xlat10_2.w * unity_SpecCube0_HDR.x;
					    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
					    u_xlat12 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat18 = u_xlat18 * ot_DeepWaterAmbientBoost + 1.0;
					    u_xlat2.xyz = ot_DeepWaterColor.xyz * vec3(u_xlat18) + (-ot_RefrColor.xyz);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * ot_FresnelPow;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat18 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * ot_ReflStrength;
					    u_xlat18 = u_xlat18 * ot_RefrStrength;
					    u_xlat3.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_3.xy = texture(_CameraDepthNormalsTexture, u_xlat3.xy).zw;
					    u_xlat16_20 = dot(u_xlat10_3.xy, vec2(1.0, 0.00392156886));
					    u_xlat20 = u_xlat16_20 * _ProjectionParams.z + (-vs_TEXCOORD0.w);
					    u_xlat3.xyz = vec3(u_xlat20) / ot_AbsorptionCoeffs.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
					#else
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					#endif
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz + ot_RefrColor.xyz;
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_5.xyz + u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat6.xxx * ot_SunColor.xyz + u_xlat2.xyz;
					    u_xlat2.x = u_xlat20 / ot_FoamFalloff;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
					#else
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					#endif
					    SV_Target0.w = u_xlat20 / ot_AlphaFalloff;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * ot_FoamStrength;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat2.xy = vs_TEXCOORD1.xz * ot_FoamMap_ST.xy + ot_FoamMap_ST.zw;
					    u_xlat10_2.x = texture(ot_FoamMap, u_xlat2.xy).w;
					    u_xlat8 = u_xlat0.x * u_xlat10_2.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat10_2.x + 1.0;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz + vec3(u_xlat8);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					uniform 	float ot_OceanPosition;
					uniform 	vec4 ot_WaveScales;
					uniform 	vec4 ot_WaveExponents;
					uniform 	vec4 ot_WaveOffsets;
					uniform 	vec4 ot_WaveDirection01;
					uniform 	vec4 ot_WaveDirection23;
					uniform 	vec4 ot_WaveConstants;
					uniform 	vec4 ot_WaveDerivativeConstants;
					uniform 	vec4 hlslcc_mtx4ot_Proj[4];
					uniform 	vec4 hlslcc_mtx4ot_InvView[4];
					uniform 	vec3 ot_ViewCorner0;
					uniform 	vec3 ot_ViewCorner1;
					uniform 	vec3 ot_ViewCorner2;
					uniform 	vec3 ot_ViewCorner3;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner2.y;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner2.x + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner2.z + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner1.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner1.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner1.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat8 = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat8 = in_POSITION0.y * u_xlat8 + u_xlat4.x;
					    u_xlat1.xyz = u_xlat4.xxx * ot_ViewCorner1.xyz;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner3.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner3.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner3.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat12 = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner0.y;
					    u_xlat12 = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner0.x + u_xlat12;
					    u_xlat12 = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner0.z + u_xlat12;
					    u_xlat12 = u_xlat12 + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat13 = (-u_xlat12) + u_xlat4.x;
					    u_xlat13 = in_POSITION0.y * u_xlat13 + u_xlat12;
					    u_xlat2.xyz = vec3(u_xlat12) * ot_ViewCorner0.xyz;
					    u_xlat8 = u_xlat8 + (-u_xlat13);
					    u_xlat8 = in_POSITION0.x * u_xlat8 + u_xlat13;
					    u_xlat3.xyz = ot_ViewCorner2.xyz * u_xlat0.xxx + (-u_xlat1.xyz);
					    u_xlat1.xyz = in_POSITION0.yyy * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyw = ot_ViewCorner3.xyz * u_xlat4.xxx + (-u_xlat2.xyz);
					    u_xlat0.xyw = in_POSITION0.yyy * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyw) + u_xlat1.xyz;
					    u_xlat0.xyw = in_POSITION0.xxx * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat0.xyz = u_xlat0.xyw / vec3(u_xlat8);
					    u_xlat4.xz = u_xlat0.yy * hlslcc_mtx4ot_InvView[1].xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[0].xz * u_xlat0.xx + u_xlat4.xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[2].xz * u_xlat0.zz + u_xlat0.xy;
					    u_xlat0.xz = u_xlat0.xy + hlslcc_mtx4ot_InvView[3].xz;
					    u_xlat1.x = dot(ot_WaveDirection01.xy, u_xlat0.xz);
					    u_xlat1.y = dot(ot_WaveDirection01.zw, u_xlat0.xz);
					    u_xlat1.z = dot(ot_WaveDirection23.xy, u_xlat0.xz);
					    u_xlat1.w = dot(ot_WaveDirection23.zw, u_xlat0.xz);
					    u_xlat1 = u_xlat1 + ot_WaveOffsets;
					    u_xlat1 = u_xlat1 * ot_WaveConstants;
					    u_xlat2 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = log2(u_xlat1);
					    u_xlat3 = u_xlat1 * ot_WaveExponents;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat12 = dot(ot_WaveScales, u_xlat3);
					    u_xlat0.y = u_xlat12 + ot_OceanPosition;
					    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat3 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat0 = ot_WaveExponents + vec4(-0.99000001, -0.99000001, -0.99000001, -0.99000001);
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = u_xlat2 * u_xlat0;
					    u_xlat1.xy = ot_WaveDirection01.xz;
					    u_xlat1.zw = ot_WaveDirection23.xz;
					    u_xlat1 = u_xlat1 * ot_WaveDerivativeConstants;
					    u_xlat1.x = dot(u_xlat1, u_xlat0);
					    u_xlat2.xy = ot_WaveDirection01.yw;
					    u_xlat2.zw = ot_WaveDirection23.yw;
					    u_xlat2 = u_xlat2 * ot_WaveDerivativeConstants;
					    u_xlat1.z = dot(u_xlat2, u_xlat0);
					    u_xlat1.y = 0.0;
					    u_xlat0.xyz = (-u_xlat1.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SpecCube0_HDR;
					uniform 	vec3 ot_LightDir;
					uniform 	vec3 ot_DeepWaterColor;
					uniform 	vec4 ot_NormalMap0_ST;
					uniform 	vec4 ot_NormalMap1_ST;
					uniform 	vec4 ot_FoamMap_ST;
					uniform 	vec4 ot_AbsorptionCoeffs;
					uniform 	float ot_DetailFalloffStart;
					uniform 	float ot_DetailFalloffDistance;
					uniform 	float ot_DetailFalloffNormalGoal;
					uniform 	float ot_AlphaFalloff;
					uniform 	float ot_FoamFalloff;
					uniform 	float ot_FoamStrength;
					uniform 	float ot_FoamAmbient;
					uniform 	float ot_ReflStrength;
					uniform 	float ot_RefrStrength;
					uniform 	vec4 ot_RefrColor;
					uniform 	float ot_FresnelPow;
					uniform 	vec3 ot_SunColor;
					uniform 	float ot_SunPow;
					uniform 	float ot_DeepWaterAmbientBoost;
					uniform lowp sampler2D ot_NormalMap0;
					uniform lowp sampler2D ot_NormalMap1;
					uniform lowp sampler2D _CameraDepthNormalsTexture;
					uniform lowp sampler2D ot_FoamMap;
					uniform lowp samplerCube unity_SpecCube0;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec4 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec2 u_xlat10_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat12;
					float u_xlat18;
					float u_xlat20;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap0_ST.xy + ot_NormalMap0_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap0, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap1_ST.xy + ot_NormalMap1_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap1, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat10_1.xyz;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + vec3(0.0, 2.0, 0.0);
					    u_xlat18 = vs_TEXCOORD0.w + (-ot_DetailFalloffStart);
					    u_xlat18 = u_xlat18 / ot_DetailFalloffDistance;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat20 = u_xlat18 + (-ot_DetailFalloffNormalGoal);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
					#else
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat20) * u_xlat16_2.xyz + u_xlat16_0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz + vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * vec3(0.0, 1.0, 0.0);
					    u_xlat4.xyz = u_xlat2.yzx * vec3(1.0, 0.0, 0.0) + (-u_xlat4.xyz);
					    u_xlat0.xyw = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + u_xlat2.xyz;
					    u_xlat18 = dot((-u_xlat2.xyz), u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, ot_LightDir.xyz);
					    u_xlat0.x = u_xlat0.x + ot_FoamAmbient;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat1.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
					#else
					    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
					#endif
					    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat1.xwz, 0.0);
					    u_xlat6.x = dot(u_xlat1.xwz, ot_LightDir.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * ot_SunPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat16_5.x = u_xlat10_2.w * unity_SpecCube0_HDR.x;
					    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
					    u_xlat12 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat18 = u_xlat18 * ot_DeepWaterAmbientBoost + 1.0;
					    u_xlat2.xyz = ot_DeepWaterColor.xyz * vec3(u_xlat18) + (-ot_RefrColor.xyz);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * ot_FresnelPow;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat18 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * ot_ReflStrength;
					    u_xlat18 = u_xlat18 * ot_RefrStrength;
					    u_xlat3.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_3.xy = texture(_CameraDepthNormalsTexture, u_xlat3.xy).zw;
					    u_xlat16_20 = dot(u_xlat10_3.xy, vec2(1.0, 0.00392156886));
					    u_xlat20 = u_xlat16_20 * _ProjectionParams.z + (-vs_TEXCOORD0.w);
					    u_xlat3.xyz = vec3(u_xlat20) / ot_AbsorptionCoeffs.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
					#else
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					#endif
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz + ot_RefrColor.xyz;
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_5.xyz + u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat6.xxx * ot_SunColor.xyz + u_xlat2.xyz;
					    u_xlat2.x = u_xlat20 / ot_FoamFalloff;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
					#else
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					#endif
					    SV_Target0.w = u_xlat20 / ot_AlphaFalloff;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * ot_FoamStrength;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat2.xy = vs_TEXCOORD1.xz * ot_FoamMap_ST.xy + ot_FoamMap_ST.zw;
					    u_xlat10_2.x = texture(ot_FoamMap, u_xlat2.xy).w;
					    u_xlat8 = u_xlat0.x * u_xlat10_2.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat10_2.x + 1.0;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz + vec3(u_xlat8);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_MatrixVP[4];
					uniform 	float ot_OceanPosition;
					uniform 	vec4 ot_WaveScales;
					uniform 	vec4 ot_WaveExponents;
					uniform 	vec4 ot_WaveOffsets;
					uniform 	vec4 ot_WaveDirection01;
					uniform 	vec4 ot_WaveDirection23;
					uniform 	vec4 ot_WaveConstants;
					uniform 	vec4 ot_WaveDerivativeConstants;
					uniform 	vec4 hlslcc_mtx4ot_Proj[4];
					uniform 	vec4 hlslcc_mtx4ot_InvView[4];
					uniform 	vec3 ot_ViewCorner0;
					uniform 	vec3 ot_ViewCorner1;
					uniform 	vec3 ot_ViewCorner2;
					uniform 	vec3 ot_ViewCorner3;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat8;
					float u_xlat12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner2.y;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner2.x + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner2.z + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner1.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner1.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner1.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat8 = (-u_xlat4.x) + u_xlat0.x;
					    u_xlat8 = in_POSITION0.y * u_xlat8 + u_xlat4.x;
					    u_xlat1.xyz = u_xlat4.xxx * ot_ViewCorner1.xyz;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner3.y;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner3.x + u_xlat4.x;
					    u_xlat4.x = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner3.z + u_xlat4.x;
					    u_xlat4.x = u_xlat4.x + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat4.x = float(1.0) / u_xlat4.x;
					    u_xlat12 = hlslcc_mtx4ot_Proj[1].w * ot_ViewCorner0.y;
					    u_xlat12 = hlslcc_mtx4ot_Proj[0].w * ot_ViewCorner0.x + u_xlat12;
					    u_xlat12 = hlslcc_mtx4ot_Proj[2].w * ot_ViewCorner0.z + u_xlat12;
					    u_xlat12 = u_xlat12 + hlslcc_mtx4ot_Proj[3].w;
					    u_xlat12 = float(1.0) / u_xlat12;
					    u_xlat13 = (-u_xlat12) + u_xlat4.x;
					    u_xlat13 = in_POSITION0.y * u_xlat13 + u_xlat12;
					    u_xlat2.xyz = vec3(u_xlat12) * ot_ViewCorner0.xyz;
					    u_xlat8 = u_xlat8 + (-u_xlat13);
					    u_xlat8 = in_POSITION0.x * u_xlat8 + u_xlat13;
					    u_xlat3.xyz = ot_ViewCorner2.xyz * u_xlat0.xxx + (-u_xlat1.xyz);
					    u_xlat1.xyz = in_POSITION0.yyy * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyw = ot_ViewCorner3.xyz * u_xlat4.xxx + (-u_xlat2.xyz);
					    u_xlat0.xyw = in_POSITION0.yyy * u_xlat0.xyw + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyw) + u_xlat1.xyz;
					    u_xlat0.xyw = in_POSITION0.xxx * u_xlat1.xyz + u_xlat0.xyw;
					    u_xlat0.xyz = u_xlat0.xyw / vec3(u_xlat8);
					    u_xlat4.xz = u_xlat0.yy * hlslcc_mtx4ot_InvView[1].xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[0].xz * u_xlat0.xx + u_xlat4.xz;
					    u_xlat0.xy = hlslcc_mtx4ot_InvView[2].xz * u_xlat0.zz + u_xlat0.xy;
					    u_xlat0.xz = u_xlat0.xy + hlslcc_mtx4ot_InvView[3].xz;
					    u_xlat1.x = dot(ot_WaveDirection01.xy, u_xlat0.xz);
					    u_xlat1.y = dot(ot_WaveDirection01.zw, u_xlat0.xz);
					    u_xlat1.z = dot(ot_WaveDirection23.xy, u_xlat0.xz);
					    u_xlat1.w = dot(ot_WaveDirection23.zw, u_xlat0.xz);
					    u_xlat1 = u_xlat1 + ot_WaveOffsets;
					    u_xlat1 = u_xlat1 * ot_WaveConstants;
					    u_xlat2 = cos(u_xlat1);
					    u_xlat1 = sin(u_xlat1);
					    u_xlat1 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = log2(u_xlat1);
					    u_xlat3 = u_xlat1 * ot_WaveExponents;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat12 = dot(ot_WaveScales, u_xlat3);
					    u_xlat0.y = u_xlat12 + ot_OceanPosition;
					    u_xlat3 = u_xlat0.yyyy * hlslcc_mtx4unity_MatrixVP[1];
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat3 = hlslcc_mtx4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat3;
					    u_xlat0 = hlslcc_mtx4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_MatrixVP[3];
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD0.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat0 = ot_WaveExponents + vec4(-0.99000001, -0.99000001, -0.99000001, -0.99000001);
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = u_xlat2 * u_xlat0;
					    u_xlat1.xy = ot_WaveDirection01.xz;
					    u_xlat1.zw = ot_WaveDirection23.xz;
					    u_xlat1 = u_xlat1 * ot_WaveDerivativeConstants;
					    u_xlat1.x = dot(u_xlat1, u_xlat0);
					    u_xlat2.xy = ot_WaveDirection01.yw;
					    u_xlat2.zw = ot_WaveDirection23.yw;
					    u_xlat2 = u_xlat2 * ot_WaveDerivativeConstants;
					    u_xlat1.z = dot(u_xlat2, u_xlat0);
					    u_xlat1.y = 0.0;
					    u_xlat0.xyz = (-u_xlat1.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD2.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ProjectionParams;
					uniform 	mediump vec4 unity_SpecCube0_HDR;
					uniform 	vec3 ot_LightDir;
					uniform 	vec3 ot_DeepWaterColor;
					uniform 	vec4 ot_NormalMap0_ST;
					uniform 	vec4 ot_NormalMap1_ST;
					uniform 	vec4 ot_FoamMap_ST;
					uniform 	vec4 ot_AbsorptionCoeffs;
					uniform 	float ot_DetailFalloffStart;
					uniform 	float ot_DetailFalloffDistance;
					uniform 	float ot_DetailFalloffNormalGoal;
					uniform 	float ot_AlphaFalloff;
					uniform 	float ot_FoamFalloff;
					uniform 	float ot_FoamStrength;
					uniform 	float ot_FoamAmbient;
					uniform 	float ot_ReflStrength;
					uniform 	float ot_RefrStrength;
					uniform 	vec4 ot_RefrColor;
					uniform 	float ot_FresnelPow;
					uniform 	vec3 ot_SunColor;
					uniform 	float ot_SunPow;
					uniform 	float ot_DeepWaterAmbientBoost;
					uniform lowp sampler2D ot_NormalMap0;
					uniform lowp sampler2D ot_NormalMap1;
					uniform lowp sampler2D _CameraDepthNormalsTexture;
					uniform lowp sampler2D ot_FoamMap;
					uniform lowp samplerCube unity_SpecCube0;
					in highp vec4 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp vec4 u_xlat10_2;
					vec3 u_xlat3;
					lowp vec2 u_xlat10_3;
					vec3 u_xlat4;
					mediump vec3 u_xlat16_5;
					vec3 u_xlat6;
					float u_xlat8;
					float u_xlat12;
					float u_xlat18;
					float u_xlat20;
					mediump float u_xlat16_20;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap0_ST.xy + ot_NormalMap0_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap0, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0.xy = vs_TEXCOORD1.xz * ot_NormalMap1_ST.xy + ot_NormalMap1_ST.zw;
					    u_xlat10_0.xyz = texture(ot_NormalMap1, u_xlat0.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xzy * vec3(2.0, 2.0, 2.0) + u_xlat10_1.xyz;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + vec3(-1.0, -1.0, -1.0);
					    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + vec3(0.0, 2.0, 0.0);
					    u_xlat18 = vs_TEXCOORD0.w + (-ot_DetailFalloffStart);
					    u_xlat18 = u_xlat18 / ot_DetailFalloffDistance;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat20 = u_xlat18 + (-ot_DetailFalloffNormalGoal);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
					#else
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat20) * u_xlat16_2.xyz + u_xlat16_0.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.xyz = (-vs_TEXCOORD2.xyz) + vec3(0.0, 1.0, 0.0);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz + vs_TEXCOORD2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.yyy * u_xlat2.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * vec3(0.0, 1.0, 0.0);
					    u_xlat4.xyz = u_xlat2.yzx * vec3(1.0, 0.0, 0.0) + (-u_xlat4.xyz);
					    u_xlat0.xyw = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat4.zxy;
					    u_xlat2.xyz = u_xlat4.yzx * u_xlat2.zxy + (-u_xlat3.xyz);
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat2.xyz = vs_TEXCOORD1.xyz + (-_WorldSpaceCameraPos.xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat0.xyz * (-vec3(u_xlat18)) + u_xlat2.xyz;
					    u_xlat18 = dot((-u_xlat2.xyz), u_xlat0.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
					#else
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					#endif
					    u_xlat0.x = dot(u_xlat0.xyz, ot_LightDir.xyz);
					    u_xlat0.x = u_xlat0.x + ot_FoamAmbient;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat1.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
					#else
					    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
					#endif
					    u_xlat10_2 = textureLod(unity_SpecCube0, u_xlat1.xwz, 0.0);
					    u_xlat6.x = dot(u_xlat1.xwz, ot_LightDir.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.x = log2(u_xlat6.x);
					    u_xlat6.x = u_xlat6.x * ot_SunPow;
					    u_xlat6.x = exp2(u_xlat6.x);
					    u_xlat16_5.x = u_xlat10_2.w * unity_SpecCube0_HDR.x;
					    u_xlat16_5.xyz = u_xlat10_2.xyz * u_xlat16_5.xxx;
					    u_xlat12 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat18 = u_xlat18 * ot_DeepWaterAmbientBoost + 1.0;
					    u_xlat2.xyz = ot_DeepWaterColor.xyz * vec3(u_xlat18) + (-ot_RefrColor.xyz);
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * ot_FresnelPow;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat18 = (-u_xlat12) + 1.0;
					    u_xlat12 = u_xlat12 * ot_ReflStrength;
					    u_xlat18 = u_xlat18 * ot_RefrStrength;
					    u_xlat3.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
					    u_xlat10_3.xy = texture(_CameraDepthNormalsTexture, u_xlat3.xy).zw;
					    u_xlat16_20 = dot(u_xlat10_3.xy, vec2(1.0, 0.00392156886));
					    u_xlat20 = u_xlat16_20 * _ProjectionParams.z + (-vs_TEXCOORD0.w);
					    u_xlat3.xyz = vec3(u_xlat20) / ot_AbsorptionCoeffs.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.xyz = min(max(u_xlat3.xyz, 0.0), 1.0);
					#else
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					#endif
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz + ot_RefrColor.xyz;
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat16_5.xyz + u_xlat2.xyz;
					    u_xlat6.xyz = u_xlat6.xxx * ot_SunColor.xyz + u_xlat2.xyz;
					    u_xlat2.x = u_xlat20 / ot_FoamFalloff;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
					#else
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					#endif
					    SV_Target0.w = u_xlat20 / ot_AlphaFalloff;
					#ifdef UNITY_ADRENO_ES3
					    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
					#else
					    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
					#endif
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat2.x = (-u_xlat2.x) * u_xlat2.x + 1.0;
					    u_xlat2.x = u_xlat2.x * ot_FoamStrength;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat2.xy = vs_TEXCOORD1.xz * ot_FoamMap_ST.xy + ot_FoamMap_ST.zw;
					    u_xlat10_2.x = texture(ot_FoamMap, u_xlat2.xy).w;
					    u_xlat8 = u_xlat0.x * u_xlat10_2.x;
					    u_xlat0.x = (-u_xlat0.x) * u_xlat10_2.x + 1.0;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat6.xyz + vec3(u_xlat8);
					    return;
					}
					#endif"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "OT_REFL_SKY_ONLY" "OT_REFR_COLOR" }
					"!!GLES3"
}
}
 }
}
CustomEditor "OceanToolkit.OceanShaderEditor"
}