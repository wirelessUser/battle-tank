Shader "Hidden/Time of Day/Cloud Shadows" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _CloudTex ("Alpha Layers (RGB)", 2D) = "white" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 18769
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
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
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
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
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudDensity;
					  density_10.yz = ((tmpvar_12.xx - TOD_CloudCoverage) * tmpvar_13);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_14;
					  mediump float tmpvar_15;
					  tmpvar_15 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_16;
					  highp float tmpvar_17;
					  tmpvar_17 = clamp (((tmpvar_15 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
					    (2.0 * tmpvar_17)
					  )));
					  a_2 = (a_2 * (tmpvar_16 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_18;
					    tmpvar_18.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_18.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_18;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					float u_xlat9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  highp vec2 tmpvar_16;
					  tmpvar_16 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_16;
					  highp vec2 tmpvar_17;
					  tmpvar_17 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_17;
					  highp vec2 tmpvar_18;
					  tmpvar_18 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_18;
					  mediump vec2 tmpvar_19;
					  tmpvar_19 = clamp (((tmpvar_15.xx - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_19 * (tmpvar_19 * 
					    (3.0 - (2.0 * tmpvar_19))
					  )) + (clamp (
					    (tmpvar_15.xx - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_20;
					  tmpvar_20.x = TOD_CloudAttenuation;
					  tmpvar_20.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_20);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_21;
					  tmpvar_21 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_21;
					  mediump float tmpvar_22;
					  tmpvar_22 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_23;
					  highp float tmpvar_24;
					  tmpvar_24 = clamp (((tmpvar_22 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_23 = (tmpvar_24 * (tmpvar_24 * (3.0 - 
					    (2.0 * tmpvar_24)
					  )));
					  a_2 = (a_2 * (tmpvar_23 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_25;
					    tmpvar_25.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_25.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_25;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec2 u_xlat2;
					mediump float u_xlat16_3;
					vec3 u_xlat5;
					lowp float u_xlat10_5;
					mediump float u_xlat16_7;
					float u_xlat9;
					mediump float u_xlat16_11;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat5.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat5.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat5.xx + u_xlat2.xy;
					    u_xlat5.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat5.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + TOD_CloudWind.xz;
					    u_xlat10_5 = texture(_CloudTex, u_xlat5.xy).x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_3 = u_xlat10_5 + (-TOD_CloudCoverage);
					        u_xlat16_7 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_3 = min(max(u_xlat16_3, 0.0), 1.0);
					#else
					        u_xlat16_3 = clamp(u_xlat16_3, 0.0, 1.0);
					#endif
					        u_xlat16_7 = u_xlat16_3 * -2.0 + 3.0;
					        u_xlat16_3 = u_xlat16_3 * u_xlat16_3;
					        u_xlat16_11 = (-u_xlat1) + u_xlat10_5;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
					#else
					        u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
					#endif
					        u_xlat16_11 = u_xlat16_11 * TOD_CloudDensity;
					        u_xlat16_3 = u_xlat16_7 * u_xlat16_3 + u_xlat16_11;
					        u_xlat16_3 = u_xlat16_3 * TOD_CloudAttenuation;
					        u_xlat16_3 = exp2((-u_xlat16_3));
					        u_xlat16_3 = (-u_xlat16_3) + 1.0;
					        u_xlat1 = u_xlat16_3 * TOD_CloudOpacity;
					        u_xlat16_3 = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat5.x = u_xlat16_3 + (-_Cutoff);
					        u_xlat9 = float(1.0) / _Fade;
					        u_xlat5.x = u_xlat9 * u_xlat5.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
					#else
					        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					#endif
					        u_xlat9 = u_xlat5.x * -2.0 + 3.0;
					        u_xlat5.x = u_xlat5.x * u_xlat5.x;
					        u_xlat5.x = u_xlat5.x * u_xlat9;
					        u_xlat5.x = u_xlat5.x * _Intensity;
					        u_xlat16_3 = (-u_xlat1) * u_xlat5.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * vec3(u_xlat16_3);
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec3 density_10;
					  density_10.x = 0.0;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_11;
					  lowp vec4 tmpvar_13;
					  tmpvar_13 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_14;
					  tmpvar_14 = tmpvar_13;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_15;
					  lowp vec4 tmpvar_17;
					  tmpvar_17 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_17;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_12.x;
					  tmpvar_19.y = (tmpvar_12.y + tmpvar_14.y);
					  tmpvar_19.z = ((tmpvar_12.z + tmpvar_14.z) + tmpvar_16.z);
					  tmpvar_19.w = ((tmpvar_12.w + tmpvar_14.w) + (tmpvar_16.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_12.x;
					  tmpvar_20.y = tmpvar_14.y;
					  tmpvar_20.z = tmpvar_16.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_10.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_10.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = TOD_CloudAttenuation;
					  tmpvar_21.y = TOD_CloudDensity;
					  density_10.yz = ((density_10.yz - TOD_CloudCoverage) * tmpvar_21);
					  density_10.x = clamp (density_10.z, 0.0, 1.0);
					  highp float tmpvar_22;
					  tmpvar_22 = (TOD_CloudOpacity * density_10.y);
					  a_2 = tmpvar_22;
					  mediump float tmpvar_23;
					  tmpvar_23 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_24;
					  highp float tmpvar_25;
					  tmpvar_25 = clamp (((tmpvar_23 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_24 = (tmpvar_25 * (tmpvar_25 * (3.0 - 
					    (2.0 * tmpvar_25)
					  )));
					  a_2 = (a_2 * (tmpvar_24 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_26;
					    tmpvar_26.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_26.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_26;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					float u_xlat11;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat1 = u_xlat1 * TOD_CloudAttenuation;
					        u_xlat1 = u_xlat1 * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  mediump vec2 tmpvar_2;
					  tmpvar_2 = _glesMultiTexCoord0.xy;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xyw = tmpvar_1.xyw;
					  mediump float index_4;
					  highp vec2 tmpvar_5;
					  highp vec2 tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = tmpvar_1.z;
					  index_4 = tmpvar_7;
					  tmpvar_3.z = 0.1;
					  tmpvar_5 = tmpvar_2;
					  tmpvar_6 = tmpvar_2;
					  mediump int i_8;
					  i_8 = int(index_4);
					  mediump vec4 v_9;
					  v_9.x = _FrustumCornersWS[0][i_8];
					  v_9.y = _FrustumCornersWS[1][i_8];
					  v_9.z = _FrustumCornersWS[2][i_8];
					  v_9.w = _FrustumCornersWS[3][i_8];
					  highp vec3 tmpvar_10;
					  tmpvar_10 = v_9.xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = tmpvar_10;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _ZBufferParams;
					uniform mediump vec4 unity_ColorSpaceLuminance;
					uniform highp mat4 TOD_World2Sky;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform highp vec3 TOD_CloudWind;
					uniform sampler2D _MainTex;
					uniform sampler2D _CloudTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp float _Cutoff;
					uniform highp float _Fade;
					uniform highp float _Intensity;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 tmpvar_1;
					  mediump float a_2;
					  highp vec4 cloudUV_3;
					  mediump vec4 sceneColor_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
					  sceneColor_4 = tmpvar_5;
					  highp float tmpvar_6;
					  tmpvar_6 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = TOD_World2Sky[0].xyz;
					  tmpvar_7[1] = TOD_World2Sky[1].xyz;
					  tmpvar_7[2] = TOD_World2Sky[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (tmpvar_7 * (_WorldSpaceCameraPos + (tmpvar_6 * xlv_TEXCOORD2)));
					  cloudUV_3.xy = (tmpvar_8.xz + TOD_CloudWind.xz);
					  highp mat2 tmpvar_9;
					  tmpvar_9[0].x = 0.9848077;
					  tmpvar_9[0].y = 0.1736482;
					  tmpvar_9[1].x = -0.1736482;
					  tmpvar_9[1].y = 0.9848077;
					  cloudUV_3.zw = ((tmpvar_9 * tmpvar_8.xz) + TOD_CloudWind.xz);
					  mediump vec2 stepC_10;
					  mediump vec2 stepB_11;
					  mediump vec2 stepA_12;
					  mediump vec3 density_13;
					  density_13.x = 0.0;
					  lowp vec4 tmpvar_14;
					  tmpvar_14 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_14;
					  lowp vec4 tmpvar_16;
					  tmpvar_16 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_17;
					  tmpvar_17 = tmpvar_16;
					  lowp vec4 tmpvar_18;
					  tmpvar_18 = texture2D (_CloudTex, cloudUV_3.xy);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_18;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_CloudTex, cloudUV_3.zw);
					  mediump vec4 tmpvar_21;
					  tmpvar_21 = tmpvar_20;
					  mediump vec4 tmpvar_22;
					  tmpvar_22.x = tmpvar_15.x;
					  tmpvar_22.y = (tmpvar_15.y + tmpvar_17.y);
					  tmpvar_22.z = ((tmpvar_15.z + tmpvar_17.z) + tmpvar_19.z);
					  tmpvar_22.w = ((tmpvar_15.w + tmpvar_17.w) + (tmpvar_19.w + tmpvar_21.w));
					  mediump vec4 tmpvar_23;
					  tmpvar_23.x = tmpvar_15.x;
					  tmpvar_23.y = tmpvar_17.y;
					  tmpvar_23.z = tmpvar_19.z;
					  tmpvar_23.w = tmpvar_21.w;
					  density_13.y = dot (tmpvar_22, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_13.z = dot (tmpvar_23, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudCoverage);
					  stepA_12 = tmpvar_24;
					  highp vec2 tmpvar_25;
					  tmpvar_25 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_11 = tmpvar_25;
					  highp vec2 tmpvar_26;
					  tmpvar_26 = vec2(TOD_CloudDensity);
					  stepC_10 = tmpvar_26;
					  mediump vec2 tmpvar_27;
					  tmpvar_27 = clamp (((density_13.yz - stepA_12) / (stepB_11 - stepA_12)), 0.0, 1.0);
					  density_13.yz = ((tmpvar_27 * (tmpvar_27 * 
					    (3.0 - (2.0 * tmpvar_27))
					  )) + (clamp (
					    (density_13.yz - stepB_11)
					  , 0.0, 1.0) * stepC_10));
					  density_13.x = clamp (density_13.z, 0.0, 1.0);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = TOD_CloudAttenuation;
					  tmpvar_28.y = TOD_CloudSaturation;
					  density_13.yz = (density_13.yz * tmpvar_28);
					  density_13.yz = (1.0 - exp2(-(density_13.yz)));
					  highp float tmpvar_29;
					  tmpvar_29 = (TOD_CloudOpacity * density_13.y);
					  a_2 = tmpvar_29;
					  mediump float tmpvar_30;
					  tmpvar_30 = dot (sceneColor_4.xyz, unity_ColorSpaceLuminance.xyz);
					  highp float tmpvar_31;
					  highp float tmpvar_32;
					  tmpvar_32 = clamp (((tmpvar_30 - _Cutoff) / (
					    (_Cutoff + _Fade)
					   - _Cutoff)), 0.0, 1.0);
					  tmpvar_31 = (tmpvar_32 * (tmpvar_32 * (3.0 - 
					    (2.0 * tmpvar_32)
					  )));
					  a_2 = (a_2 * (tmpvar_31 * _Intensity));
					  if ((tmpvar_6 == 1.0)) {
					    tmpvar_1 = sceneColor_4;
					  } else {
					    mediump vec4 tmpvar_33;
					    tmpvar_33.xyz = (sceneColor_4.xyz * (1.0 - a_2));
					    tmpvar_33.w = sceneColor_4.w;
					    tmpvar_1 = tmpvar_33;
					  };
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					int u_xlati0;
					void main()
					{
						ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
						ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
						ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
						ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * vec4(0.100000001, 0.100000001, 0.100000001, 0.100000001) + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    phase0_Output0_1 = in_TEXCOORD0.xyxy;
					    u_xlati0 = int(in_POSITION0.z);
					    vs_TEXCOORD2.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD2.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 _WorldSpaceCameraPos;
					uniform 	vec4 _ZBufferParams;
					uniform 	mediump vec4 unity_ColorSpaceLuminance;
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	vec3 TOD_CloudWind;
					uniform 	float _Cutoff;
					uniform 	float _Fade;
					uniform 	float _Intensity;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _CloudTex;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec2 u_xlat3;
					mediump vec3 u_xlat16_4;
					vec3 u_xlat6;
					lowp vec3 u_xlat10_6;
					mediump float u_xlat16_9;
					float u_xlat11;
					mediump float u_xlat16_14;
					mediump float u_xlat16_17;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat6.xyz = vec3(u_xlat1) * vs_TEXCOORD2.xyz + _WorldSpaceCameraPos.xyz;
					    u_xlat2.xy = u_xlat6.yy * hlslcc_mtx4TOD_World2Sky[1].xz;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[0].xz * u_xlat6.xx + u_xlat2.xy;
					    u_xlat6.xy = hlslcc_mtx4TOD_World2Sky[2].xz * u_xlat6.zz + u_xlat6.xy;
					    u_xlat2.xy = u_xlat6.xy + TOD_CloudWind.xz;
					    u_xlat3.x = dot(vec2(0.98480773, -0.173648179), u_xlat6.xy);
					    u_xlat3.y = dot(vec2(0.173648179, 0.98480773), u_xlat6.xy);
					    u_xlat6.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat2 = texture(_CloudTex, u_xlat2.xy);
					    u_xlat10_6.xyz = texture(_CloudTex, u_xlat6.xy).yzw;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb1 = !!(u_xlat1==1.0);
					#else
					    u_xlatb1 = u_xlat1==1.0;
					#endif
					    if(u_xlatb1){
					        SV_Target0 = u_xlat10_0;
					        return;
					    } else {
					        u_xlat16_4.xyz = vec3(u_xlat10_6.x + u_xlat2.y, u_xlat10_6.y + u_xlat2.z, u_xlat10_6.z + u_xlat2.w);
					        u_xlat16_4.yz = vec2(u_xlat2.z + u_xlat16_4.y, u_xlat2.w + u_xlat16_4.z);
					        u_xlat16_17 = u_xlat10_6.z + u_xlat16_4.z;
					        u_xlat2.yz = u_xlat16_4.xy;
					        u_xlat2.w = u_xlat16_17;
					        u_xlat16_4.x = dot(u_xlat2, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					        u_xlat1 = TOD_CloudSharpness + TOD_CloudCoverage;
					        u_xlat16_9 = u_xlat16_4.x + (-TOD_CloudCoverage);
					        u_xlat16_14 = float(1.0) / TOD_CloudSharpness;
					        u_xlat16_9 = u_xlat16_14 * u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
					#else
					        u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
					#endif
					        u_xlat16_14 = u_xlat16_9 * -2.0 + 3.0;
					        u_xlat16_9 = u_xlat16_9 * u_xlat16_9;
					        u_xlat16_4.x = (-u_xlat1) + u_xlat16_4.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
					#else
					        u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
					#endif
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudDensity;
					        u_xlat16_4.x = u_xlat16_14 * u_xlat16_9 + u_xlat16_4.x;
					        u_xlat16_4.x = u_xlat16_4.x * TOD_CloudAttenuation;
					        u_xlat16_4.x = exp2((-u_xlat16_4.x));
					        u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
					        u_xlat1 = u_xlat16_4.x * TOD_CloudOpacity;
					        u_xlat16_4.x = dot(u_xlat10_0.xyz, unity_ColorSpaceLuminance.xyz);
					        u_xlat6.x = u_xlat16_4.x + (-_Cutoff);
					        u_xlat11 = float(1.0) / _Fade;
					        u_xlat6.x = u_xlat11 * u_xlat6.x;
					#ifdef UNITY_ADRENO_ES3
					        u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					        u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					        u_xlat11 = u_xlat6.x * -2.0 + 3.0;
					        u_xlat6.x = u_xlat6.x * u_xlat6.x;
					        u_xlat6.x = u_xlat6.x * u_xlat11;
					        u_xlat6.x = u_xlat6.x * _Intensity;
					        u_xlat16_4.x = (-u_xlat1) * u_xlat6.x + 1.0;
					        SV_Target0.xyz = u_xlat10_0.xyz * u_xlat16_4.xxx;
					        SV_Target0.w = u_xlat10_0.w;
					        return;
					    //ENDIF
					    }
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
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
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
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
}
 }
}
Fallback Off
}