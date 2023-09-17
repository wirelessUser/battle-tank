Shader "Hidden/Time of Day/God Rays" {
Properties {
 _MainTex ("Base", 2D) = "" { }
 _ColorBuffer ("Color", 2D) = "" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 17790
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (1.0 - ((1.0 - colorA_2) * (1.0 - 
					    clamp ((colorB_1 * _LightColor), 0.0, 1.0)
					  )));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (1.0 - ((1.0 - colorA_2) * (1.0 - 
					    clamp ((colorB_1 * _LightColor), 0.0, 1.0)
					  )));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (1.0 - ((1.0 - colorA_2) * (1.0 - 
					    clamp ((colorB_1 * _LightColor), 0.0, 1.0)
					  )));
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat16_0 = (-u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat16_0 = (-u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat16_0 = (-u_xlat16_0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_1 = (-u_xlat10_1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat16_0 = (-u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = u_xlat16_0;
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
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 74878
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform mediump vec4 _BlurRadius4;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  highp vec2 tmpvar_3;
					  tmpvar_2 = tmpvar_1;
					  tmpvar_3 = ((_LightPosition.xy - _glesMultiTexCoord0.xy) * _BlurRadius4.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 tmpvar_1;
					  mediump vec4 color_2;
					  mediump vec4 tmpColor_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpColor_3 = tmpvar_4;
					  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_5 = tmpvar_6;
					  color_2 = (tmpColor_3 + tmpColor_5);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_7 = tmpvar_8;
					  color_2 = (color_2 + tmpColor_7);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_9 = tmpvar_10;
					  color_2 = (color_2 + tmpColor_9);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_11 = tmpvar_12;
					  color_2 = (color_2 + tmpColor_11);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_13 = tmpvar_14;
					  color_2 = (color_2 + tmpColor_13);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  gl_FragData[0] = (color_2 / 6.0);
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform mediump vec4 _BlurRadius4;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  highp vec2 tmpvar_3;
					  tmpvar_2 = tmpvar_1;
					  tmpvar_3 = ((_LightPosition.xy - _glesMultiTexCoord0.xy) * _BlurRadius4.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 tmpvar_1;
					  mediump vec4 color_2;
					  mediump vec4 tmpColor_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpColor_3 = tmpvar_4;
					  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_5 = tmpvar_6;
					  color_2 = (tmpColor_3 + tmpColor_5);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_7 = tmpvar_8;
					  color_2 = (color_2 + tmpColor_7);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_9 = tmpvar_10;
					  color_2 = (color_2 + tmpColor_9);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_11 = tmpvar_12;
					  color_2 = (color_2 + tmpColor_11);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_13 = tmpvar_14;
					  color_2 = (color_2 + tmpColor_13);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  gl_FragData[0] = (color_2 / 6.0);
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform mediump vec4 _BlurRadius4;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  highp vec2 tmpvar_3;
					  tmpvar_2 = tmpvar_1;
					  tmpvar_3 = ((_LightPosition.xy - _glesMultiTexCoord0.xy) * _BlurRadius4.xy);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec2 tmpvar_1;
					  mediump vec4 color_2;
					  mediump vec4 tmpColor_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  tmpColor_3 = tmpvar_4;
					  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_5 = tmpvar_6;
					  color_2 = (tmpColor_3 + tmpColor_5);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_7 = tmpvar_8;
					  color_2 = (color_2 + tmpColor_7);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_9;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_9 = tmpvar_10;
					  color_2 = (color_2 + tmpColor_9);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_11;
					  lowp vec4 tmpvar_12;
					  tmpvar_12 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_11 = tmpvar_12;
					  color_2 = (color_2 + tmpColor_11);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  mediump vec4 tmpColor_13;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_MainTex, tmpvar_1);
					  tmpColor_13 = tmpvar_14;
					  color_2 = (color_2 + tmpColor_13);
					  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
					  gl_FragData[0] = (color_2 / 6.0);
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	mediump vec4 _BlurRadius4;
					uniform 	mediump vec4 _LightPosition;
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec2 u_xlat16_1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat16_1.xy = (-in_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_0.zw = u_xlat16_1.xy * _BlurRadius4.xy;
					    u_xlat16_0.xy = in_TEXCOORD0.xy;
					    phase0_Output0_1 = u_xlat16_0;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_2;
					int u_xlati6;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat16_1.x = float(0.0);
					    u_xlat16_1.y = float(0.0);
					    u_xlat16_1.z = float(0.0);
					    u_xlat16_1.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
					    {
					        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
					        u_xlat16_1 = u_xlat16_1 + u_xlat10_2;
					        u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
					    }
					    u_xlat16_0 = u_xlat16_1 * vec4(0.166666672, 0.166666672, 0.166666672, 0.166666672);
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	mediump vec4 _BlurRadius4;
					uniform 	mediump vec4 _LightPosition;
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec2 u_xlat16_1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat16_1.xy = (-in_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_0.zw = u_xlat16_1.xy * _BlurRadius4.xy;
					    u_xlat16_0.xy = in_TEXCOORD0.xy;
					    phase0_Output0_1 = u_xlat16_0;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_2;
					int u_xlati6;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat16_1.x = float(0.0);
					    u_xlat16_1.y = float(0.0);
					    u_xlat16_1.z = float(0.0);
					    u_xlat16_1.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
					    {
					        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
					        u_xlat16_1 = u_xlat16_1 + u_xlat10_2;
					        u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
					    }
					    u_xlat16_0 = u_xlat16_1 * vec4(0.166666672, 0.166666672, 0.166666672, 0.166666672);
					    SV_Target0 = u_xlat16_0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	mediump vec4 _BlurRadius4;
					uniform 	mediump vec4 _LightPosition;
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec2 u_xlat16_1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat16_1.xy = (-in_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_0.zw = u_xlat16_1.xy * _BlurRadius4.xy;
					    u_xlat16_0.xy = in_TEXCOORD0.xy;
					    phase0_Output0_1 = u_xlat16_0;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					mediump vec4 u_xlat16_0;
					mediump vec4 u_xlat16_1;
					lowp vec4 u_xlat10_2;
					int u_xlati6;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat16_1.x = float(0.0);
					    u_xlat16_1.y = float(0.0);
					    u_xlat16_1.z = float(0.0);
					    u_xlat16_1.w = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<6 ; u_xlati_loop_1++)
					    {
					        u_xlat10_2 = texture(_MainTex, u_xlat0.xy);
					        u_xlat16_1 = u_xlat16_1 + u_xlat10_2;
					        u_xlat0.xy = vec2(u_xlat0.x + vs_TEXCOORD1.x, u_xlat0.y + vs_TEXCOORD1.y);
					    }
					    u_xlat16_0 = u_xlat16_1 * vec4(0.166666672, 0.166666672, 0.166666672, 0.166666672);
					    SV_Target0 = u_xlat16_0;
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
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 156723
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
					  highp vec2 tmpvar_5;
					  tmpvar_5 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_5;
					  mediump float tmpvar_6;
					  tmpvar_6 = clamp ((_LightPosition.w - sqrt(
					    dot (vec_1, vec_1)
					  )), 0.0, 1.0);
					  mediump float tmpvar_7;
					  if ((tmpvar_4 > 0.99)) {
					    tmpvar_7 = ((1.01 - sceneColor_2.w) * tmpvar_6);
					  } else {
					    tmpvar_7 = 0.0;
					  };
					  gl_FragData[0] = vec4(tmpvar_7);
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
					  highp vec2 tmpvar_5;
					  tmpvar_5 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_5;
					  mediump float tmpvar_6;
					  tmpvar_6 = clamp ((_LightPosition.w - sqrt(
					    dot (vec_1, vec_1)
					  )), 0.0, 1.0);
					  mediump float tmpvar_7;
					  if ((tmpvar_4 > 0.99)) {
					    tmpvar_7 = ((1.01 - sceneColor_2.w) * tmpvar_6);
					  } else {
					    tmpvar_7 = 0.0;
					  };
					  gl_FragData[0] = vec4(tmpvar_7);
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x) + _ZBufferParams.y)));
					  highp vec2 tmpvar_5;
					  tmpvar_5 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_5;
					  mediump float tmpvar_6;
					  tmpvar_6 = clamp ((_LightPosition.w - sqrt(
					    dot (vec_1, vec_1)
					  )), 0.0, 1.0);
					  mediump float tmpvar_7;
					  if ((tmpvar_4 > 0.99)) {
					    tmpvar_7 = ((1.01 - sceneColor_2.w) * tmpvar_6);
					  } else {
					    tmpvar_7 = 0.0;
					  };
					  gl_FragData[0] = vec4(tmpvar_7);
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.99000001<u_xlat0.x);
					#else
					    u_xlatb0 = 0.99000001<u_xlat0.x;
					#endif
					    SV_Target0 = (bool(u_xlatb0)) ? vec4(u_xlat16_1) : vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.99000001<u_xlat0.x);
					#else
					    u_xlatb0 = 0.99000001<u_xlat0.x;
					#endif
					    SV_Target0 = (bool(u_xlatb0)) ? vec4(u_xlat16_1) : vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					bool u_xlatb0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    u_xlat16_1 = u_xlat16_1 * u_xlat16_3;
					    u_xlat0.x = texture(_CameraDepthTexture, vs_TEXCOORD0.xy).x;
					    u_xlat0.x = _ZBufferParams.x * u_xlat0.x + _ZBufferParams.y;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb0 = !!(0.99000001<u_xlat0.x);
					#else
					    u_xlatb0 = 0.99000001<u_xlat0.x;
					#endif
					    SV_Target0 = (bool(u_xlatb0)) ? vec4(u_xlat16_1) : vec4(0.0, 0.0, 0.0, 0.0);
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
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 248048
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_4;
					  gl_FragData[0] = vec4(((1.01 - sceneColor_2.w) * clamp ((_LightPosition.w - 
					    sqrt(dot (vec_1, vec_1))
					  ), 0.0, 1.0)));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_4;
					  gl_FragData[0] = vec4(((1.01 - sceneColor_2.w) * clamp ((_LightPosition.w - 
					    sqrt(dot (vec_1, vec_1))
					  ), 0.0, 1.0)));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform mediump vec4 _LightPosition;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 vec_1;
					  mediump vec4 sceneColor_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_2 = tmpvar_3;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_LightPosition.xy - xlv_TEXCOORD0);
					  vec_1 = tmpvar_4;
					  gl_FragData[0] = vec4(((1.01 - sceneColor_2.w) * clamp ((_LightPosition.w - 
					    sqrt(dot (vec_1, vec_1))
					  ), 0.0, 1.0)));
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    SV_Target0 = vec4(u_xlat16_1) * vec4(u_xlat16_3);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    SV_Target0 = vec4(u_xlat16_1) * vec4(u_xlat16_3);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightPosition;
					uniform lowp sampler2D _MainTex;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec2 u_xlat0;
					lowp float u_xlat10_0;
					mediump float u_xlat16_1;
					mediump float u_xlat16_3;
					void main()
					{
					    u_xlat0.xy = (-vs_TEXCOORD0.xy) + _LightPosition.xy;
					    u_xlat16_1 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat16_1 = sqrt(u_xlat16_1);
					    u_xlat16_1 = (-u_xlat16_1) + _LightPosition.w;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
					    u_xlat16_3 = (-u_xlat10_0) + 1.00999999;
					    SV_Target0 = vec4(u_xlat16_1) * vec4(u_xlat16_3);
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
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 295868
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (colorA_2 + clamp ((colorB_1 * _LightColor), 0.0, 1.0));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (colorA_2 + clamp ((colorB_1 * _LightColor), 0.0, 1.0));
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec2 tmpvar_1;
					  tmpvar_1 = _glesMultiTexCoord0.xy;
					  highp vec2 tmpvar_2;
					  tmpvar_2 = tmpvar_1;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					uniform sampler2D _ColorBuffer;
					uniform mediump vec4 _LightColor;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 colorB_1;
					  mediump vec4 colorA_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
					  colorA_2 = tmpvar_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
					  colorB_1 = tmpvar_4;
					  gl_FragData[0] = (colorA_2 + clamp ((colorB_1 * _LightColor), 0.0, 1.0));
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat16_0 + u_xlat10_1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat16_0 + u_xlat10_1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	mediump vec4 _LightColor;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _ColorBuffer;
					in highp vec2 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					lowp vec4 u_xlat10_1;
					void main()
					{
					    u_xlat10_0 = texture(_ColorBuffer, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 * _LightColor;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
					#else
					    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    SV_Target0 = u_xlat16_0 + u_xlat10_1;
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
}
 }
}
Fallback Off
}