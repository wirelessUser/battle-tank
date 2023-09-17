Shader "Time of Day/Sun" {
SubShader { 
 Tags { "QUEUE"="Background+30" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background+30" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  Blend One One
  GpuProgramID 60204
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_1.xy = tmpvar_3;
					  tmpvar_1.z = (tmpvar_2.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_SunMeshColor;
					uniform highp float TOD_SunMeshContrast;
					uniform highp float TOD_SunMeshBrightness;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float glow_1;
					  mediump float sun_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_SunMeshColor;
					  color_3 = tmpvar_4;
					  mediump float tmpvar_5;
					  tmpvar_5 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
					  mediump float tmpvar_6;
					  tmpvar_6 = float((0.5 >= tmpvar_5));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * TOD_SunMeshBrightness);
					  sun_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp ((1.0 - pow (tmpvar_5, TOD_SunMeshContrast)), 0.0, 1.0);
					  highp float tmpvar_9;
					  tmpvar_9 = ((tmpvar_8 * (tmpvar_8 * 
					    (3.0 - (2.0 * tmpvar_8))
					  )) * clamp (TOD_SunMeshBrightness, 0.0, 1.0));
					  glow_1 = tmpvar_9;
					  color_3.xyz = (color_3.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * (sun_2 + glow_1)));
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_1.xy = tmpvar_3;
					  tmpvar_1.z = (tmpvar_2.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_SunMeshColor;
					uniform highp float TOD_SunMeshContrast;
					uniform highp float TOD_SunMeshBrightness;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float glow_1;
					  mediump float sun_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_SunMeshColor;
					  color_3 = tmpvar_4;
					  mediump float tmpvar_5;
					  tmpvar_5 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
					  mediump float tmpvar_6;
					  tmpvar_6 = float((0.5 >= tmpvar_5));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * TOD_SunMeshBrightness);
					  sun_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp ((1.0 - pow (tmpvar_5, TOD_SunMeshContrast)), 0.0, 1.0);
					  highp float tmpvar_9;
					  tmpvar_9 = ((tmpvar_8 * (tmpvar_8 * 
					    (3.0 - (2.0 * tmpvar_8))
					  )) * clamp (TOD_SunMeshBrightness, 0.0, 1.0));
					  glow_1 = tmpvar_9;
					  color_3.xyz = (color_3.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * (sun_2 + glow_1)));
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = (TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz;
					  highp vec2 tmpvar_3;
					  tmpvar_3 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_1.xy = tmpvar_3;
					  tmpvar_1.z = (tmpvar_2.y * 25.0);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_SunMeshColor;
					uniform highp float TOD_SunMeshContrast;
					uniform highp float TOD_SunMeshBrightness;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump float glow_1;
					  mediump float sun_2;
					  mediump vec4 color_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = TOD_SunMeshColor;
					  color_3 = tmpvar_4;
					  mediump float tmpvar_5;
					  tmpvar_5 = sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy));
					  mediump float tmpvar_6;
					  tmpvar_6 = float((0.5 >= tmpvar_5));
					  highp float tmpvar_7;
					  tmpvar_7 = (tmpvar_6 * TOD_SunMeshBrightness);
					  sun_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = clamp ((1.0 - pow (tmpvar_5, TOD_SunMeshContrast)), 0.0, 1.0);
					  highp float tmpvar_9;
					  tmpvar_9 = ((tmpvar_8 * (tmpvar_8 * 
					    (3.0 - (2.0 * tmpvar_8))
					  )) * clamp (TOD_SunMeshBrightness, 0.0, 1.0));
					  glow_1 = tmpvar_9;
					  color_3.xyz = (color_3.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * (sun_2 + glow_1)));
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
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_SunMeshColor;
					uniform 	float TOD_SunMeshContrast;
					uniform 	float TOD_SunMeshBrightness;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					float u_xlat1;
					mediump float u_xlat16_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat5;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_1 = log2(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(0.5>=u_xlat16_0);
					#else
					    u_xlatb3 = 0.5>=u_xlat16_0;
					#endif
					    u_xlat3 = u_xlatb3 ? TOD_SunMeshBrightness : float(0.0);
					    u_xlat1 = u_xlat16_1 * TOD_SunMeshContrast;
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + 1.0;
					    u_xlat1 = max(u_xlat1, 0.0);
					    u_xlat5 = u_xlat1 * -2.0 + 3.0;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat5;
					    u_xlat5 = TOD_SunMeshBrightness;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat1 * u_xlat5 + u_xlat3;
					    u_xlat16_2 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
					#else
					    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
					    SV_Target0.xyz = vec3(u_xlat16_0) * TOD_SunMeshColor.xyz;
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
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_SunMeshColor;
					uniform 	float TOD_SunMeshContrast;
					uniform 	float TOD_SunMeshBrightness;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					float u_xlat1;
					mediump float u_xlat16_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat5;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_1 = log2(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(0.5>=u_xlat16_0);
					#else
					    u_xlatb3 = 0.5>=u_xlat16_0;
					#endif
					    u_xlat3 = u_xlatb3 ? TOD_SunMeshBrightness : float(0.0);
					    u_xlat1 = u_xlat16_1 * TOD_SunMeshContrast;
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + 1.0;
					    u_xlat1 = max(u_xlat1, 0.0);
					    u_xlat5 = u_xlat1 * -2.0 + 3.0;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat5;
					    u_xlat5 = TOD_SunMeshBrightness;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat1 * u_xlat5 + u_xlat3;
					    u_xlat16_2 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
					#else
					    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
					    SV_Target0.xyz = vec3(u_xlat16_0) * TOD_SunMeshColor.xyz;
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
					in highp vec4 in_POSITION0;
					in highp vec4 in_TEXCOORD0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					float u_xlat1;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    vs_TEXCOORD0.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_SunMeshColor;
					uniform 	float TOD_SunMeshContrast;
					uniform 	float TOD_SunMeshBrightness;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					float u_xlat1;
					mediump float u_xlat16_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					bool u_xlatb3;
					float u_xlat5;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_1 = log2(u_xlat16_0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb3 = !!(0.5>=u_xlat16_0);
					#else
					    u_xlatb3 = 0.5>=u_xlat16_0;
					#endif
					    u_xlat3 = u_xlatb3 ? TOD_SunMeshBrightness : float(0.0);
					    u_xlat1 = u_xlat16_1 * TOD_SunMeshContrast;
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + 1.0;
					    u_xlat1 = max(u_xlat1, 0.0);
					    u_xlat5 = u_xlat1 * -2.0 + 3.0;
					    u_xlat1 = u_xlat1 * u_xlat1;
					    u_xlat1 = u_xlat1 * u_xlat5;
					    u_xlat5 = TOD_SunMeshBrightness;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat1 * u_xlat5 + u_xlat3;
					    u_xlat16_2 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
					#else
					    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_2;
					    SV_Target0.xyz = vec3(u_xlat16_0) * TOD_SunMeshColor.xyz;
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