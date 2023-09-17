Shader "Time of Day/Moon" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader { 
 Tags { "QUEUE"="Background+40" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background+40" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  GpuProgramID 43673
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec4 _MainTex_ST;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((tmpvar_3 * _glesNormal));
					  tmpvar_2 = tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.z = (tmpvar_5.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonMeshColor;
					uniform highp vec3 TOD_SunDirection;
					uniform highp float TOD_MoonMeshContrast;
					uniform highp float TOD_MoonMeshBrightness;
					uniform sampler2D _MainTex;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 maintex_1;
					  mediump float alpha_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_MoonMeshColor;
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = max (0.0, dot (xlv_TEXCOORD1, TOD_SunDirection));
					  alpha_2 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = pow (alpha_2, TOD_MoonMeshContrast);
					  alpha_2 = ((clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * TOD_MoonMeshBrightness) * tmpvar_6);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
					  maintex_1 = tmpvar_7;
					  color_3.xyz = (color_3.xyz * (maintex_1 * alpha_2));
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec4 _MainTex_ST;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((tmpvar_3 * _glesNormal));
					  tmpvar_2 = tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.z = (tmpvar_5.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonMeshColor;
					uniform highp vec3 TOD_SunDirection;
					uniform highp float TOD_MoonMeshContrast;
					uniform highp float TOD_MoonMeshBrightness;
					uniform sampler2D _MainTex;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 maintex_1;
					  mediump float alpha_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_MoonMeshColor;
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = max (0.0, dot (xlv_TEXCOORD1, TOD_SunDirection));
					  alpha_2 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = pow (alpha_2, TOD_MoonMeshContrast);
					  alpha_2 = ((clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * TOD_MoonMeshBrightness) * tmpvar_6);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
					  maintex_1 = tmpvar_7;
					  color_3.xyz = (color_3.xyz * (maintex_1 * alpha_2));
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec4 _MainTex_ST;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  highp mat3 tmpvar_3;
					  tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((tmpvar_3 * _glesNormal));
					  tmpvar_2 = tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_1.z = (tmpvar_5.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonMeshColor;
					uniform highp vec3 TOD_SunDirection;
					uniform highp float TOD_MoonMeshContrast;
					uniform highp float TOD_MoonMeshBrightness;
					uniform sampler2D _MainTex;
					varying mediump vec3 xlv_TEXCOORD0;
					varying mediump vec3 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec3 maintex_1;
					  mediump float alpha_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_MoonMeshColor;
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = max (0.0, dot (xlv_TEXCOORD1, TOD_SunDirection));
					  alpha_2 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = pow (alpha_2, TOD_MoonMeshContrast);
					  alpha_2 = ((clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * TOD_MoonMeshBrightness) * tmpvar_6);
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
					  maintex_1 = tmpvar_7;
					  color_3.xyz = (color_3.xyz * (maintex_1 * alpha_2));
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					float u_xlat1;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat1;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[2].y * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[3].y * u_xlat0.w + u_xlat0.x;
					    u_xlat0.z = u_xlat0.x * 25.0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonMeshColor;
					uniform 	vec3 TOD_SunDirection;
					uniform 	float TOD_MoonMeshContrast;
					uniform 	float TOD_MoonMeshBrightness;
					uniform lowp sampler2D _MainTex;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					mediump vec3 u_xlat16_1;
					float u_xlat2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD1.xyz, TOD_SunDirection.xyz);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat0 = log2(u_xlat0);
					    u_xlat0 = u_xlat0 * TOD_MoonMeshContrast;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat16_1.x = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat16_1.x * TOD_MoonMeshBrightness;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = vec3(u_xlat0) * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz * TOD_MoonMeshColor.xyz;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					float u_xlat1;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat1;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[2].y * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[3].y * u_xlat0.w + u_xlat0.x;
					    u_xlat0.z = u_xlat0.x * 25.0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonMeshColor;
					uniform 	vec3 TOD_SunDirection;
					uniform 	float TOD_MoonMeshContrast;
					uniform 	float TOD_MoonMeshBrightness;
					uniform lowp sampler2D _MainTex;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					mediump vec3 u_xlat16_1;
					float u_xlat2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD1.xyz, TOD_SunDirection.xyz);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat0 = log2(u_xlat0);
					    u_xlat0 = u_xlat0 * TOD_MoonMeshContrast;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat16_1.x = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat16_1.x * TOD_MoonMeshBrightness;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = vec3(u_xlat0) * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz * TOD_MoonMeshColor.xyz;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 _MainTex_ST;
					in highp vec4 in_POSITION0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					float u_xlat1;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat1;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[2].y * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[3].y * u_xlat0.w + u_xlat0.x;
					    u_xlat0.z = u_xlat0.x * 25.0;
					    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = in_NORMAL0.yyy * hlslcc_mtx4unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat0.xyz;
					    u_xlat3 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat3 = inversesqrt(u_xlat3);
					    u_xlat0.xyz = vec3(u_xlat3) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonMeshColor;
					uniform 	vec3 TOD_SunDirection;
					uniform 	float TOD_MoonMeshContrast;
					uniform 	float TOD_MoonMeshBrightness;
					uniform lowp sampler2D _MainTex;
					in mediump vec3 vs_TEXCOORD0;
					in mediump vec3 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					mediump vec3 u_xlat16_1;
					float u_xlat2;
					lowp vec3 u_xlat10_2;
					void main()
					{
					    u_xlat0 = dot(vs_TEXCOORD1.xyz, TOD_SunDirection.xyz);
					    u_xlat0 = max(u_xlat0, 0.0);
					    u_xlat0 = log2(u_xlat0);
					    u_xlat0 = u_xlat0 * TOD_MoonMeshContrast;
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat16_1.x = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat2 = u_xlat16_1.x * TOD_MoonMeshBrightness;
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat16_1.xyz = vec3(u_xlat0) * u_xlat10_2.xyz;
					    SV_Target0.xyz = u_xlat16_1.xyz * TOD_MoonMeshColor.xyz;
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