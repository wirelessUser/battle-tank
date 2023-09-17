Shader "Time of Day/Space" {
Properties {
 _CubeTex ("Cube (RGB)", CUBE) = "black" { }
 _Brightness ("Brightness", Float) = 0.000000
}
SubShader { 
 Tags { "QUEUE"="Background+10" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background+10" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  GpuProgramID 6110
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp float TOD_StarVisibility;
					uniform highp float _Brightness;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  tmpvar_1.xyz = tmpvar_2;
					  tmpvar_1.w = clamp (((_Brightness * TOD_StarVisibility) * normalize(
					    (tmpvar_3 * tmpvar_2)
					  ).y), 0.0, 1.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp samplerCube _CubeTex;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_CubeTex, xlv_TEXCOORD0.xyz);
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = (tmpvar_2.xyz * xlv_TEXCOORD0.w);
					  tmpvar_1 = tmpvar_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp float TOD_StarVisibility;
					uniform highp float _Brightness;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  tmpvar_1.xyz = tmpvar_2;
					  tmpvar_1.w = clamp (((_Brightness * TOD_StarVisibility) * normalize(
					    (tmpvar_3 * tmpvar_2)
					  ).y), 0.0, 1.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp samplerCube _CubeTex;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_CubeTex, xlv_TEXCOORD0.xyz);
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = (tmpvar_2.xyz * xlv_TEXCOORD0.w);
					  tmpvar_1 = tmpvar_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp float TOD_StarVisibility;
					uniform highp float _Brightness;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  tmpvar_1.xyz = tmpvar_2;
					  tmpvar_1.w = clamp (((_Brightness * TOD_StarVisibility) * normalize(
					    (tmpvar_3 * tmpvar_2)
					  ).y), 0.0, 1.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp samplerCube _CubeTex;
					varying highp vec4 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = textureCube (_CubeTex, xlv_TEXCOORD0.xyz);
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = (tmpvar_2.xyz * xlv_TEXCOORD0.w);
					  tmpvar_1 = tmpvar_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	float TOD_StarVisibility;
					uniform 	float _Brightness;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat2 = TOD_StarVisibility * _Brightness;
					    vs_TEXCOORD0.w = u_xlat0.x * u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD0.w = min(max(vs_TEXCOORD0.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD0.w = clamp(vs_TEXCOORD0.w, 0.0, 1.0);
					#endif
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp samplerCube _CubeTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					void main()
					{
					    u_xlat10_0.xyz = texture(_CubeTex, vs_TEXCOORD0.xyz).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD0.www;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	float TOD_StarVisibility;
					uniform 	float _Brightness;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat2 = TOD_StarVisibility * _Brightness;
					    vs_TEXCOORD0.w = u_xlat0.x * u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD0.w = min(max(vs_TEXCOORD0.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD0.w = clamp(vs_TEXCOORD0.w, 0.0, 1.0);
					#endif
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp samplerCube _CubeTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					void main()
					{
					    u_xlat10_0.xyz = texture(_CubeTex, vs_TEXCOORD0.xyz).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD0.www;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	float TOD_StarVisibility;
					uniform 	float _Brightness;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat1.y;
					    u_xlat2 = TOD_StarVisibility * _Brightness;
					    vs_TEXCOORD0.w = u_xlat0.x * u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    vs_TEXCOORD0.w = min(max(vs_TEXCOORD0.w, 0.0), 1.0);
					#else
					    vs_TEXCOORD0.w = clamp(vs_TEXCOORD0.w, 0.0, 1.0);
					#endif
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp samplerCube _CubeTex;
					in highp vec4 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec3 u_xlat10_0;
					void main()
					{
					    u_xlat10_0.xyz = texture(_CubeTex, vs_TEXCOORD0.xyz).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * vs_TEXCOORD0.www;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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