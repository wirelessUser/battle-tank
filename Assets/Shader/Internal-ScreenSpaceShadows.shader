Shader "Hidden/Internal-ScreenSpaceShadows" {
Properties {
 _ShadowMapTexture ("", any) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 1194
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  highp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  mediump float tmpvar_12;
					  if ((tmpvar_11.x < tmpvar_10.z)) {
					    tmpvar_12 = 0.0;
					  } else {
					    tmpvar_12 = 1.0;
					  };
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = vec4(shadow_2);
					  res_1 = tmpvar_14;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  highp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  mediump float tmpvar_12;
					  if ((tmpvar_11.x < tmpvar_10.z)) {
					    tmpvar_12 = 0.0;
					  } else {
					    tmpvar_12 = 1.0;
					  };
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = vec4(shadow_2);
					  res_1 = tmpvar_14;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  highp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  mediump float tmpvar_12;
					  if ((tmpvar_11.x < tmpvar_10.z)) {
					    tmpvar_12 = 0.0;
					  } else {
					    tmpvar_12 = 1.0;
					  };
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_12) + tmpvar_13);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = vec4(shadow_2);
					  res_1 = tmpvar_14;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat5.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat10_1.yyy * u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat5.xyz;
					    vec3 txVec624 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec624, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat5.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat10_1.yyy * u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat5.xyz;
					    vec3 txVec618 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec618, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					bvec4 u_xlatb2;
					vec3 u_xlat3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat5.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat10_1.yyy * u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat5.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat5.xyz;
					    vec3 txVec665 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec665, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  mediump float tmpvar_16;
					  if ((tmpvar_15.x < tmpvar_14.z)) {
					    tmpvar_16 = 0.0;
					  } else {
					    tmpvar_16 = 1.0;
					  };
					  highp float tmpvar_17;
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = clamp (((
					    sqrt(dot (tmpvar_18, tmpvar_18))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  tmpvar_17 = tmpvar_19;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = vec4(shadow_2);
					  res_1 = tmpvar_21;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  mediump float tmpvar_16;
					  if ((tmpvar_15.x < tmpvar_14.z)) {
					    tmpvar_16 = 0.0;
					  } else {
					    tmpvar_16 = 1.0;
					  };
					  highp float tmpvar_17;
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = clamp (((
					    sqrt(dot (tmpvar_18, tmpvar_18))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  tmpvar_17 = tmpvar_19;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = vec4(shadow_2);
					  res_1 = tmpvar_21;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  highp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  mediump float tmpvar_16;
					  if ((tmpvar_15.x < tmpvar_14.z)) {
					    tmpvar_16 = 0.0;
					  } else {
					    tmpvar_16 = 1.0;
					  };
					  highp float tmpvar_17;
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_19;
					  highp float tmpvar_20;
					  tmpvar_20 = clamp (((
					    sqrt(dot (tmpvar_18, tmpvar_18))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_19 = tmpvar_20;
					  tmpvar_17 = tmpvar_19;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_16) + tmpvar_17);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = vec4(shadow_2);
					  res_1 = tmpvar_21;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat10_3.xxx * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    vec3 txVec625 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec625, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat10_3.xxx * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    vec3 txVec666 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec666, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bvec4 u_xlatb1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_3;
					mediump float u_xlat16_4;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat5.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat5.x = float(1.0) / u_xlat5.x;
					    u_xlat10 = (-u_xlat5.x) + u_xlat0.x;
					    u_xlat5.x = unity_OrthoParams.w * u_xlat10 + u_xlat5.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat5.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat5.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat10_3.xxx * u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat6.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    vec3 txVec619 = vec3(u_xlat5.xy,u_xlat5.z);
					    u_xlat10_5 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec619, 0.0);
					    u_xlat16_4 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_4 = u_xlat10_5 * u_xlat16_4 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_4);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = vec4(shadow_2);
					  res_1 = tmpvar_10;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = vec4(shadow_2);
					  res_1 = tmpvar_10;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  tmpvar_9 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = vec4(shadow_2);
					  res_1 = tmpvar_10;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat6 = (-u_xlat3.x) + u_xlat0.x;
					    u_xlat3.x = unity_OrthoParams.w * u_xlat6 + u_xlat3.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat3.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat3.xyz;
					    vec3 txVec586 = vec3(u_xlat3.xy,u_xlat3.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec586, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat6 = (-u_xlat3.x) + u_xlat0.x;
					    u_xlat3.x = unity_OrthoParams.w * u_xlat6 + u_xlat3.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat3.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat3.xyz;
					    vec3 txVec667 = vec3(u_xlat3.xy,u_xlat3.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec667, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3.x = float(1.0) / u_xlat3.x;
					    u_xlat6 = (-u_xlat3.x) + u_xlat0.x;
					    u_xlat3.x = unity_OrthoParams.w * u_xlat6 + u_xlat3.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat3.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat3.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat3.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat3.xyz;
					    vec3 txVec620 = vec3(u_xlat3.xy,u_xlat3.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec620, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((
					    sqrt(dot (tmpvar_10, tmpvar_10))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_11 = tmpvar_12;
					  tmpvar_9 = tmpvar_11;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = vec4(shadow_2);
					  res_1 = tmpvar_13;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((
					    sqrt(dot (tmpvar_10, tmpvar_10))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_11 = tmpvar_12;
					  tmpvar_9 = tmpvar_11;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = vec4(shadow_2);
					  res_1 = tmpvar_13;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 res_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  highp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  mediump float tmpvar_8;
					  if ((tmpvar_7.x < tmpvar_6.z)) {
					    tmpvar_8 = 0.0;
					  } else {
					    tmpvar_8 = 1.0;
					  };
					  highp float tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((
					    sqrt(dot (tmpvar_10, tmpvar_10))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_11 = tmpvar_12;
					  tmpvar_9 = tmpvar_11;
					  shadow_2 = (mix (_LightShadowData.x, 1.0, tmpvar_8) + tmpvar_9);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = vec4(shadow_2);
					  res_1 = tmpvar_13;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat6 = (-u_xlat3) + u_xlat0.x;
					    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
					    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vec3 txVec668 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec668, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat6 = (-u_xlat3) + u_xlat0.x;
					    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
					    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vec3 txVec621 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec621, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat3 = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat3 = float(1.0) / u_xlat3;
					    u_xlat6 = (-u_xlat3) + u_xlat0.x;
					    u_xlat3 = unity_OrthoParams.w * u_xlat6 + u_xlat3;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * vec3(u_xlat3) + u_xlat0.xzw;
					    u_xlat1.xyz = vec3(u_xlat3) * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vec3 txVec626 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat10_3 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec626, 0.0);
					    u_xlat16_2 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_2 = u_xlat10_3 * u_xlat16_2 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + vec4(u_xlat16_2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
"!!GLES"
}
SubProgram "gles hw_tier02 " {
"!!GLES"
}
SubProgram "gles hw_tier03 " {
"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "ShadowmapFilter"="PCF_5x5" }
 Pass {
  Tags { "ShadowmapFilter"="PCF_5x5" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 88306
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  mediump float shadow_11;
					  shadow_11 = 0.0;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_13.z = tmpvar_10.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  mediump float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_10.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_11 = tmpvar_15;
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = 0.0;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_10.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_10.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_11 = (tmpvar_15 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_10.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_10.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.y = 0.0;
					  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_10.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_10.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_27);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_10.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.y = 0.0;
					  tmpvar_30.x = tmpvar_12.x;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_10.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_10.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_34.y = tmpvar_12.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_10.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_10.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = 0.0;
					  tmpvar_38.y = tmpvar_12.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_10.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_10.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_41);
					  highp vec3 tmpvar_42;
					  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_42.z = tmpvar_10.z;
					  highp vec4 tmpvar_43;
					  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
					  highp float tmpvar_44;
					  if ((tmpvar_43.x < tmpvar_10.z)) {
					    tmpvar_44 = 0.0;
					  } else {
					    tmpvar_44 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_44);
					  shadow_11 = (shadow_11 / 9.0);
					  mediump float tmpvar_45;
					  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
					  shadow_11 = tmpvar_45;
					  highp float tmpvar_46;
					  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_45 + tmpvar_46);
					  mediump vec4 tmpvar_47;
					  tmpvar_47 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_47;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  mediump float shadow_11;
					  shadow_11 = 0.0;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_13.z = tmpvar_10.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  mediump float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_10.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_11 = tmpvar_15;
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = 0.0;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_10.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_10.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_11 = (tmpvar_15 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_10.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_10.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.y = 0.0;
					  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_10.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_10.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_27);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_10.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.y = 0.0;
					  tmpvar_30.x = tmpvar_12.x;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_10.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_10.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_34.y = tmpvar_12.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_10.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_10.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = 0.0;
					  tmpvar_38.y = tmpvar_12.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_10.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_10.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_41);
					  highp vec3 tmpvar_42;
					  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_42.z = tmpvar_10.z;
					  highp vec4 tmpvar_43;
					  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
					  highp float tmpvar_44;
					  if ((tmpvar_43.x < tmpvar_10.z)) {
					    tmpvar_44 = 0.0;
					  } else {
					    tmpvar_44 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_44);
					  shadow_11 = (shadow_11 / 9.0);
					  mediump float tmpvar_45;
					  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
					  shadow_11 = tmpvar_45;
					  highp float tmpvar_46;
					  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_45 + tmpvar_46);
					  mediump vec4 tmpvar_47;
					  tmpvar_47 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_47;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 _LightSplitsNear;
					uniform highp vec4 _LightSplitsFar;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_CameraToWorld * tmpvar_5);
					  bvec4 tmpvar_7;
					  tmpvar_7 = greaterThanEqual (tmpvar_4.zzzz, _LightSplitsNear);
					  bvec4 tmpvar_8;
					  tmpvar_8 = lessThan (tmpvar_4.zzzz, _LightSplitsFar);
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = (vec4(tmpvar_7) * vec4(tmpvar_8));
					  highp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_6).xyz * tmpvar_9.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_6).xyz * tmpvar_9.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_6)
					  .xyz * tmpvar_9.z)) + ((unity_WorldToShadow[3] * tmpvar_6).xyz * tmpvar_9.w));
					  mediump float shadow_11;
					  shadow_11 = 0.0;
					  highp vec2 tmpvar_12;
					  tmpvar_12 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_10.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_13.z = tmpvar_10.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  mediump float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_10.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_11 = tmpvar_15;
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = 0.0;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_10.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_10.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_10.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_11 = (tmpvar_15 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_10.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_10.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_10.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.y = 0.0;
					  tmpvar_24.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_10.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_10.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_10.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_27);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_10.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_10.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.y = 0.0;
					  tmpvar_30.x = tmpvar_12.x;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_10.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_10.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_10.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_34.y = tmpvar_12.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_10.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_10.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_10.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = 0.0;
					  tmpvar_38.y = tmpvar_12.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_10.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_10.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_10.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_41);
					  highp vec3 tmpvar_42;
					  tmpvar_42.xy = (tmpvar_10.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_42.z = tmpvar_10.z;
					  highp vec4 tmpvar_43;
					  tmpvar_43 = texture2D (_ShadowMapTexture, tmpvar_42.xy);
					  highp float tmpvar_44;
					  if ((tmpvar_43.x < tmpvar_10.z)) {
					    tmpvar_44 = 0.0;
					  } else {
					    tmpvar_44 = 1.0;
					  };
					  shadow_11 = (shadow_11 + tmpvar_44);
					  shadow_11 = (shadow_11 / 9.0);
					  mediump float tmpvar_45;
					  tmpvar_45 = mix (_LightShadowData.x, 1.0, shadow_11);
					  shadow_11 = tmpvar_45;
					  highp float tmpvar_46;
					  tmpvar_46 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_45 + tmpvar_46);
					  mediump vec4 tmpvar_47;
					  tmpvar_47 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_47;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					lowp float u_xlat10_18;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat10_1.yyy * u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat8.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat1.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat1.y;
					    u_xlat18.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat8.xy / u_xlat18.xy;
					    u_xlat4.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat1.w = u_xlat4.x;
					    u_xlat3.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat3.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat1.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat1.zxw * u_xlat7.yxz;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec587 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec587, 0.0);
					    vec3 txVec588 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec588, 0.0);
					    vec3 txVec589 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec589, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat18.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat18.x = u_xlat10_18 * u_xlat3.y;
					    u_xlat16 = u_xlat3.x * u_xlat10_16 + u_xlat18.x;
					    u_xlat8.x = u_xlat3.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec590 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec590, 0.0);
					    vec3 txVec591 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec591, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec592 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec592, 0.0);
					    vec3 txVec593 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec593, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_2 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_18 + u_xlat8.x;
					    vec3 txVec594 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec594, 0.0);
					    vec3 txVec595 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec595, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					lowp float u_xlat10_18;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat10_1.yyy * u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat8.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat1.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat1.y;
					    u_xlat18.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat8.xy / u_xlat18.xy;
					    u_xlat4.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat1.w = u_xlat4.x;
					    u_xlat3.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat3.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat1.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat1.zxw * u_xlat7.yxz;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec669 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec669, 0.0);
					    vec3 txVec670 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec670, 0.0);
					    vec3 txVec671 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec671, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat18.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat18.x = u_xlat10_18 * u_xlat3.y;
					    u_xlat16 = u_xlat3.x * u_xlat10_16 + u_xlat18.x;
					    u_xlat8.x = u_xlat3.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec672 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec672, 0.0);
					    vec3 txVec673 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec673, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec674 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec674, 0.0);
					    vec3 txVec675 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec675, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_2 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_18 + u_xlat8.x;
					    vec3 txVec676 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec676, 0.0);
					    vec3 txVec677 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec677, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 _LightSplitsNear;
					uniform 	vec4 _LightSplitsFar;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec4 u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bvec4 u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					lowp float u_xlat10_18;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlatb1 = greaterThanEqual(u_xlat0.zzzz, _LightSplitsNear);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlatb2 = lessThan(u_xlat0.zzzz, _LightSplitsFar);
					    u_xlat2 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb2));
					    u_xlat10_1 = u_xlat1 * u_xlat2;
					    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0.x = u_xlat0.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat8.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat2.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat2.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat2.www + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat10_1.yyy * u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.xxx + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat2.www + u_xlat3.xyz;
					    u_xlat8.xyz = u_xlat3.xyz * u_xlat10_1.zzz + u_xlat8.xyz;
					    u_xlat3.xyz = u_xlat2.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat3.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat2.zzz + u_xlat3.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat2.www + u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_1.www + u_xlat8.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat2.xy = u_xlat2.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat1.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat1.y;
					    u_xlat18.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat8.xy / u_xlat18.xy;
					    u_xlat4.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat1.w = u_xlat4.x;
					    u_xlat3.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat3.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat1.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat1.zxw * u_xlat7.yxz;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec627 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec627, 0.0);
					    vec3 txVec628 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec628, 0.0);
					    vec3 txVec629 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec629, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat18.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat18.x = u_xlat10_18 * u_xlat3.y;
					    u_xlat16 = u_xlat3.x * u_xlat10_16 + u_xlat18.x;
					    u_xlat8.x = u_xlat3.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec630 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec630, 0.0);
					    vec3 txVec631 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec631, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat1 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat2.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec632 = vec3(u_xlat1.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec632, 0.0);
					    vec3 txVec633 = vec3(u_xlat1.zw,u_xlat8.z);
					    u_xlat10_2 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec633, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_2 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_18 + u_xlat8.x;
					    vec3 txVec634 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec634, 0.0);
					    vec3 txVec635 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec635, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  mediump float shadow_15;
					  shadow_15 = 0.0;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_17.z = tmpvar_14.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  mediump float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_14.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_15 = tmpvar_19;
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = 0.0;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_14.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_14.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_15 = (tmpvar_19 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_16.x;
					  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_14.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_14.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.y = 0.0;
					  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_29;
					  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
					  tmpvar_29.z = tmpvar_14.z;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
					  highp float tmpvar_31;
					  if ((tmpvar_30.x < tmpvar_14.z)) {
					    tmpvar_31 = 0.0;
					  } else {
					    tmpvar_31 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_31);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_14.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.y = 0.0;
					  tmpvar_34.x = tmpvar_16.x;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_14.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_14.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_38.y = tmpvar_16.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_14.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_14.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_41);
					  highp vec2 tmpvar_42;
					  tmpvar_42.x = 0.0;
					  tmpvar_42.y = tmpvar_16.y;
					  highp vec3 tmpvar_43;
					  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
					  tmpvar_43.z = tmpvar_14.z;
					  highp vec4 tmpvar_44;
					  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
					  highp float tmpvar_45;
					  if ((tmpvar_44.x < tmpvar_14.z)) {
					    tmpvar_45 = 0.0;
					  } else {
					    tmpvar_45 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_45);
					  highp vec3 tmpvar_46;
					  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_46.z = tmpvar_14.z;
					  highp vec4 tmpvar_47;
					  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
					  highp float tmpvar_48;
					  if ((tmpvar_47.x < tmpvar_14.z)) {
					    tmpvar_48 = 0.0;
					  } else {
					    tmpvar_48 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_48);
					  shadow_15 = (shadow_15 / 9.0);
					  mediump float tmpvar_49;
					  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
					  shadow_15 = tmpvar_49;
					  highp float tmpvar_50;
					  highp vec3 tmpvar_51;
					  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_52;
					  highp float tmpvar_53;
					  tmpvar_53 = clamp (((
					    sqrt(dot (tmpvar_51, tmpvar_51))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_52 = tmpvar_53;
					  tmpvar_50 = tmpvar_52;
					  shadow_2 = (tmpvar_49 + tmpvar_50);
					  mediump vec4 tmpvar_54;
					  tmpvar_54 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_54;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  mediump float shadow_15;
					  shadow_15 = 0.0;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_17.z = tmpvar_14.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  mediump float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_14.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_15 = tmpvar_19;
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = 0.0;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_14.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_14.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_15 = (tmpvar_19 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_16.x;
					  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_14.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_14.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.y = 0.0;
					  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_29;
					  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
					  tmpvar_29.z = tmpvar_14.z;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
					  highp float tmpvar_31;
					  if ((tmpvar_30.x < tmpvar_14.z)) {
					    tmpvar_31 = 0.0;
					  } else {
					    tmpvar_31 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_31);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_14.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.y = 0.0;
					  tmpvar_34.x = tmpvar_16.x;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_14.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_14.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_38.y = tmpvar_16.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_14.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_14.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_41);
					  highp vec2 tmpvar_42;
					  tmpvar_42.x = 0.0;
					  tmpvar_42.y = tmpvar_16.y;
					  highp vec3 tmpvar_43;
					  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
					  tmpvar_43.z = tmpvar_14.z;
					  highp vec4 tmpvar_44;
					  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
					  highp float tmpvar_45;
					  if ((tmpvar_44.x < tmpvar_14.z)) {
					    tmpvar_45 = 0.0;
					  } else {
					    tmpvar_45 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_45);
					  highp vec3 tmpvar_46;
					  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_46.z = tmpvar_14.z;
					  highp vec4 tmpvar_47;
					  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
					  highp float tmpvar_48;
					  if ((tmpvar_47.x < tmpvar_14.z)) {
					    tmpvar_48 = 0.0;
					  } else {
					    tmpvar_48 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_48);
					  shadow_15 = (shadow_15 / 9.0);
					  mediump float tmpvar_49;
					  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
					  shadow_15 = tmpvar_49;
					  highp float tmpvar_50;
					  highp vec3 tmpvar_51;
					  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_52;
					  highp float tmpvar_53;
					  tmpvar_53 = clamp (((
					    sqrt(dot (tmpvar_51, tmpvar_51))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_52 = tmpvar_53;
					  tmpvar_50 = tmpvar_52;
					  shadow_2 = (tmpvar_49 + tmpvar_50);
					  mediump vec4 tmpvar_54;
					  tmpvar_54 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_54;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp vec4 unity_ShadowSplitSpheres[4];
					uniform highp vec4 unity_ShadowSplitSqRadii;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  lowp vec4 weights_6;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[0].xyz);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[1].xyz);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[2].xyz);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (tmpvar_5.xyz - unity_ShadowSplitSpheres[3].xyz);
					  highp vec4 tmpvar_11;
					  tmpvar_11.x = dot (tmpvar_7, tmpvar_7);
					  tmpvar_11.y = dot (tmpvar_8, tmpvar_8);
					  tmpvar_11.z = dot (tmpvar_9, tmpvar_9);
					  tmpvar_11.w = dot (tmpvar_10, tmpvar_10);
					  bvec4 tmpvar_12;
					  tmpvar_12 = lessThan (tmpvar_11, unity_ShadowSplitSqRadii);
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = vec4(tmpvar_12);
					  weights_6.x = tmpvar_13.x;
					  weights_6.yzw = clamp ((tmpvar_13.yzw - tmpvar_13.xyz), 0.0, 1.0);
					  highp vec4 tmpvar_14;
					  tmpvar_14.w = 1.0;
					  tmpvar_14.xyz = (((
					    ((unity_WorldToShadow[0] * tmpvar_5).xyz * tmpvar_13.x)
					   + 
					    ((unity_WorldToShadow[1] * tmpvar_5).xyz * weights_6.y)
					  ) + (
					    (unity_WorldToShadow[2] * tmpvar_5)
					  .xyz * weights_6.z)) + ((unity_WorldToShadow[3] * tmpvar_5).xyz * weights_6.w));
					  mediump float shadow_15;
					  shadow_15 = 0.0;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_14.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_17.z = tmpvar_14.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  mediump float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_14.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_15 = tmpvar_19;
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = 0.0;
					  tmpvar_20.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_14.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_14.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_14.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_15 = (tmpvar_19 + tmpvar_23);
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = tmpvar_16.x;
					  tmpvar_24.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_25;
					  tmpvar_25.xy = (tmpvar_14.xy + tmpvar_24);
					  tmpvar_25.z = tmpvar_14.z;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = texture2D (_ShadowMapTexture, tmpvar_25.xy);
					  highp float tmpvar_27;
					  if ((tmpvar_26.x < tmpvar_14.z)) {
					    tmpvar_27 = 0.0;
					  } else {
					    tmpvar_27 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.y = 0.0;
					  tmpvar_28.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_29;
					  tmpvar_29.xy = (tmpvar_14.xy + tmpvar_28);
					  tmpvar_29.z = tmpvar_14.z;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = texture2D (_ShadowMapTexture, tmpvar_29.xy);
					  highp float tmpvar_31;
					  if ((tmpvar_30.x < tmpvar_14.z)) {
					    tmpvar_31 = 0.0;
					  } else {
					    tmpvar_31 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_31);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_14.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_14.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.y = 0.0;
					  tmpvar_34.x = tmpvar_16.x;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_14.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_14.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_14.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_37);
					  highp vec2 tmpvar_38;
					  tmpvar_38.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_38.y = tmpvar_16.y;
					  highp vec3 tmpvar_39;
					  tmpvar_39.xy = (tmpvar_14.xy + tmpvar_38);
					  tmpvar_39.z = tmpvar_14.z;
					  highp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_ShadowMapTexture, tmpvar_39.xy);
					  highp float tmpvar_41;
					  if ((tmpvar_40.x < tmpvar_14.z)) {
					    tmpvar_41 = 0.0;
					  } else {
					    tmpvar_41 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_41);
					  highp vec2 tmpvar_42;
					  tmpvar_42.x = 0.0;
					  tmpvar_42.y = tmpvar_16.y;
					  highp vec3 tmpvar_43;
					  tmpvar_43.xy = (tmpvar_14.xy + tmpvar_42);
					  tmpvar_43.z = tmpvar_14.z;
					  highp vec4 tmpvar_44;
					  tmpvar_44 = texture2D (_ShadowMapTexture, tmpvar_43.xy);
					  highp float tmpvar_45;
					  if ((tmpvar_44.x < tmpvar_14.z)) {
					    tmpvar_45 = 0.0;
					  } else {
					    tmpvar_45 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_45);
					  highp vec3 tmpvar_46;
					  tmpvar_46.xy = (tmpvar_14.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_46.z = tmpvar_14.z;
					  highp vec4 tmpvar_47;
					  tmpvar_47 = texture2D (_ShadowMapTexture, tmpvar_46.xy);
					  highp float tmpvar_48;
					  if ((tmpvar_47.x < tmpvar_14.z)) {
					    tmpvar_48 = 0.0;
					  } else {
					    tmpvar_48 = 1.0;
					  };
					  shadow_15 = (shadow_15 + tmpvar_48);
					  shadow_15 = (shadow_15 / 9.0);
					  mediump float tmpvar_49;
					  tmpvar_49 = mix (_LightShadowData.x, 1.0, shadow_15);
					  shadow_15 = tmpvar_49;
					  highp float tmpvar_50;
					  highp vec3 tmpvar_51;
					  tmpvar_51 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_52;
					  highp float tmpvar_53;
					  tmpvar_53 = clamp (((
					    sqrt(dot (tmpvar_51, tmpvar_51))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_52 = tmpvar_53;
					  tmpvar_50 = tmpvar_52;
					  shadow_2 = (tmpvar_49 + tmpvar_50);
					  mediump vec4 tmpvar_54;
					  tmpvar_54 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_54;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					lowp float u_xlat10_17;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat9.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat9.xyz;
					    u_xlat9.xyz = u_xlat10_3.xxx * u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat1.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat17.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat2.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat17.xy = u_xlat17.xy / u_xlat2.xy;
					    u_xlat3.xy = u_xlat17.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat3.y;
					    u_xlat17.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xz = u_xlat8.xy / u_xlat17.xy;
					    u_xlat4.xw = u_xlat2.xz + vec2(2.0, 2.0);
					    u_xlat3.w = u_xlat4.x;
					    u_xlat2.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat2.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat3.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat3.zxw * u_xlat7.yxz;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec678 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec678, 0.0);
					    vec3 txVec679 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec679, 0.0);
					    vec3 txVec680 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec680, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat2.xyz = u_xlat2.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat17.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat17.x = u_xlat10_17 * u_xlat2.y;
					    u_xlat16 = u_xlat2.x * u_xlat10_16 + u_xlat17.x;
					    u_xlat8.x = u_xlat2.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec681 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec681, 0.0);
					    vec3 txVec682 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec682, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec683 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec683, 0.0);
					    vec3 txVec684 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec684, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_1 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_17 + u_xlat8.x;
					    vec3 txVec685 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec685, 0.0);
					    vec3 txVec686 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec686, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					lowp float u_xlat10_17;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat9.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat9.xyz;
					    u_xlat9.xyz = u_xlat10_3.xxx * u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat1.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat17.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat2.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat17.xy = u_xlat17.xy / u_xlat2.xy;
					    u_xlat3.xy = u_xlat17.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat3.y;
					    u_xlat17.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xz = u_xlat8.xy / u_xlat17.xy;
					    u_xlat4.xw = u_xlat2.xz + vec2(2.0, 2.0);
					    u_xlat3.w = u_xlat4.x;
					    u_xlat2.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat2.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat3.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat3.zxw * u_xlat7.yxz;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec636 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec636, 0.0);
					    vec3 txVec637 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec637, 0.0);
					    vec3 txVec638 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec638, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat2.xyz = u_xlat2.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat17.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat17.x = u_xlat10_17 * u_xlat2.y;
					    u_xlat16 = u_xlat2.x * u_xlat10_16 + u_xlat17.x;
					    u_xlat8.x = u_xlat2.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec639 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec639, 0.0);
					    vec3 txVec640 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec640, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec641 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec641, 0.0);
					    vec3 txVec642 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec642, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_1 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_17 + u_xlat8.x;
					    vec3 txVec643 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec643, 0.0);
					    vec3 txVec644 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec644, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 unity_ShadowSplitSpheres[4];
					uniform 	vec4 unity_ShadowSplitSqRadii;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					bvec4 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					lowp vec3 u_xlat10_3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					mediump float u_xlat16_16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					lowp float u_xlat10_17;
					lowp float u_xlat10_24;
					void main()
					{
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat8.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat8.x = float(1.0) / u_xlat8.x;
					    u_xlat16 = (-u_xlat8.x) + u_xlat0.x;
					    u_xlat8.x = unity_OrthoParams.w * u_xlat16 + u_xlat8.x;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz + vs_TEXCOORD2.xyz;
					    u_xlat0.xzw = (-vs_TEXCOORD1.xyz) * u_xlat8.xxx + u_xlat0.xzw;
					    u_xlat1.xyz = u_xlat8.xxx * vs_TEXCOORD1.xyz;
					    u_xlat0.xyz = unity_OrthoParams.www * u_xlat0.xzw + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat1.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[0].xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[1].xyz);
					    u_xlat1.y = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[2].xyz);
					    u_xlat1.z = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.xyz + (-unity_ShadowSplitSpheres[3].xyz);
					    u_xlat1.w = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb1 = lessThan(u_xlat1, unity_ShadowSplitSqRadii);
					    u_xlat10_3.x = (u_xlatb1.x) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.y = (u_xlatb1.y) ? float(-1.0) : float(-0.0);
					    u_xlat10_3.z = (u_xlatb1.z) ? float(-1.0) : float(-0.0);
					    u_xlat1 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb1));
					    u_xlat10_3.xyz = vec3(u_xlat10_3.x + u_xlat1.y, u_xlat10_3.y + u_xlat1.z, u_xlat10_3.z + u_xlat1.w);
					    u_xlat10_3.xyz = max(u_xlat10_3.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat9.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[5].xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[4].xyz * u_xlat0.xxx + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[6].xyz * u_xlat0.zzz + u_xlat9.xyz;
					    u_xlat9.xyz = hlslcc_mtx4unity_WorldToShadow[7].xyz * u_xlat0.www + u_xlat9.xyz;
					    u_xlat9.xyz = u_xlat10_3.xxx * u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[9].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[8].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[10].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[11].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat10_3.yyy + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4unity_WorldToShadow[13].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[12].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[14].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[15].xyz * u_xlat0.www + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.xyz = u_xlat2.xyz * u_xlat10_3.zzz + u_xlat1.xyz;
					    u_xlat8.xy = u_xlat8.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat1.xy = floor(u_xlat8.xy);
					    u_xlat8.xy = fract(u_xlat8.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat17.xy = (-u_xlat8.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat2.xy = (-u_xlat8.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat17.xy = u_xlat17.xy / u_xlat2.xy;
					    u_xlat3.xy = u_xlat17.xy + vec2(-2.0, -2.0);
					    u_xlat4.z = u_xlat3.y;
					    u_xlat17.xy = u_xlat8.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xz = u_xlat8.xy / u_xlat17.xy;
					    u_xlat4.xw = u_xlat2.xz + vec2(2.0, 2.0);
					    u_xlat3.w = u_xlat4.x;
					    u_xlat2.xz = u_xlat8.xy + vec2(3.0, 3.0);
					    u_xlat8.x = u_xlat8.x * 3.0;
					    u_xlat5.xz = u_xlat8.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat4.xy = u_xlat2.xz * _ShadowMapTexture_TexelSize.xy;
					    u_xlat6.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat6.y = 0.142857149;
					    u_xlat6.xyz = vec3(u_xlat4.z * u_xlat6.x, u_xlat4.y * u_xlat6.y, u_xlat4.w * u_xlat6.z);
					    u_xlat3.z = u_xlat4.x;
					    u_xlat4.w = u_xlat6.x;
					    u_xlat7.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat7.y = 0.142857149;
					    u_xlat4.xyz = u_xlat3.zxw * u_xlat7.yxz;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.ywxw;
					    u_xlat8.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat4.zw;
					    vec3 txVec622 = vec3(u_xlat8.xy,u_xlat8.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec622, 0.0);
					    vec3 txVec623 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec623, 0.0);
					    vec3 txVec624 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec624, 0.0);
					    u_xlat5.y = 7.0;
					    u_xlat2.xyz = u_xlat2.yyy * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat17.yyy * u_xlat5.xyz;
					    u_xlat5.xy = u_xlat5.xz * vec2(7.0, 7.0);
					    u_xlat17.x = u_xlat10_17 * u_xlat2.y;
					    u_xlat16 = u_xlat2.x * u_xlat10_16 + u_xlat17.x;
					    u_xlat8.x = u_xlat2.z * u_xlat10_8 + u_xlat16;
					    u_xlat6.w = u_xlat4.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat6.wywz;
					    u_xlat4.yw = u_xlat6.yz;
					    vec3 txVec625 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec625, 0.0);
					    vec3 txVec626 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_17 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec626, 0.0);
					    u_xlat8.x = u_xlat5.x * u_xlat10_16 + u_xlat8.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xyzy;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat4.xwzw;
					    vec3 txVec627 = vec3(u_xlat2.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec627, 0.0);
					    vec3 txVec628 = vec3(u_xlat2.zw,u_xlat8.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec628, 0.0);
					    u_xlat8.x = u_xlat10_16 * 49.0 + u_xlat8.x;
					    u_xlat8.x = u_xlat5.y * u_xlat10_1 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.x * u_xlat10_17 + u_xlat8.x;
					    vec3 txVec629 = vec3(u_xlat3.xy,u_xlat8.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec629, 0.0);
					    vec3 txVec630 = vec3(u_xlat3.zw,u_xlat8.z);
					    u_xlat10_24 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec630, 0.0);
					    u_xlat8.x = u_xlat7.y * u_xlat10_16 + u_xlat8.x;
					    u_xlat8.x = u_xlat7.z * u_xlat10_24 + u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * 0.0069444445;
					    u_xlat16_16 = (-_LightShadowData.x) + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16_16 + _LightShadowData.x;
					    u_xlat0 = u_xlat0.xxxx + u_xlat8.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_43;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_43;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = tmpvar_4;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * (unity_CameraToWorld * tmpvar_5)).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  tmpvar_42 = clamp (((tmpvar_4.z * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_43;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					vec2 u_xlat10;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					float u_xlat24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat24 = u_xlat1.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat2.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat2.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat18.xy = u_xlat2.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat2.xy / u_xlat18.xy;
					    u_xlat5.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat10.xy = u_xlat2.xy + vec2(3.0, 3.0);
					    u_xlat25 = u_xlat2.x * 3.0;
					    u_xlat6.xz = vec2(u_xlat25) * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat10.xy * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec687 = vec3(u_xlat0.xy,u_xlat1.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec687, 0.0);
					    vec3 txVec688 = vec3(u_xlat4.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec688, 0.0);
					    vec3 txVec689 = vec3(u_xlat4.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec689, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat2.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat18.yyy * u_xlat6.xyz;
					    u_xlat4.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat2.y;
					    u_xlat8 = u_xlat2.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat2.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec690 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec690, 0.0);
					    vec3 txVec691 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec691, 0.0);
					    u_xlat0.x = u_xlat4.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat5 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec692 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec692, 0.0);
					    vec3 txVec693 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec693, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat4.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec694 = vec3(u_xlat5.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec694, 0.0);
					    vec3 txVec695 = vec3(u_xlat5.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec695, 0.0);
					    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.z * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					vec2 u_xlat10;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					float u_xlat24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat24 = u_xlat1.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat2.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat2.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat18.xy = u_xlat2.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat2.xy / u_xlat18.xy;
					    u_xlat5.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat10.xy = u_xlat2.xy + vec2(3.0, 3.0);
					    u_xlat25 = u_xlat2.x * 3.0;
					    u_xlat6.xz = vec2(u_xlat25) * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat10.xy * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec645 = vec3(u_xlat0.xy,u_xlat1.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec645, 0.0);
					    vec3 txVec646 = vec3(u_xlat4.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec646, 0.0);
					    vec3 txVec647 = vec3(u_xlat4.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec647, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat2.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat18.yyy * u_xlat6.xyz;
					    u_xlat4.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat2.y;
					    u_xlat8 = u_xlat2.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat2.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec648 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec648, 0.0);
					    vec3 txVec649 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec649, 0.0);
					    u_xlat0.x = u_xlat4.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat5 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec650 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec650, 0.0);
					    vec3 txVec651 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec651, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat4.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec652 = vec3(u_xlat5.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec652, 0.0);
					    vec3 txVec653 = vec3(u_xlat5.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec653, 0.0);
					    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.z * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					vec2 u_xlat10;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat18;
					float u_xlat24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat24 = u_xlat1.z * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1 = u_xlat2 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat2.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat18.xy = (-u_xlat2.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat2.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat18.xy = u_xlat18.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat18.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat18.xy = u_xlat2.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat3.xz = u_xlat2.xy / u_xlat18.xy;
					    u_xlat5.xw = u_xlat3.xz + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat10.xy = u_xlat2.xy + vec2(3.0, 3.0);
					    u_xlat25 = u_xlat2.x * 3.0;
					    u_xlat6.xz = vec2(u_xlat25) * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat10.xy * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec631 = vec3(u_xlat0.xy,u_xlat1.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec631, 0.0);
					    vec3 txVec632 = vec3(u_xlat4.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec632, 0.0);
					    vec3 txVec633 = vec3(u_xlat4.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec633, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat2.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat18.yyy * u_xlat6.xyz;
					    u_xlat4.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat2.y;
					    u_xlat8 = u_xlat2.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat2.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec634 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec634, 0.0);
					    vec3 txVec635 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec635, 0.0);
					    u_xlat0.x = u_xlat4.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat2 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat5 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec636 = vec3(u_xlat2.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec636, 0.0);
					    vec3 txVec637 = vec3(u_xlat2.zw,u_xlat1.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec637, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat4.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec638 = vec3(u_xlat5.xy,u_xlat1.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec638, 0.0);
					    vec3 txVec639 = vec3(u_xlat5.zw,u_xlat1.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec639, 0.0);
					    u_xlat0.x = u_xlat3.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat3.z * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  highp vec3 tmpvar_43;
					  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_44;
					  highp float tmpvar_45;
					  tmpvar_45 = clamp (((
					    sqrt(dot (tmpvar_43, tmpvar_43))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_44 = tmpvar_45;
					  tmpvar_42 = tmpvar_44;
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_46;
					  tmpvar_46 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_46;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  highp vec3 tmpvar_43;
					  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_44;
					  highp float tmpvar_45;
					  tmpvar_45 = clamp (((
					    sqrt(dot (tmpvar_43, tmpvar_43))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_44 = tmpvar_45;
					  tmpvar_42 = tmpvar_44;
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_46;
					  tmpvar_46 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_46;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_CameraInvProjection;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 orthoPosFar_1;
					  highp vec3 orthoPosNear_2;
					  highp vec4 clipPos_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  clipPos_3.xzw = tmpvar_4.xzw;
					  clipPos_3.y = (tmpvar_4.y * _ProjectionParams.x);
					  highp vec4 tmpvar_6;
					  tmpvar_6.zw = vec2(-1.0, 1.0);
					  tmpvar_6.xy = clipPos_3.xy;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_CameraInvProjection * tmpvar_6).xyz;
					  orthoPosNear_2.xy = tmpvar_7.xy;
					  highp vec4 tmpvar_8;
					  tmpvar_8.zw = vec2(1.0, 1.0);
					  tmpvar_8.xy = clipPos_3.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_CameraInvProjection * tmpvar_8).xyz;
					  orthoPosFar_1.xy = tmpvar_9.xy;
					  orthoPosNear_2.z = -(tmpvar_7.z);
					  orthoPosFar_1.z = -(tmpvar_9.z);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
					  xlv_TEXCOORD1 = _glesNormal;
					  xlv_TEXCOORD2 = orthoPosNear_2;
					  xlv_TEXCOORD3 = orthoPosFar_1;
					  gl_Position = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform highp vec4 unity_OrthoParams;
					uniform highp mat4 unity_CameraToWorld;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform mediump vec4 _LightShadowData;
					uniform highp vec4 unity_ShadowFadeCenterAndType;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp sampler2D _ShadowMapTexture;
					uniform highp vec4 _ShadowMapTexture_TexelSize;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump float shadow_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0);
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = mix ((xlv_TEXCOORD1 * mix (
					    (1.0/(((_ZBufferParams.x * tmpvar_3.x) + _ZBufferParams.y)))
					  , tmpvar_3.x, unity_OrthoParams.w)), mix (xlv_TEXCOORD2, xlv_TEXCOORD3, tmpvar_3.xxx), unity_OrthoParams.www);
					  highp vec4 tmpvar_5;
					  tmpvar_5 = (unity_CameraToWorld * tmpvar_4);
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 0.0;
					  tmpvar_6.xyz = (unity_WorldToShadow[0] * tmpvar_5).xyz;
					  mediump float shadow_7;
					  shadow_7 = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = _ShadowMapTexture_TexelSize.xy;
					  highp vec3 tmpvar_9;
					  tmpvar_9.xy = (tmpvar_6.xy - _ShadowMapTexture_TexelSize.xy);
					  tmpvar_9.z = tmpvar_6.z;
					  highp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_ShadowMapTexture, tmpvar_9.xy);
					  mediump float tmpvar_11;
					  if ((tmpvar_10.x < tmpvar_6.z)) {
					    tmpvar_11 = 0.0;
					  } else {
					    tmpvar_11 = 1.0;
					  };
					  shadow_7 = tmpvar_11;
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = 0.0;
					  tmpvar_12.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xy = (tmpvar_6.xy + tmpvar_12);
					  tmpvar_13.z = tmpvar_6.z;
					  highp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_ShadowMapTexture, tmpvar_13.xy);
					  highp float tmpvar_15;
					  if ((tmpvar_14.x < tmpvar_6.z)) {
					    tmpvar_15 = 0.0;
					  } else {
					    tmpvar_15 = 1.0;
					  };
					  shadow_7 = (tmpvar_11 + tmpvar_15);
					  highp vec2 tmpvar_16;
					  tmpvar_16.x = tmpvar_8.x;
					  tmpvar_16.y = -(_ShadowMapTexture_TexelSize.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xy = (tmpvar_6.xy + tmpvar_16);
					  tmpvar_17.z = tmpvar_6.z;
					  highp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
					  highp float tmpvar_19;
					  if ((tmpvar_18.x < tmpvar_6.z)) {
					    tmpvar_19 = 0.0;
					  } else {
					    tmpvar_19 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_19);
					  highp vec2 tmpvar_20;
					  tmpvar_20.y = 0.0;
					  tmpvar_20.x = -(_ShadowMapTexture_TexelSize.x);
					  highp vec3 tmpvar_21;
					  tmpvar_21.xy = (tmpvar_6.xy + tmpvar_20);
					  tmpvar_21.z = tmpvar_6.z;
					  highp vec4 tmpvar_22;
					  tmpvar_22 = texture2D (_ShadowMapTexture, tmpvar_21.xy);
					  highp float tmpvar_23;
					  if ((tmpvar_22.x < tmpvar_6.z)) {
					    tmpvar_23 = 0.0;
					  } else {
					    tmpvar_23 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_23);
					  highp vec4 tmpvar_24;
					  tmpvar_24 = texture2D (_ShadowMapTexture, tmpvar_6.xy);
					  highp float tmpvar_25;
					  if ((tmpvar_24.x < tmpvar_6.z)) {
					    tmpvar_25 = 0.0;
					  } else {
					    tmpvar_25 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_25);
					  highp vec2 tmpvar_26;
					  tmpvar_26.y = 0.0;
					  tmpvar_26.x = tmpvar_8.x;
					  highp vec3 tmpvar_27;
					  tmpvar_27.xy = (tmpvar_6.xy + tmpvar_26);
					  tmpvar_27.z = tmpvar_6.z;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_ShadowMapTexture, tmpvar_27.xy);
					  highp float tmpvar_29;
					  if ((tmpvar_28.x < tmpvar_6.z)) {
					    tmpvar_29 = 0.0;
					  } else {
					    tmpvar_29 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = -(_ShadowMapTexture_TexelSize.x);
					  tmpvar_30.y = tmpvar_8.y;
					  highp vec3 tmpvar_31;
					  tmpvar_31.xy = (tmpvar_6.xy + tmpvar_30);
					  tmpvar_31.z = tmpvar_6.z;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = texture2D (_ShadowMapTexture, tmpvar_31.xy);
					  highp float tmpvar_33;
					  if ((tmpvar_32.x < tmpvar_6.z)) {
					    tmpvar_33 = 0.0;
					  } else {
					    tmpvar_33 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_33);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = 0.0;
					  tmpvar_34.y = tmpvar_8.y;
					  highp vec3 tmpvar_35;
					  tmpvar_35.xy = (tmpvar_6.xy + tmpvar_34);
					  tmpvar_35.z = tmpvar_6.z;
					  highp vec4 tmpvar_36;
					  tmpvar_36 = texture2D (_ShadowMapTexture, tmpvar_35.xy);
					  highp float tmpvar_37;
					  if ((tmpvar_36.x < tmpvar_6.z)) {
					    tmpvar_37 = 0.0;
					  } else {
					    tmpvar_37 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_37);
					  highp vec3 tmpvar_38;
					  tmpvar_38.xy = (tmpvar_6.xy + _ShadowMapTexture_TexelSize.xy);
					  tmpvar_38.z = tmpvar_6.z;
					  highp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_ShadowMapTexture, tmpvar_38.xy);
					  highp float tmpvar_40;
					  if ((tmpvar_39.x < tmpvar_6.z)) {
					    tmpvar_40 = 0.0;
					  } else {
					    tmpvar_40 = 1.0;
					  };
					  shadow_7 = (shadow_7 + tmpvar_40);
					  shadow_7 = (shadow_7 / 9.0);
					  mediump float tmpvar_41;
					  tmpvar_41 = mix (_LightShadowData.x, 1.0, shadow_7);
					  shadow_7 = tmpvar_41;
					  highp float tmpvar_42;
					  highp vec3 tmpvar_43;
					  tmpvar_43 = (tmpvar_5.xyz - unity_ShadowFadeCenterAndType.xyz);
					  mediump float tmpvar_44;
					  highp float tmpvar_45;
					  tmpvar_45 = clamp (((
					    sqrt(dot (tmpvar_43, tmpvar_43))
					   * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
					  tmpvar_44 = tmpvar_45;
					  tmpvar_42 = tmpvar_44;
					  shadow_2 = (tmpvar_41 + tmpvar_42);
					  mediump vec4 tmpvar_46;
					  tmpvar_46 = vec4(shadow_2);
					  tmpvar_1 = tmpvar_46;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat24 = sqrt(u_xlat24);
					    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat17.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat2.xy = (-u_xlat17.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat17.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat2.xy = u_xlat2.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat2.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat2.xy = u_xlat17.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xw = u_xlat17.xy / u_xlat2.xy;
					    u_xlat5.xw = u_xlat2.xw + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat2.xw = u_xlat17.xy + vec2(3.0, 3.0);
					    u_xlat17.x = u_xlat17.x * 3.0;
					    u_xlat6.xz = u_xlat17.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat2.xw * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec640 = vec3(u_xlat0.xy,u_xlat2.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec640, 0.0);
					    vec3 txVec641 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec641, 0.0);
					    vec3 txVec642 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec642, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat2.xyw = u_xlat2.yyy * u_xlat6.xyz;
					    u_xlat17.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat3.y;
					    u_xlat8 = u_xlat3.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat3.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec643 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec643, 0.0);
					    vec3 txVec644 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec644, 0.0);
					    u_xlat0.x = u_xlat17.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec645 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec645, 0.0);
					    vec3 txVec646 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec646, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat17.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec647 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec647, 0.0);
					    vec3 txVec648 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec648, 0.0);
					    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.w * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat24 = sqrt(u_xlat24);
					    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat17.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat2.xy = (-u_xlat17.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat17.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat2.xy = u_xlat2.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat2.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat2.xy = u_xlat17.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xw = u_xlat17.xy / u_xlat2.xy;
					    u_xlat5.xw = u_xlat2.xw + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat2.xw = u_xlat17.xy + vec2(3.0, 3.0);
					    u_xlat17.x = u_xlat17.x * 3.0;
					    u_xlat6.xz = u_xlat17.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat2.xw * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec596 = vec3(u_xlat0.xy,u_xlat2.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec596, 0.0);
					    vec3 txVec597 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec597, 0.0);
					    vec3 txVec598 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec598, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat2.xyw = u_xlat2.yyy * u_xlat6.xyz;
					    u_xlat17.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat3.y;
					    u_xlat8 = u_xlat3.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat3.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec599 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec599, 0.0);
					    vec3 txVec600 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec600, 0.0);
					    u_xlat0.x = u_xlat17.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec601 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec601, 0.0);
					    vec3 txVec602 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec602, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat17.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec603 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec603, 0.0);
					    vec3 txVec604 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec604, 0.0);
					    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.w * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraInvProjection[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec2 in_TEXCOORD0;
					in highp vec3 in_NORMAL0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xyz = in_NORMAL0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xyz = u_xlat1.xxx * hlslcc_mtx4unity_CameraInvProjection[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_CameraInvProjection[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    gl_Position = u_xlat0;
					    u_xlat0.xyz = u_xlat1.xyz + (-hlslcc_mtx4unity_CameraInvProjection[2].xyz);
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[2].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4unity_CameraInvProjection[3].xyz;
					    u_xlat0.w = (-u_xlat0.z);
					    vs_TEXCOORD2.xyz = u_xlat0.xyw;
					    u_xlat1.w = (-u_xlat1.z);
					    vs_TEXCOORD3.xyz = u_xlat1.xyw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	vec4 unity_OrthoParams;
					uniform 	vec4 hlslcc_mtx4unity_CameraToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	mediump vec4 _LightShadowData;
					uniform 	vec4 unity_ShadowFadeCenterAndType;
					uniform 	vec4 _ShadowMapTexture_TexelSize;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					vec4 u_xlat1;
					lowp float u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat7;
					float u_xlat8;
					mediump float u_xlat16_8;
					lowp float u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat16;
					lowp float u_xlat10_16;
					vec2 u_xlat17;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.yy;
					    u_xlat0.y = 0.142857149;
					    u_xlat24 = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat1.x = _ZBufferParams.x * u_xlat24 + _ZBufferParams.y;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat9.x = u_xlat24 + (-u_xlat1.x);
					    u_xlat1.x = unity_OrthoParams.w * u_xlat9.x + u_xlat1.x;
					    u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + vs_TEXCOORD3.xyz;
					    u_xlat9.xyz = vec3(u_xlat24) * u_xlat9.xyz + vs_TEXCOORD2.xyz;
					    u_xlat9.xyz = (-vs_TEXCOORD1.xyz) * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat2.xyz = u_xlat1.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = unity_OrthoParams.www * u_xlat9.xyz + u_xlat2.xyz;
					    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4unity_CameraToWorld[1];
					    u_xlat2 = hlslcc_mtx4unity_CameraToWorld[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat1 = hlslcc_mtx4unity_CameraToWorld[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = u_xlat1 + hlslcc_mtx4unity_CameraToWorld[3];
					    u_xlat2.xyz = u_xlat1.yyy * hlslcc_mtx4unity_WorldToShadow[1].xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = hlslcc_mtx4unity_WorldToShadow[3].xyz * u_xlat1.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat24 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat24 = sqrt(u_xlat24);
					    u_xlat24 = u_xlat24 * _LightShadowData.z + _LightShadowData.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
					#else
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					#endif
					    u_xlat1.xy = u_xlat2.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					    u_xlat17.xy = fract(u_xlat1.xy);
					    u_xlat1.xy = floor(u_xlat1.xy);
					    u_xlat1.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat2.xy = (-u_xlat17.xy) * vec2(2.0, 2.0) + vec2(3.0, 3.0);
					    u_xlat3.xy = (-u_xlat17.xy) * vec2(3.0, 3.0) + vec2(4.0, 4.0);
					    u_xlat2.xy = u_xlat2.xy / u_xlat3.xy;
					    u_xlat4.xy = u_xlat2.xy + vec2(-2.0, -2.0);
					    u_xlat5.z = u_xlat4.y;
					    u_xlat2.xy = u_xlat17.xy * vec2(3.0, 3.0) + vec2(1.0, 1.0);
					    u_xlat2.xw = u_xlat17.xy / u_xlat2.xy;
					    u_xlat5.xw = u_xlat2.xw + vec2(2.0, 2.0);
					    u_xlat4.w = u_xlat5.x;
					    u_xlat2.xw = u_xlat17.xy + vec2(3.0, 3.0);
					    u_xlat17.x = u_xlat17.x * 3.0;
					    u_xlat6.xz = u_xlat17.xx * vec2(-1.0, 1.0) + vec2(4.0, 1.0);
					    u_xlat5.xy = u_xlat2.xw * _ShadowMapTexture_TexelSize.xy;
					    u_xlat7.xyz = vec3(u_xlat0.x * u_xlat5.z, u_xlat0.y * u_xlat5.y, u_xlat0.z * u_xlat5.w);
					    u_xlat4.z = u_xlat5.x;
					    u_xlat5.w = u_xlat7.x;
					    u_xlat0.xz = _ShadowMapTexture_TexelSize.xx;
					    u_xlat0.y = 0.142857149;
					    u_xlat5.xyz = u_xlat0.yxz * u_xlat4.zxw;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.ywxw;
					    u_xlat0.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xy + u_xlat5.zw;
					    vec3 txVec696 = vec3(u_xlat0.xy,u_xlat2.z);
					    u_xlat10_0 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec696, 0.0);
					    vec3 txVec697 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec697, 0.0);
					    vec3 txVec698 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec698, 0.0);
					    u_xlat6.y = 7.0;
					    u_xlat3.xyz = u_xlat3.yyy * u_xlat6.xyz;
					    u_xlat2.xyw = u_xlat2.yyy * u_xlat6.xyz;
					    u_xlat17.xy = u_xlat6.xz * vec2(7.0, 7.0);
					    u_xlat16 = u_xlat10_16 * u_xlat3.y;
					    u_xlat8 = u_xlat3.x * u_xlat10_8 + u_xlat16;
					    u_xlat0.x = u_xlat3.z * u_xlat10_0 + u_xlat8;
					    u_xlat7.w = u_xlat5.y;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat7.wywz;
					    u_xlat5.yw = u_xlat7.yz;
					    vec3 txVec699 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec699, 0.0);
					    vec3 txVec700 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec700, 0.0);
					    u_xlat0.x = u_xlat17.x * u_xlat10_8 + u_xlat0.x;
					    u_xlat3 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xyzy;
					    u_xlat4 = u_xlat1.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwzw;
					    vec3 txVec701 = vec3(u_xlat3.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec701, 0.0);
					    vec3 txVec702 = vec3(u_xlat3.zw,u_xlat2.z);
					    u_xlat10_1 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec702, 0.0);
					    u_xlat0.x = u_xlat10_8 * 49.0 + u_xlat0.x;
					    u_xlat0.x = u_xlat17.y * u_xlat10_1 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.x * u_xlat10_16 + u_xlat0.x;
					    vec3 txVec703 = vec3(u_xlat4.xy,u_xlat2.z);
					    u_xlat10_8 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec703, 0.0);
					    vec3 txVec704 = vec3(u_xlat4.zw,u_xlat2.z);
					    u_xlat10_16 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec704, 0.0);
					    u_xlat0.x = u_xlat2.y * u_xlat10_8 + u_xlat0.x;
					    u_xlat0.x = u_xlat2.w * u_xlat10_16 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * 0.0069444445;
					    u_xlat16_8 = (-_LightShadowData.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat16_8 + _LightShadowData.x;
					    u_xlat0 = vec4(u_xlat24) + u_xlat0.xxxx;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
"!!GLES"
}
SubProgram "gles hw_tier02 " {
"!!GLES"
}
SubProgram "gles hw_tier03 " {
"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_SINGLE_CASCADE" }
					"!!GLES3"
}
}
 }
}
Fallback Off
}