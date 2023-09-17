Shader "Custom/tree_lod" {
Properties {
 _Color ("Main Color", Color) = (1.000000,1.000000,1.000000,1.000000)
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
 _Cutoff ("Alpha cutoff", Range(0.000000,1.000000)) = 0.500000
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "SHADOWSUPPORT"="true" "RenderType"="TransparentCutout" }
  ColorMask RGB
  GpuProgramID 56418
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_9;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_10;
					  tmpvar_10.w = 1.0;
					  tmpvar_10.xyz = worldNormal_2;
					  mediump vec4 normal_11;
					  normal_11 = tmpvar_10;
					  mediump vec3 res_12;
					  mediump vec3 x_13;
					  x_13.x = dot (unity_SHAr, normal_11);
					  x_13.y = dot (unity_SHAg, normal_11);
					  x_13.z = dot (unity_SHAb, normal_11);
					  mediump vec3 x1_14;
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = (normal_11.xyzz * normal_11.yzzx);
					  x1_14.x = dot (unity_SHBr, tmpvar_15);
					  x1_14.y = dot (unity_SHBg, tmpvar_15);
					  x1_14.z = dot (unity_SHBb, tmpvar_15);
					  res_12 = (x_13 + (x1_14 + (unity_SHC.xyz * 
					    ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y))
					  )));
					  res_12 = max (((1.055 * 
					    pow (max (res_12, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_12;
					  tmpvar_4 = shlight_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = (glstate_matrix_mvp * tmpvar_4);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec559 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec559, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec598 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec598, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec631 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec631, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    SV_Target0.xyz = u_xlat10_0.xyz * u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_6);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_6);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_17;
					  lightColor0_17 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_18;
					  lightColor1_18 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_19;
					  lightColor2_19 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_20;
					  lightColor3_20 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_21;
					  lightAttenSq_21 = unity_4LightAtten0;
					  highp vec3 normal_22;
					  normal_22 = worldNormal_2;
					  highp vec3 col_23;
					  highp vec4 ndotl_24;
					  highp vec4 lengthSq_25;
					  highp vec4 tmpvar_26;
					  tmpvar_26 = (unity_4LightPosX0 - tmpvar_6.x);
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosY0 - tmpvar_6.y);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_6.z);
					  lengthSq_25 = (tmpvar_26 * tmpvar_26);
					  lengthSq_25 = (lengthSq_25 + (tmpvar_27 * tmpvar_27));
					  lengthSq_25 = (lengthSq_25 + (tmpvar_28 * tmpvar_28));
					  ndotl_24 = (tmpvar_26 * normal_22.x);
					  ndotl_24 = (ndotl_24 + (tmpvar_27 * normal_22.y));
					  ndotl_24 = (ndotl_24 + (tmpvar_28 * normal_22.z));
					  highp vec4 tmpvar_29;
					  tmpvar_29 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_24 * inversesqrt(lengthSq_25)));
					  ndotl_24 = tmpvar_29;
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (tmpvar_29 * (1.0/((1.0 + 
					    (lengthSq_25 * lightAttenSq_21)
					  ))));
					  col_23 = (lightColor0_17 * tmpvar_30.x);
					  col_23 = (col_23 + (lightColor1_18 * tmpvar_30.y));
					  col_23 = (col_23 + (lightColor2_19 * tmpvar_30.z));
					  col_23 = (col_23 + (lightColor3_20 * tmpvar_30.w));
					  tmpvar_4 = (tmpvar_4 + col_23);
					  gl_Position = (glstate_matrix_mvp * tmpvar_5);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_6);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    SV_Target0.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = ((tmpvar_4.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec599 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec599, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec597 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec597, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec560 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec560, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = ((tmpvar_5.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_6;
					  tmpvar_6 = (2.0 * tmpvar_5.xyz);
					  lm_1 = tmpvar_6;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * lm_1);
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_7));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					float u_xlat11;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_1.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat11 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
					#else
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat11) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].x;
					  v_7.y = unity_WorldToObject[1].x;
					  v_7.z = unity_WorldToObject[2].x;
					  v_7.w = unity_WorldToObject[3].x;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].y;
					  v_8.y = unity_WorldToObject[1].y;
					  v_8.z = unity_WorldToObject[2].y;
					  v_8.w = unity_WorldToObject[3].y;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].z;
					  v_9.y = unity_WorldToObject[1].z;
					  v_9.z = unity_WorldToObject[2].z;
					  v_9.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize(((
					    (v_7.xyz * _glesNormal.x)
					   + 
					    (v_8.xyz * _glesNormal.y)
					  ) + (v_9.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_10;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_11;
					  tmpvar_11.w = 1.0;
					  tmpvar_11.xyz = worldNormal_2;
					  mediump vec4 normal_12;
					  normal_12 = tmpvar_11;
					  mediump vec3 res_13;
					  mediump vec3 x_14;
					  x_14.x = dot (unity_SHAr, normal_12);
					  x_14.y = dot (unity_SHAg, normal_12);
					  x_14.z = dot (unity_SHAb, normal_12);
					  mediump vec3 x1_15;
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = (normal_12.xyzz * normal_12.yzzx);
					  x1_15.x = dot (unity_SHBr, tmpvar_16);
					  x1_15.y = dot (unity_SHBg, tmpvar_16);
					  x1_15.z = dot (unity_SHBb, tmpvar_16);
					  res_13 = (x_14 + (x1_15 + (unity_SHC.xyz * 
					    ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y))
					  )));
					  res_13 = max (((1.055 * 
					    pow (max (res_13, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_13;
					  tmpvar_4 = shlight_1;
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					mediump vec3 u_xlat16_2;
					mediump vec3 u_xlat16_3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat16_2.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					attribute vec4 _glesMultiTexCoord1;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 unity_LightmapST;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = 1.0;
					  tmpvar_5.xyz = _glesVertex.xyz;
					  tmpvar_4 = (glstate_matrix_mvp * tmpvar_5);
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].x;
					  v_6.y = unity_WorldToObject[1].x;
					  v_6.z = unity_WorldToObject[2].x;
					  v_6.w = unity_WorldToObject[3].x;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].y;
					  v_7.y = unity_WorldToObject[1].y;
					  v_7.z = unity_WorldToObject[2].y;
					  v_7.w = unity_WorldToObject[3].y;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].z;
					  v_8.y = unity_WorldToObject[1].z;
					  v_8.z = unity_WorldToObject[2].z;
					  v_8.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize(((
					    (v_6.xyz * _glesNormal.x)
					   + 
					    (v_7.xyz * _glesNormal.y)
					  ) + (v_8.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_9;
					  tmpvar_2 = worldNormal_1;
					  tmpvar_3.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
					  gl_Position = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_3;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * (unity_ObjectToWorld * _glesVertex));
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_4.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform mediump vec4 _LightShadowData;
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D unity_Lightmap;
					uniform highp sampler2D _ShadowMapTexture;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 lm_1;
					  lowp vec4 c_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_4;
					  x_4 = (tmpvar_3.w - _Cutoff);
					  if ((x_4 < 0.0)) {
					    discard;
					  };
					  lowp float tmpvar_5;
					  highp float lightShadowDataX_6;
					  mediump float tmpvar_7;
					  tmpvar_7 = _LightShadowData.x;
					  lightShadowDataX_6 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = max (float((texture2D (_ShadowMapTexture, xlv_TEXCOORD3.xy).x > xlv_TEXCOORD3.z)), lightShadowDataX_6);
					  tmpvar_5 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD2.xy);
					  mediump vec3 tmpvar_10;
					  tmpvar_10 = (2.0 * tmpvar_9.xyz);
					  lm_1 = tmpvar_10;
					  c_2.w = tmpvar_3.w;
					  c_2.xyz = (tmpvar_3.xyz * min (lm_1, vec3((tmpvar_5 * 2.0))));
					  highp float tmpvar_11;
					  tmpvar_11 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_11));
					  gl_FragData[0] = c_2;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec561 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec561, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec632 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec632, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 unity_LightmapST;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in highp vec4 in_TEXCOORD1;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec4 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD2.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD2.zw = vec2(0.0, 0.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightShadowData;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D unity_Lightmap;
					uniform lowp sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform lowp sampler2D _ShadowMapTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in highp vec4 vs_TEXCOORD2;
					in highp vec4 vs_TEXCOORD3;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					vec3 u_xlat2;
					lowp vec3 u_xlat10_2;
					bool u_xlatb2;
					mediump float u_xlat16_3;
					lowp vec3 u_xlat10_5;
					float u_xlat14;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    vec3 txVec598 = vec3(vs_TEXCOORD3.xy,vs_TEXCOORD3.z);
					    u_xlat10_2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec598, 0.0);
					    u_xlat16_3 = (-_LightShadowData.x) + 1.0;
					    u_xlat16_3 = u_xlat10_2.x * u_xlat16_3 + _LightShadowData.x;
					    u_xlat10_1.x = u_xlat16_3 * 2.0;
					    u_xlat10_2.xyz = texture(unity_Lightmap, vs_TEXCOORD2.xy).xyz;
					    u_xlat10_5.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat10_1.xyz = min(u_xlat10_1.xxx, u_xlat10_5.xyz);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat14 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat14 = min(max(u_xlat14, 0.0), 1.0);
					#else
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat14) * u_xlat2.xyz + unity_FogColor.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex).xyz;
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_WorldToShadow[4];
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 shlight_1;
					  lowp vec3 worldNormal_2;
					  mediump vec3 tmpvar_3;
					  lowp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = _glesVertex.xyz;
					  tmpvar_5 = (glstate_matrix_mvp * tmpvar_6);
					  highp vec4 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
					  highp vec4 v_8;
					  v_8.x = unity_WorldToObject[0].x;
					  v_8.y = unity_WorldToObject[1].x;
					  v_8.z = unity_WorldToObject[2].x;
					  v_8.w = unity_WorldToObject[3].x;
					  highp vec4 v_9;
					  v_9.x = unity_WorldToObject[0].y;
					  v_9.y = unity_WorldToObject[1].y;
					  v_9.z = unity_WorldToObject[2].y;
					  v_9.w = unity_WorldToObject[3].y;
					  highp vec4 v_10;
					  v_10.x = unity_WorldToObject[0].z;
					  v_10.y = unity_WorldToObject[1].z;
					  v_10.z = unity_WorldToObject[2].z;
					  v_10.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(((
					    (v_8.xyz * _glesNormal.x)
					   + 
					    (v_9.xyz * _glesNormal.y)
					  ) + (v_10.xyz * _glesNormal.z)));
					  worldNormal_2 = tmpvar_11;
					  tmpvar_3 = worldNormal_2;
					  lowp vec4 tmpvar_12;
					  tmpvar_12.w = 1.0;
					  tmpvar_12.xyz = worldNormal_2;
					  mediump vec4 normal_13;
					  normal_13 = tmpvar_12;
					  mediump vec3 res_14;
					  mediump vec3 x_15;
					  x_15.x = dot (unity_SHAr, normal_13);
					  x_15.y = dot (unity_SHAg, normal_13);
					  x_15.z = dot (unity_SHAb, normal_13);
					  mediump vec3 x1_16;
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = (normal_13.xyzz * normal_13.yzzx);
					  x1_16.x = dot (unity_SHBr, tmpvar_17);
					  x1_16.y = dot (unity_SHBg, tmpvar_17);
					  x1_16.z = dot (unity_SHBb, tmpvar_17);
					  res_14 = (x_15 + (x1_16 + (unity_SHC.xyz * 
					    ((normal_13.x * normal_13.x) - (normal_13.y * normal_13.y))
					  )));
					  res_14 = max (((1.055 * 
					    pow (max (res_14, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  shlight_1 = res_14;
					  tmpvar_4 = shlight_1;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_2;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_7.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_7.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_7.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(lengthSq_26)));
					  ndotl_25 = tmpvar_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_30 * (1.0/((1.0 + 
					    (lengthSq_26 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_31.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_31.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_31.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_31.w));
					  tmpvar_4 = (tmpvar_4 + col_24);
					  gl_Position = tmpvar_5;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_4;
					  xlv_TEXCOORD3 = (unity_WorldToShadow[0] * tmpvar_7);
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_5.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  c_1.w = 0.0;
					  c_1.xyz = (tmpvar_2.xyz * xlv_TEXCOORD2);
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1 = (c_1 + c_4);
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = mix (unity_FogColor.xyz, c_1.xyz, vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" "VERTEXLIGHT_ON" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 unity_4LightPosX0;
					uniform 	vec4 unity_4LightPosY0;
					uniform 	vec4 unity_4LightPosZ0;
					uniform 	mediump vec4 unity_4LightAtten0;
					uniform 	mediump vec4 unity_LightColor[8];
					uniform 	mediump vec4 unity_SHAr;
					uniform 	mediump vec4 unity_SHAg;
					uniform 	mediump vec4 unity_SHAb;
					uniform 	mediump vec4 unity_SHBr;
					uniform 	mediump vec4 unity_SHBg;
					uniform 	mediump vec4 unity_SHBb;
					uniform 	mediump vec4 unity_SHC;
					uniform 	vec4 hlslcc_mtx4unity_WorldToShadow[16];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out lowp vec3 vs_TEXCOORD2;
					out highp vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
					    u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
					    u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
					    u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
					    u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
					    u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
					    u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
					    u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
					    u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat16_2.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
					    u_xlat1 = (-u_xlat5.yyyy) + unity_4LightPosY0;
					    u_xlat2 = u_xlat0.yyyy * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat3 = (-u_xlat5.xxxx) + unity_4LightPosX0;
					    u_xlat5 = (-u_xlat5.zzzz) + unity_4LightPosZ0;
					    u_xlat2 = u_xlat3 * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = u_xlat5 * u_xlat0.zzzz + u_xlat2;
					    u_xlat1 = u_xlat3 * u_xlat3 + u_xlat1;
					    u_xlat1 = u_xlat5 * u_xlat5 + u_xlat1;
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat1 * u_xlat0;
					    u_xlat5.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat5.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat5.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat4.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_WorldToShadow[1];
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4unity_WorldToShadow[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = hlslcc_mtx4unity_WorldToShadow[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 unity_FogColor;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					in lowp vec3 vs_TEXCOORD2;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec3 u_xlat0;
					mediump vec3 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vs_TEXCOORD2.xyz + u_xlat10_1.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    u_xlat16_0.xyz = u_xlat10_1.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat9 = min(max(u_xlat9, 0.0), 1.0);
					#else
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_0.xyz + unity_FogColor.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DYNAMICLIGHTMAP_OFF" "FOG_EXP" }
					"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Blend One One
  ColorMask RGB
  GpuProgramID 102225
Program "vp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  highp vec4 v_4;
					  v_4.x = unity_WorldToObject[0].x;
					  v_4.y = unity_WorldToObject[1].x;
					  v_4.z = unity_WorldToObject[2].x;
					  v_4.w = unity_WorldToObject[3].x;
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].y;
					  v_5.y = unity_WorldToObject[1].y;
					  v_5.z = unity_WorldToObject[2].y;
					  v_5.w = unity_WorldToObject[3].y;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].z;
					  v_6.y = unity_WorldToObject[1].z;
					  v_6.z = unity_WorldToObject[2].z;
					  v_6.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(((
					    (v_4.xyz * _glesNormal.x)
					   + 
					    (v_5.xyz * _glesNormal.y)
					  ) + (v_6.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_7;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_2;
					  x_2 = (tmpvar_1.w - _Cutoff);
					  if ((x_2 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_3;
					  c_3.xyz = ((tmpvar_1.xyz * _LightColor0.xyz) * 0.4);
					  c_3.w = tmpvar_1.w;
					  gl_FragData[0] = c_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					lowp vec3 u_xlat10_1;
					bool u_xlatb2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat10_0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat10_0.xyz * _LightColor0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    SV_Target0.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying highp vec2 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec3 worldNormal_1;
					  mediump vec3 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = _glesVertex.xyz;
					  tmpvar_3 = (glstate_matrix_mvp * tmpvar_4);
					  highp vec4 v_5;
					  v_5.x = unity_WorldToObject[0].x;
					  v_5.y = unity_WorldToObject[1].x;
					  v_5.z = unity_WorldToObject[2].x;
					  v_5.w = unity_WorldToObject[3].x;
					  highp vec4 v_6;
					  v_6.x = unity_WorldToObject[0].y;
					  v_6.y = unity_WorldToObject[1].y;
					  v_6.z = unity_WorldToObject[2].y;
					  v_6.w = unity_WorldToObject[3].y;
					  highp vec4 v_7;
					  v_7.x = unity_WorldToObject[0].z;
					  v_7.y = unity_WorldToObject[1].z;
					  v_7.z = unity_WorldToObject[2].z;
					  v_7.w = unity_WorldToObject[3].z;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize(((
					    (v_5.xyz * _glesNormal.x)
					   + 
					    (v_6.xyz * _glesNormal.y)
					  ) + (v_7.xyz * _glesNormal.z)));
					  worldNormal_1 = tmpvar_8;
					  tmpvar_2 = worldNormal_1;
					  gl_Position = tmpvar_3;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
					  xlv_TEXCOORD4 = exp2(-((unity_FogParams.y * tmpvar_3.z)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _LightColor0;
					uniform sampler2D _MainTex;
					uniform lowp float _Cutoff;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp float xlv_TEXCOORD4;
					void main ()
					{
					  lowp vec4 c_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  lowp float x_3;
					  x_3 = (tmpvar_2.w - _Cutoff);
					  if ((x_3 < 0.0)) {
					    discard;
					  };
					  lowp vec4 c_4;
					  c_4.xyz = ((tmpvar_2.xyz * _LightColor0.xyz) * 0.4);
					  c_4.w = tmpvar_2.w;
					  c_1.w = c_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
					  c_1.xyz = (c_4.xyz * vec3(tmpvar_5));
					  gl_FragData[0] = c_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4unity_WorldToObject[4];
					uniform 	vec4 unity_FogParams;
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					out highp float vs_TEXCOORD4;
					out mediump vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z * unity_FogParams.y;
					    vs_TEXCOORD4 = exp2((-u_xlat0.x));
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[0].x;
					    u_xlat0.y = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[1].x;
					    u_xlat0.z = in_NORMAL0.x * hlslcc_mtx4unity_WorldToObject[2].x;
					    u_xlat1.x = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[0].y;
					    u_xlat1.y = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[1].y;
					    u_xlat1.z = in_NORMAL0.y * hlslcc_mtx4unity_WorldToObject[2].y;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat1.x = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[0].z;
					    u_xlat1.y = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[1].z;
					    u_xlat1.z = in_NORMAL0.z * hlslcc_mtx4unity_WorldToObject[2].z;
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = hlslcc_mtx4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _LightColor0;
					uniform 	lowp float _Cutoff;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp float vs_TEXCOORD4;
					layout(location = 0) out lowp vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec3 u_xlat10_1;
					float u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat10_1.x = u_xlat0.w + (-_Cutoff);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat10_1.x<0.0);
					#else
					    u_xlatb2 = u_xlat10_1.x<0.0;
					#endif
					    if((int(u_xlatb2) * int(0xffffffffu))!=0){discard;}
					    u_xlat10_1.xyz = u_xlat0.xyz * _LightColor0.xyz;
					    u_xlat10_1.xyz = u_xlat10_1.xyz * vec3(0.400000006, 0.400000006, 0.400000006);
					    u_xlat2 = vs_TEXCOORD4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat10_1.xyz * vec3(u_xlat2);
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
}
Program "fp" {
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "SPOT" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "POINT_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP" }
					"!!GLES3"
}
}
 }
}
Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}