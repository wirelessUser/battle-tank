Shader "Time of Day/Stars" {
SubShader { 
 Tags { "QUEUE"="Background+20" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background+20" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  Blend One One
  GpuProgramID 27616
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = sqrt(tmpvar_2);
					  tmpvar_2 = tmpvar_10;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_10;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = sqrt(tmpvar_2);
					  tmpvar_2 = tmpvar_10;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_10;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = sqrt(tmpvar_2);
					  tmpvar_2 = tmpvar_10;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_10;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    vs_COLOR0.xyz = sqrt(vec3(u_xlat6));
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    vs_COLOR0.xyz = sqrt(vec3(u_xlat6));
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat6 = u_xlat1.x / u_xlat6;
					    vs_COLOR0.xyz = sqrt(vec3(u_xlat6));
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 glstate_matrix_projection;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_StarSize;
					uniform highp float TOD_StarBrightness;
					uniform highp float TOD_StarVisibility;
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = _glesVertex.w;
					  mediump vec4 tmpvar_2;
					  mediump vec3 tmpvar_3;
					  highp float tmpvar_4;
					  tmpvar_4 = ((4.0 * (1.0/(
					    max (0.1, glstate_matrix_projection[0].x)
					  ))) / _ScreenParams.x);
					  highp float tmpvar_5;
					  tmpvar_5 = (((TOD_StarBrightness * TOD_StarVisibility) * (1e-05 * _glesColor.w)) / (tmpvar_4 * tmpvar_4));
					  highp float tmpvar_6;
					  tmpvar_6 = (TOD_StarSize * tmpvar_4);
					  tmpvar_1.xyz = (_glesVertex.xyz - ((_glesTANGENT.xyz * 
					    (_glesMultiTexCoord0.x - 0.5)
					  ) * tmpvar_6));
					  tmpvar_1.xyz = (tmpvar_1.xyz - ((
					    ((_glesNormal.yzx * _glesTANGENT.zxy) - (_glesNormal.zxy * _glesTANGENT.yzx))
					   * 
					    (_glesMultiTexCoord0.y - 0.5)
					  ) * tmpvar_6));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (TOD_World2Sky * (unity_ObjectToWorld * tmpvar_1)).xyz;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = ((2.0 * _glesMultiTexCoord0) - 1.0).xy;
					  tmpvar_3.xy = tmpvar_8;
					  tmpvar_3.z = (tmpvar_7.y * 25.0);
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.x = tmpvar_5;
					  tmpvar_9.y = tmpvar_5;
					  tmpvar_9.z = tmpvar_5;
					  tmpvar_2 = tmpvar_9;
					  gl_Position = (glstate_matrix_mvp * tmpvar_1);
					  xlv_COLOR = tmpvar_2;
					  xlv_TEXCOORD0 = tmpvar_3;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying mediump vec4 xlv_COLOR;
					varying mediump vec3 xlv_TEXCOORD0;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  tmpvar_1.xyz = (xlv_COLOR.xyz * (clamp (xlv_TEXCOORD0.z, 0.0, 1.0) * clamp (
					    (1.0 - sqrt(dot (xlv_TEXCOORD0.xy, xlv_TEXCOORD0.xy)))
					  , 0.0, 1.0)));
					  tmpvar_1.w = xlv_COLOR.w;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat1.xyz = u_xlat1.xxx / vec3(u_xlat6);
					    vs_COLOR0.xyz = u_xlat1.xyz;
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat1.xyz = u_xlat1.xxx / vec3(u_xlat6);
					    vs_COLOR0.xyz = u_xlat1.xyz;
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_projection[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_StarSize;
					uniform 	float TOD_StarBrightness;
					uniform 	float TOD_StarVisibility;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					in lowp vec4 in_COLOR0;
					out mediump vec4 vs_COLOR0;
					out mediump vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat6;
					float u_xlat7;
					void main()
					{
					    u_xlat0.xyz = in_TANGENT0.yzx * in_NORMAL0.zxy;
					    u_xlat0.xyz = in_NORMAL0.yzx * in_TANGENT0.zxy + (-u_xlat0.xyz);
					    u_xlat1.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.yyy;
					    u_xlat1.xyz = u_xlat1.xxx * in_TANGENT0.xyz;
					    u_xlat6 = max(hlslcc_mtx4glstate_matrix_projection[0].x, 0.100000001);
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat6 = u_xlat6 * 4.0;
					    u_xlat6 = u_xlat6 / _ScreenParams.x;
					    u_xlat7 = u_xlat6 * TOD_StarSize;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat1.xyz = (-u_xlat1.xyz) * vec3(u_xlat7) + in_POSITION0.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat7) + u_xlat1.xyz;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = hlslcc_mtx4glstate_matrix_mvp[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat1.x = TOD_StarVisibility * TOD_StarBrightness;
					    u_xlat1.x = u_xlat1.x * 9.99999975e-006;
					    u_xlat1.x = u_xlat1.x * in_COLOR0.w;
					    u_xlat1.xyz = u_xlat1.xxx / vec3(u_xlat6);
					    vs_COLOR0.xyz = u_xlat1.xyz;
					    vs_COLOR0.w = 1.0;
					    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat1 = hlslcc_mtx4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat0.y * hlslcc_mtx4TOD_World2Sky[1].y;
					    u_xlat0.x = hlslcc_mtx4TOD_World2Sky[0].y * u_xlat0.x + u_xlat2;
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
					in mediump vec4 vs_COLOR0;
					in mediump vec3 vs_TEXCOORD0;
					layout(location = 0) out mediump vec4 SV_Target0;
					mediump float u_xlat16_0;
					mediump float u_xlat16_1;
					void main()
					{
					    u_xlat16_0 = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat16_0 = sqrt(u_xlat16_0);
					    u_xlat16_0 = (-u_xlat16_0) + 1.0;
					    u_xlat16_0 = max(u_xlat16_0, 0.0);
					    u_xlat16_1 = vs_TEXCOORD0.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
					#else
					    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
					#endif
					    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
					    SV_Target0.xyz = vec3(u_xlat16_0) * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
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
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
}
 }
}
Fallback Off
}