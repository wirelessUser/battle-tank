Shader "Hidden/FrameDebuggerRenderTargetDisplay" {
Properties {
 _MainTex ("", any) = "white" { }
}
SubShader { 
 Tags { "ForceSupported"="true" }
 Pass {
  Tags { "ForceSupported"="true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 38886
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform sampler2D _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
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
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform sampler2D _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
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
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform sampler2D _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp sampler2D _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
  Tags { "ForceSupported"="true" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 95580
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
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
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
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
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_TEXCOORD0 = _glesMultiTexCoord0.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 _Channels;
					uniform mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					varying highp vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tex_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_MainTex, xlv_TEXCOORD0);
					  tex_1 = tmpvar_2;
					  lowp vec4 tmpvar_3;
					  mediump vec4 col_4;
					  col_4 = (tex_1 - _Levels.xxxx);
					  col_4 = (col_4 / (_Levels.yyyy - _Levels.xxxx));
					  col_4 = (col_4 * _Channels);
					  lowp float tmpvar_5;
					  tmpvar_5 = dot (_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					  if ((tmpvar_5 == 1.0)) {
					    col_4 = vec4(dot (col_4, vec4(1.0, 1.0, 1.0, 1.0)));
					  };
					  tmpvar_3 = col_4;
					  gl_FragData[0] = tmpvar_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					in highp vec4 in_POSITION0;
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
					in highp vec3 in_TEXCOORD0;
					out highp vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = u_xlat0 + hlslcc_mtx4glstate_matrix_mvp[3];
					    vs_TEXCOORD0.xyz = in_TEXCOORD0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	lowp vec4 _Channels;
					uniform 	mediump vec4 _Levels;
					uniform lowp samplerCube _MainTex;
					in highp vec3 vs_TEXCOORD0;
					layout(location = 0) out lowp vec4 SV_Target0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_0;
					mediump float u_xlat16_1;
					lowp float u_xlat10_2;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xyz);
					    u_xlat16_0 = u_xlat10_0 + (-_Levels.xxxx);
					    u_xlat16_1 = (-_Levels.x) + _Levels.y;
					    u_xlat16_0 = u_xlat16_0 / vec4(u_xlat16_1);
					    u_xlat16_0 = u_xlat16_0 * _Channels;
					    u_xlat16_1 = dot(u_xlat16_0, vec4(1.0, 1.0, 1.0, 1.0));
					    u_xlat10_2 = dot(_Channels, vec4(1.0, 1.0, 1.0, 1.0));
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(u_xlat10_2==1.0);
					#else
					    u_xlatb3 = u_xlat10_2==1.0;
					#endif
					    u_xlat16_0 = (bool(u_xlatb3)) ? vec4(u_xlat16_1) : u_xlat16_0;
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
}
Fallback Off
}