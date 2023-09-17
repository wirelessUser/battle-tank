Shader "Time of Day/Cloud Billboard Near" {
Properties {
 _MainTex ("Density Map (RGBA)", 2D) = "white" { }
 _BumpMap ("Normal Map", 2D) = "bump" { }
}
SubShader { 
 Tags { "QUEUE"="Geometry+540" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Geometry+540" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 14577
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.z = tmpvar_4.x;
					  density_2.x = clamp (tmpvar_4.x, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.z = tmpvar_4.x;
					  density_2.x = clamp (tmpvar_4.x, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.z = tmpvar_4.x;
					  density_2.x = clamp (tmpvar_4.x, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
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
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_1.w = u_xlat10_0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat16_1.xyz = (-u_xlat10_0.yyy) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
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
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_1.w = u_xlat10_0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat16_1.xyz = (-u_xlat10_0.yyy) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
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
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp vec2 u_xlat10_0;
					mediump vec4 u_xlat16_1;
					void main()
					{
					    u_xlat10_0.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_1.w = u_xlat10_0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat16_1.xyz = (-u_xlat10_0.yyy) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.z = tmpvar_6.x;
					  density_4.x = clamp (tmpvar_6.x, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_9) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_10;
					  tmpvar_10 = clamp (((1.0 - tmpvar_6.x) * tmpvar_9), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_10 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.z = tmpvar_6.x;
					  density_4.x = clamp (tmpvar_6.x, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_9) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_10;
					  tmpvar_10 = clamp (((1.0 - tmpvar_6.x) * tmpvar_9), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_10 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.z = tmpvar_6.x;
					  density_4.x = clamp (tmpvar_6.x, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_7;
					  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_7;
					  highp float tmpvar_8;
					  tmpvar_8 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_9) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_10;
					  tmpvar_10 = clamp (((1.0 - tmpvar_6.x) * tmpvar_9), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_10 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					mediump float u_xlat16_5;
					lowp vec2 u_xlat10_6;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0 = dot(u_xlat10_1.xyz, vs_TEXCOORD3.xyz);
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat0 = u_xlat3.x * u_xlat0;
					    u_xlat10_6.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_2 = (-u_xlat10_6.y) * TOD_CloudAttenuation + 1.0;
					    u_xlat0 = u_xlat0 * 0.25 + u_xlat16_2;
					    u_xlat16_2 = (-u_xlat10_6.x) + 1.0;
					    u_xlat16_5 = u_xlat10_6.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat16_5 * vs_TEXCOORD0.w;
					    u_xlat3.x = u_xlat3.x * u_xlat16_2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = vec3(u_xlat0) * vs_TEXCOORD0.xyz + u_xlat3.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					mediump float u_xlat16_5;
					lowp vec2 u_xlat10_6;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0 = dot(u_xlat10_1.xyz, vs_TEXCOORD3.xyz);
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat0 = u_xlat3.x * u_xlat0;
					    u_xlat10_6.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_2 = (-u_xlat10_6.y) * TOD_CloudAttenuation + 1.0;
					    u_xlat0 = u_xlat0 * 0.25 + u_xlat16_2;
					    u_xlat16_2 = (-u_xlat10_6.x) + 1.0;
					    u_xlat16_5 = u_xlat10_6.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat16_5 * vs_TEXCOORD0.w;
					    u_xlat3.x = u_xlat3.x * u_xlat16_2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = vec3(u_xlat0) * vs_TEXCOORD0.xyz + u_xlat3.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					float u_xlat0;
					lowp vec3 u_xlat10_0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_1;
					mediump float u_xlat16_2;
					vec3 u_xlat3;
					mediump float u_xlat16_5;
					lowp vec2 u_xlat10_6;
					void main()
					{
					    u_xlat10_0.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_1.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat0 = dot(u_xlat10_1.xyz, vs_TEXCOORD3.xyz);
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat0 = u_xlat3.x * u_xlat0;
					    u_xlat10_6.xy = texture(_MainTex, vs_TEXCOORD1.xy).xw;
					    u_xlat16_2 = (-u_xlat10_6.y) * TOD_CloudAttenuation + 1.0;
					    u_xlat0 = u_xlat0 * 0.25 + u_xlat16_2;
					    u_xlat16_2 = (-u_xlat10_6.x) + 1.0;
					    u_xlat16_5 = u_xlat10_6.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat1.w = u_xlat16_5 * vs_TEXCOORD0.w;
					    u_xlat3.x = u_xlat3.x * u_xlat16_2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = vec3(u_xlat0) * vs_TEXCOORD0.xyz + u_xlat3.xyz;
					    SV_Target0 = u_xlat1;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.y = tmpvar_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_6;
					  tmpvar_6 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_2.z = mix (mix (tmpvar_4.x, tmpvar_4.y, tmpvar_5), tmpvar_4.z, tmpvar_6);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.y = tmpvar_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_6;
					  tmpvar_6 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_2.z = mix (mix (tmpvar_4.x, tmpvar_4.y, tmpvar_5), tmpvar_4.z, tmpvar_6);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  density_2.y = tmpvar_4.w;
					  highp float tmpvar_5;
					  tmpvar_5 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_6;
					  tmpvar_6 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_2.z = mix (mix (tmpvar_4.x, tmpvar_4.y, tmpvar_5), tmpvar_4.z, tmpvar_6);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
					  density_2.y = (tmpvar_4.w * TOD_CloudAttenuation);
					  res_1.w = density_2.x;
					  res_1.xyz = vec3((1.0 - density_2.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_1;
					float u_xlat2;
					float u_xlat4;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat2 = u_xlat2 * u_xlat16_4 + u_xlat10_1.x;
					    u_xlat4 = (-u_xlat2) + u_xlat10_1.z;
					    u_xlat16_0.w = u_xlat0.x * u_xlat4 + u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
					#else
					    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
					#endif
					    u_xlat16_0.xyz = (-u_xlat10_1.www) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_0 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_1;
					float u_xlat2;
					float u_xlat4;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat2 = u_xlat2 * u_xlat16_4 + u_xlat10_1.x;
					    u_xlat4 = (-u_xlat2) + u_xlat10_1.z;
					    u_xlat16_0.w = u_xlat0.x * u_xlat4 + u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
					#else
					    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
					#endif
					    u_xlat16_0.xyz = (-u_xlat10_1.www) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_0 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec4 u_xlat16_0;
					lowp vec4 u_xlat10_1;
					float u_xlat2;
					float u_xlat4;
					mediump float u_xlat16_4;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat2 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
					#else
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat2 = u_xlat2 * u_xlat16_4 + u_xlat10_1.x;
					    u_xlat4 = (-u_xlat2) + u_xlat10_1.z;
					    u_xlat16_0.w = u_xlat0.x * u_xlat4 + u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
					#else
					    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
					#endif
					    u_xlat16_0.xyz = (-u_xlat10_1.www) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat0 = u_xlat16_0 * vs_TEXCOORD0;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.y = tmpvar_6.w;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_4.z = mix (mix (tmpvar_6.x, tmpvar_6.y, tmpvar_7), tmpvar_6.z, tmpvar_8);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_9;
					  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_11) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((1.0 - density_4.z) * tmpvar_11), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_12 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.y = tmpvar_6.w;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_4.z = mix (mix (tmpvar_6.x, tmpvar_6.y, tmpvar_7), tmpvar_6.z, tmpvar_8);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_9;
					  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_11) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((1.0 - density_4.z) * tmpvar_11), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_12 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 TOD_World2Sky;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_SunCloudColor;
					uniform highp vec3 TOD_MoonCloudColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp float TOD_CloudOpacity;
					uniform highp float TOD_CloudScattering;
					uniform highp float TOD_CloudBrightness;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					uniform highp vec4 _MainTex_ST;
					uniform highp vec4 _BumpMap_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesNormal;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  tmpvar_3.zw = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize((TOD_World2Sky * (unity_ObjectToWorld * _glesVertex)).xyz);
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_4.xz;
					  highp vec3 sunColor_6;
					  highp vec3 samplePoint_7;
					  highp float scaledLength_8;
					  highp float startOffset_9;
					  dir_5.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_10;
					  tmpvar_10.xz = vec2(0.0, 0.0);
					  highp float tmpvar_11;
					  tmpvar_11 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_10.y = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (1.0 - (dot (dir_5, tmpvar_10) / tmpvar_11));
					  startOffset_9 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_12 * (0.459 + (tmpvar_12 * 
					      (3.83 + (tmpvar_12 * (-6.8 + (tmpvar_12 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_13;
					  tmpvar_13 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_5.y) * dir_5.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_5.y)) / 2.0);
					  scaledLength_8 = (tmpvar_13 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_14;
					  tmpvar_14 = (dir_5 * tmpvar_13);
					  samplePoint_7 = (tmpvar_10 + (tmpvar_14 * 0.5));
					  highp float tmpvar_15;
					  tmpvar_15 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0/(tmpvar_15));
					  highp float tmpvar_17;
					  tmpvar_17 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_15)));
					  highp float tmpvar_18;
					  tmpvar_18 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_16));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_16));
					  highp vec3 tmpvar_20;
					  tmpvar_20 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_6 = (exp((
					    -((startOffset_9 + (tmpvar_17 * (
					      (0.25 * exp((-0.00287 + (tmpvar_18 * 
					        (0.459 + (tmpvar_18 * (3.83 + (tmpvar_18 * 
					          (-6.8 + (tmpvar_18 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_19 * 
					        (0.459 + (tmpvar_19 * (3.83 + (tmpvar_19 * 
					          (-6.8 + (tmpvar_19 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_20)) * (tmpvar_17 * scaledLength_8));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp float tmpvar_21;
					  tmpvar_21 = sqrt(dot (samplePoint_7, samplePoint_7));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0/(tmpvar_21));
					  highp float tmpvar_23;
					  tmpvar_23 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_21)));
					  highp float tmpvar_24;
					  tmpvar_24 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_7) * tmpvar_22));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (dir_5, samplePoint_7) * tmpvar_22));
					  sunColor_6 = (sunColor_6 + (exp(
					    (-((startOffset_9 + (tmpvar_23 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_24 * (0.459 + (tmpvar_24 * (3.83 + 
					          (tmpvar_24 * (-6.8 + (tmpvar_24 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_25 * (0.459 + (tmpvar_25 * (3.83 + 
					          (tmpvar_25 * (-6.8 + (tmpvar_25 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_20)
					  ) * (tmpvar_23 * scaledLength_8)));
					  samplePoint_7 = (samplePoint_7 + tmpvar_14);
					  highp vec3 resultColor_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_26 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_27 * tmpvar_27))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_27))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_6) * TOD_kSun.w));
					  resultColor_26 = (resultColor_26 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_26, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_26 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_4, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = TOD_CloudOpacity;
					  highp vec3 tmpvar_30;
					  tmpvar_30 = normalize(_glesNormal);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = normalize(_glesTANGENT.xyz);
					  highp vec3 tmpvar_32;
					  highp vec3 tmpvar_33;
					  tmpvar_32 = _glesTANGENT.xyz;
					  tmpvar_33 = (((tmpvar_30.yzx * tmpvar_31.zxy) - (tmpvar_30.zxy * tmpvar_31.yzx)) * _glesTANGENT.w);
					  highp mat3 tmpvar_34;
					  tmpvar_34[0].x = tmpvar_32.x;
					  tmpvar_34[0].y = tmpvar_33.x;
					  tmpvar_34[0].z = tmpvar_1.x;
					  tmpvar_34[1].x = tmpvar_32.y;
					  tmpvar_34[1].y = tmpvar_33.y;
					  tmpvar_34[1].z = tmpvar_1.y;
					  tmpvar_34[2].x = tmpvar_32.z;
					  tmpvar_34[2].y = tmpvar_33.z;
					  tmpvar_34[2].z = tmpvar_1.z;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = normalize((tmpvar_34 * tmpvar_4));
					  xlv_TEXCOORD3 = normalize((tmpvar_34 * TOD_LocalSunDirection));
					  xlv_TEXCOORD4 = tmpvar_29.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _BumpMap;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump float NdotS_1;
					  mediump vec3 normal_2;
					  mediump vec4 res_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  density_4.y = tmpvar_6.w;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (xlv_TEXCOORD2.x, 0.0, 1.0);
					  highp float tmpvar_8;
					  tmpvar_8 = clamp (-(xlv_TEXCOORD2.x), 0.0, 1.0);
					  density_4.z = mix (mix (tmpvar_6.x, tmpvar_6.y, tmpvar_7), tmpvar_6.z, tmpvar_8);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  density_4.y = (tmpvar_6.w * TOD_CloudAttenuation);
					  res_3.w = density_4.x;
					  res_3.xyz = vec3((1.0 - density_4.y));
					  lowp vec3 tmpvar_9;
					  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1.zw).xyz * 2.0) - 1.0);
					  normal_2 = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = dot (normal_2, xlv_TEXCOORD3);
					  NdotS_1 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (1.0 - TOD_Fogginess);
					  res_3.xyz = (res_3.xyz + ((0.25 * tmpvar_11) * NdotS_1));
					  res_3 = (res_3 * xlv_TEXCOORD0);
					  highp float tmpvar_12;
					  tmpvar_12 = clamp (((1.0 - density_4.z) * tmpvar_11), 0.0, 1.0);
					  res_3.xyz = (res_3.xyz + (tmpvar_12 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					float u_xlat5;
					vec3 u_xlat6;
					mediump float u_xlat16_7;
					float u_xlat10;
					mediump float u_xlat16_10;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_10 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat5 = u_xlat5 * u_xlat16_10 + u_xlat10_1.x;
					    u_xlat10 = (-u_xlat5) + u_xlat10_1.z;
					    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5;
					    u_xlat16_2 = (-u_xlat10_1.w) * TOD_CloudAttenuation + 1.0;
					    u_xlat16_7 = (-u_xlat0.x) + 1.0;
					    u_xlat16_12 = u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
					#else
					    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
					#endif
					    u_xlat0.w = u_xlat16_12 * vs_TEXCOORD0.w;
					    u_xlat1 = (-TOD_Fogginess) + 1.0;
					    u_xlat6.x = u_xlat1 * u_xlat16_7;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
					    u_xlat10_3.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat3 = dot(u_xlat10_4.xyz, vs_TEXCOORD3.xyz);
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = u_xlat1 * 0.25 + u_xlat16_2;
					    u_xlat0.xyz = vec3(u_xlat1) * vs_TEXCOORD0.xyz + u_xlat6.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					float u_xlat5;
					vec3 u_xlat6;
					mediump float u_xlat16_7;
					float u_xlat10;
					mediump float u_xlat16_10;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_10 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat5 = u_xlat5 * u_xlat16_10 + u_xlat10_1.x;
					    u_xlat10 = (-u_xlat5) + u_xlat10_1.z;
					    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5;
					    u_xlat16_2 = (-u_xlat10_1.w) * TOD_CloudAttenuation + 1.0;
					    u_xlat16_7 = (-u_xlat0.x) + 1.0;
					    u_xlat16_12 = u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
					#else
					    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
					#endif
					    u_xlat0.w = u_xlat16_12 * vs_TEXCOORD0.w;
					    u_xlat1 = (-TOD_Fogginess) + 1.0;
					    u_xlat6.x = u_xlat1 * u_xlat16_7;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
					    u_xlat10_3.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat3 = dot(u_xlat10_4.xyz, vs_TEXCOORD3.xyz);
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = u_xlat1 * 0.25 + u_xlat16_2;
					    u_xlat0.xyz = vec3(u_xlat1) * vs_TEXCOORD0.xyz + u_xlat6.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4unity_ObjectToWorld[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_SunCloudColor;
					uniform 	vec3 TOD_MoonCloudColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	float TOD_CloudOpacity;
					uniform 	float TOD_CloudScattering;
					uniform 	float TOD_CloudBrightness;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					uniform 	vec4 _MainTex_ST;
					uniform 	vec4 _BumpMap_ST;
					in highp vec4 in_POSITION0;
					in highp vec4 in_TANGENT0;
					in highp vec3 in_NORMAL0;
					in highp vec4 in_TEXCOORD0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec2 u_xlat8;
					float u_xlat13;
					float u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4unity_ObjectToWorld[1];
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat1.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.x = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat8.x = u_xlat0.w * u_xlat0.w;
					    u_xlat8.x = u_xlat8.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat8.x = u_xlat8.x + (-TOD_kRadius.y);
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat8.x = (-TOD_kRadius.x) * u_xlat0.w + u_xlat8.x;
					    u_xlat8.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat8.xy = u_xlat8.xy * vec2(0.5, 1.44269502);
					    u_xlat8.y = exp2(u_xlat8.y);
					    u_xlat22 = u_xlat0.w * u_xlat2.y;
					    u_xlat22 = u_xlat22 / u_xlat2.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat23 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat23 = u_xlat22 * u_xlat23 + 3.82999992;
					    u_xlat23 = u_xlat22 * u_xlat23 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat23 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat1.w = exp2(u_xlat22);
					    u_xlat1.xz = u_xlat1.xw * u_xlat8.xy;
					    u_xlat3.xyz = u_xlat0.xwz * u_xlat8.xxx;
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat2.xyz;
					    u_xlat5.x = float(0.0);
					    u_xlat5.y = float(0.0);
					    u_xlat5.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat23 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat23 = sqrt(u_xlat23);
					        u_xlat24 = float(1.0) / u_xlat23;
					        u_xlat23 = (-u_xlat23) + TOD_kRadius.x;
					        u_xlat23 = u_xlat23 * TOD_kScale.z;
					        u_xlat23 = u_xlat23 * 1.44269502;
					        u_xlat23 = exp2(u_xlat23);
					        u_xlat25 = u_xlat1.x * u_xlat23;
					        u_xlat26 = dot(u_xlat0.xwz, u_xlat4.xyz);
					        u_xlat6.x = dot(TOD_LocalSunDirection.xyz, u_xlat4.xyz);
					        u_xlat6.x = (-u_xlat6.x) * u_xlat24 + 1.0;
					        u_xlat13 = u_xlat6.x * 5.25 + -6.80000019;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 3.82999992;
					        u_xlat13 = u_xlat6.x * u_xlat13 + 0.458999991;
					        u_xlat6.x = u_xlat6.x * u_xlat13 + -0.00286999997;
					        u_xlat6.x = u_xlat6.x * 1.44269502;
					        u_xlat6.x = exp2(u_xlat6.x);
					        u_xlat24 = (-u_xlat26) * u_xlat24 + 1.0;
					        u_xlat26 = u_xlat24 * 5.25 + -6.80000019;
					        u_xlat26 = u_xlat24 * u_xlat26 + 3.82999992;
					        u_xlat26 = u_xlat24 * u_xlat26 + 0.458999991;
					        u_xlat24 = u_xlat24 * u_xlat26 + -0.00286999997;
					        u_xlat24 = u_xlat24 * 1.44269502;
					        u_xlat24 = exp2(u_xlat24);
					        u_xlat24 = u_xlat24 * 0.25;
					        u_xlat24 = u_xlat6.x * 0.25 + (-u_xlat24);
					        u_xlat23 = u_xlat23 * u_xlat24;
					        u_xlat23 = u_xlat1.z * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * u_xlat8.xxx + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat21 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat22 = u_xlat21 * u_xlat21 + 1.0;
					    u_xlat22 = u_xlat22 * TOD_kBetaMie.x;
					    u_xlat2.x = TOD_kBetaMie.z * u_xlat21 + TOD_kBetaMie.y;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * 1.5;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat22 = u_xlat22 / u_xlat2.x;
					    u_xlat2.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
					#else
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					#endif
					    u_xlat21 = u_xlat21 * u_xlat1.x;
					    u_xlat1.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * in_NORMAL0.zxy;
					    u_xlat21 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat2.xyz = vec3(u_xlat21) * in_TANGENT0.yzx;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
					    u_xlat2.x = dot(in_TANGENT0.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    vs_TEXCOORD2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat0.x = dot(in_TANGENT0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.y = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    vs_TEXCOORD3.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    vs_TEXCOORD0.w = TOD_CloudOpacity;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _BumpMap;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat1;
					lowp vec4 u_xlat10_1;
					mediump float u_xlat16_2;
					float u_xlat3;
					lowp vec3 u_xlat10_3;
					lowp vec3 u_xlat10_4;
					float u_xlat5;
					vec3 u_xlat6;
					mediump float u_xlat16_7;
					float u_xlat10;
					mediump float u_xlat16_10;
					mediump float u_xlat16_12;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD2.x);
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat5 = vs_TEXCOORD2.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
					#else
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					#endif
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_10 = (-u_xlat10_1.x) + u_xlat10_1.y;
					    u_xlat5 = u_xlat5 * u_xlat16_10 + u_xlat10_1.x;
					    u_xlat10 = (-u_xlat5) + u_xlat10_1.z;
					    u_xlat0.x = u_xlat0.x * u_xlat10 + u_xlat5;
					    u_xlat16_2 = (-u_xlat10_1.w) * TOD_CloudAttenuation + 1.0;
					    u_xlat16_7 = (-u_xlat0.x) + 1.0;
					    u_xlat16_12 = u_xlat0.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_12 = min(max(u_xlat16_12, 0.0), 1.0);
					#else
					    u_xlat16_12 = clamp(u_xlat16_12, 0.0, 1.0);
					#endif
					    u_xlat0.w = u_xlat16_12 * vs_TEXCOORD0.w;
					    u_xlat1 = (-TOD_Fogginess) + 1.0;
					    u_xlat6.x = u_xlat1 * u_xlat16_7;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
					#else
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					#endif
					    u_xlat6.xyz = u_xlat6.xxx * vs_TEXCOORD4.xyz;
					    u_xlat10_3.xyz = texture(_BumpMap, vs_TEXCOORD1.zw).xyz;
					    u_xlat10_4.xyz = u_xlat10_3.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
					    u_xlat3 = dot(u_xlat10_4.xyz, vs_TEXCOORD3.xyz);
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = u_xlat1 * 0.25 + u_xlat16_2;
					    u_xlat0.xyz = vec3(u_xlat1) * vs_TEXCOORD0.xyz + u_xlat6.xyz;
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
}
 }
}
Fallback Off
}