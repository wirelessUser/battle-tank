Shader "Time of Day/Cloud Layer" {
Properties {
 _MainTex ("Density Map (RGBA)", 2D) = "white" { }
 _DitheringTexture ("Dithering Lookup Texture (A)", 2D) = "black" { }
}
SubShader { 
 Tags { "QUEUE"="Geometry+530" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Geometry+530" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  GpuProgramID 23681
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  highp vec2 tmpvar_5;
					  tmpvar_5.x = TOD_CloudAttenuation;
					  tmpvar_5.y = TOD_CloudDensity;
					  density_2.yz = ((tmpvar_4.xx - TOD_CloudCoverage) * tmpvar_5);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  highp vec2 tmpvar_5;
					  tmpvar_5.x = TOD_CloudAttenuation;
					  tmpvar_5.y = TOD_CloudDensity;
					  density_2.yz = ((tmpvar_4.xx - TOD_CloudCoverage) * tmpvar_5);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec3 density_2;
					  density_2.x = 0.0;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_4;
					  tmpvar_4 = tmpvar_3;
					  highp vec2 tmpvar_5;
					  tmpvar_5.x = TOD_CloudAttenuation;
					  tmpvar_5.y = TOD_CloudDensity;
					  density_2.yz = ((tmpvar_4.xx - TOD_CloudCoverage) * tmpvar_5);
					  density_2.x = clamp (density_2.z, 0.0, 1.0);
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					float u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat2 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					float u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat2 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					float u_xlat2;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat2 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat2;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec3 density_5;
					  density_5.x = 0.0;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_10;
					  mediump vec2 tmpvar_11;
					  tmpvar_11 = clamp (((tmpvar_7.xx - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_5.yz = ((tmpvar_11 * (tmpvar_11 * 
					    (3.0 - (2.0 * tmpvar_11))
					  )) + (clamp (
					    (tmpvar_7.xx - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_5.x = clamp (density_5.z, 0.0, 1.0);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = TOD_CloudAttenuation;
					  tmpvar_12.y = TOD_CloudSaturation;
					  density_5.yz = (density_5.yz * tmpvar_12);
					  density_5.yz = (1.0 - exp2(-(density_5.yz)));
					  res_1.w = density_5.x;
					  res_1.xyz = vec3((1.0 - density_5.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((1.0 - density_5.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_13 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec3 density_5;
					  density_5.x = 0.0;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_10;
					  mediump vec2 tmpvar_11;
					  tmpvar_11 = clamp (((tmpvar_7.xx - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_5.yz = ((tmpvar_11 * (tmpvar_11 * 
					    (3.0 - (2.0 * tmpvar_11))
					  )) + (clamp (
					    (tmpvar_7.xx - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_5.x = clamp (density_5.z, 0.0, 1.0);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = TOD_CloudAttenuation;
					  tmpvar_12.y = TOD_CloudSaturation;
					  density_5.yz = (density_5.yz * tmpvar_12);
					  density_5.yz = (1.0 - exp2(-(density_5.yz)));
					  res_1.w = density_5.x;
					  res_1.xyz = vec3((1.0 - density_5.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((1.0 - density_5.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_13 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec3 density_5;
					  density_5.x = 0.0;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_8;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_10;
					  mediump vec2 tmpvar_11;
					  tmpvar_11 = clamp (((tmpvar_7.xx - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_5.yz = ((tmpvar_11 * (tmpvar_11 * 
					    (3.0 - (2.0 * tmpvar_11))
					  )) + (clamp (
					    (tmpvar_7.xx - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_5.x = clamp (density_5.z, 0.0, 1.0);
					  highp vec2 tmpvar_12;
					  tmpvar_12.x = TOD_CloudAttenuation;
					  tmpvar_12.y = TOD_CloudSaturation;
					  density_5.yz = (density_5.yz * tmpvar_12);
					  density_5.yz = (1.0 - exp2(-(density_5.yz)));
					  res_1.w = density_5.x;
					  res_1.xyz = vec3((1.0 - density_5.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_13;
					  tmpvar_13 = clamp (((1.0 - density_5.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_13 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3 = (-TOD_Fogginess) + 1.0;
					    u_xlat3 = u_xlat16_1.y * u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat3) * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3 = (-TOD_Fogginess) + 1.0;
					    u_xlat3 = u_xlat16_1.y * u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat3) * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					float u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3 = (-TOD_Fogginess) + 1.0;
					    u_xlat3 = u_xlat16_1.y * u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
					#else
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = vec3(u_xlat3) * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
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
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepdir_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = xlv_TEXCOORD2.xz;
					  stepdir_2 = tmpvar_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  lowp vec4 tmpvar_7;
					  highp vec2 P_8;
					  P_8 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.1));
					  tmpvar_7 = texture2D (_MainTex, P_8);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_7;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.xy + (stepdir_2 * 0.2));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.3));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  mediump vec4 tmpvar_16;
					  tmpvar_16.x = tmpvar_6.x;
					  tmpvar_16.y = (tmpvar_6.y + tmpvar_9.y);
					  tmpvar_16.z = ((tmpvar_6.z + tmpvar_9.z) + tmpvar_12.z);
					  tmpvar_16.w = ((tmpvar_6.w + tmpvar_9.w) + (tmpvar_12.w + tmpvar_15.w));
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_6.x;
					  tmpvar_17.y = tmpvar_9.y;
					  tmpvar_17.z = tmpvar_12.z;
					  tmpvar_17.w = tmpvar_15.w;
					  density_3.y = dot (tmpvar_16, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_3.z = dot (tmpvar_17, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = TOD_CloudAttenuation;
					  tmpvar_18.y = TOD_CloudDensity;
					  density_3.yz = ((density_3.yz - TOD_CloudCoverage) * tmpvar_18);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_1.w = density_3.x;
					  res_1.xyz = vec3((1.0 - density_3.y));
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepdir_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = xlv_TEXCOORD2.xz;
					  stepdir_2 = tmpvar_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  lowp vec4 tmpvar_7;
					  highp vec2 P_8;
					  P_8 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.1));
					  tmpvar_7 = texture2D (_MainTex, P_8);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_7;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.xy + (stepdir_2 * 0.2));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.3));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  mediump vec4 tmpvar_16;
					  tmpvar_16.x = tmpvar_6.x;
					  tmpvar_16.y = (tmpvar_6.y + tmpvar_9.y);
					  tmpvar_16.z = ((tmpvar_6.z + tmpvar_9.z) + tmpvar_12.z);
					  tmpvar_16.w = ((tmpvar_6.w + tmpvar_9.w) + (tmpvar_12.w + tmpvar_15.w));
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_6.x;
					  tmpvar_17.y = tmpvar_9.y;
					  tmpvar_17.z = tmpvar_12.z;
					  tmpvar_17.w = tmpvar_15.w;
					  density_3.y = dot (tmpvar_16, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_3.z = dot (tmpvar_17, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = TOD_CloudAttenuation;
					  tmpvar_18.y = TOD_CloudDensity;
					  density_3.yz = ((density_3.yz - TOD_CloudCoverage) * tmpvar_18);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_1.w = density_3.x;
					  res_1.xyz = vec3((1.0 - density_3.y));
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepdir_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = xlv_TEXCOORD2.xz;
					  stepdir_2 = tmpvar_4;
					  lowp vec4 tmpvar_5;
					  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_6;
					  tmpvar_6 = tmpvar_5;
					  lowp vec4 tmpvar_7;
					  highp vec2 P_8;
					  P_8 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.1));
					  tmpvar_7 = texture2D (_MainTex, P_8);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_7;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.xy + (stepdir_2 * 0.2));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.zw + (stepdir_2 * 0.3));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  mediump vec4 tmpvar_16;
					  tmpvar_16.x = tmpvar_6.x;
					  tmpvar_16.y = (tmpvar_6.y + tmpvar_9.y);
					  tmpvar_16.z = ((tmpvar_6.z + tmpvar_9.z) + tmpvar_12.z);
					  tmpvar_16.w = ((tmpvar_6.w + tmpvar_9.w) + (tmpvar_12.w + tmpvar_15.w));
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_6.x;
					  tmpvar_17.y = tmpvar_9.y;
					  tmpvar_17.z = tmpvar_12.z;
					  tmpvar_17.w = tmpvar_15.w;
					  density_3.y = dot (tmpvar_16, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_3.z = dot (tmpvar_17, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_18;
					  tmpvar_18.x = TOD_CloudAttenuation;
					  tmpvar_18.y = TOD_CloudDensity;
					  density_3.yz = ((density_3.yz - TOD_CloudCoverage) * tmpvar_18);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_1.w = density_3.x;
					  res_1.xyz = vec3((1.0 - density_3.y));
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
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
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec2 stepdir_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = xlv_TEXCOORD2.xz;
					  stepdir_5 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_8;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.1));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.xy + (stepdir_5 * 0.2));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  lowp vec4 tmpvar_16;
					  highp vec2 P_17;
					  P_17 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.3));
					  tmpvar_16 = texture2D (_MainTex, P_17);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_16;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_9.x;
					  tmpvar_19.y = (tmpvar_9.y + tmpvar_12.y);
					  tmpvar_19.z = ((tmpvar_9.z + tmpvar_12.z) + tmpvar_15.z);
					  tmpvar_19.w = ((tmpvar_9.w + tmpvar_12.w) + (tmpvar_15.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_9.x;
					  tmpvar_20.y = tmpvar_12.y;
					  tmpvar_20.z = tmpvar_15.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_6.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_6.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_21;
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_23;
					  mediump vec2 tmpvar_24;
					  tmpvar_24 = clamp (((density_6.yz - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_24 * (tmpvar_24 * 
					    (3.0 - (2.0 * tmpvar_24))
					  )) + (clamp (
					    (density_6.yz - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = TOD_CloudAttenuation;
					  tmpvar_25.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_25);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_1.w = density_6.x;
					  res_1.xyz = vec3((1.0 - density_6.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_26 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec2 stepdir_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = xlv_TEXCOORD2.xz;
					  stepdir_5 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_8;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.1));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.xy + (stepdir_5 * 0.2));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  lowp vec4 tmpvar_16;
					  highp vec2 P_17;
					  P_17 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.3));
					  tmpvar_16 = texture2D (_MainTex, P_17);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_16;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_9.x;
					  tmpvar_19.y = (tmpvar_9.y + tmpvar_12.y);
					  tmpvar_19.z = ((tmpvar_9.z + tmpvar_12.z) + tmpvar_15.z);
					  tmpvar_19.w = ((tmpvar_9.w + tmpvar_12.w) + (tmpvar_15.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_9.x;
					  tmpvar_20.y = tmpvar_12.y;
					  tmpvar_20.z = tmpvar_15.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_6.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_6.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_21;
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_23;
					  mediump vec2 tmpvar_24;
					  tmpvar_24 = clamp (((density_6.yz - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_24 * (tmpvar_24 * 
					    (3.0 - (2.0 * tmpvar_24))
					  )) + (clamp (
					    (density_6.yz - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = TOD_CloudAttenuation;
					  tmpvar_25.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_25);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_1.w = density_6.x;
					  res_1.xyz = vec3((1.0 - density_6.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_26 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_4;
					  highp vec3 tmpvar_5;
					  tmpvar_5.y = 1.0;
					  tmpvar_5.xz = (tmpvar_3.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_3.y)))));
					  tmpvar_4 = (tmpvar_5 / TOD_CloudSize);
					  tmpvar_2.xy = ((tmpvar_4.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_6;
					  tmpvar_6[0].x = 0.9848077;
					  tmpvar_6[0].y = 0.1736482;
					  tmpvar_6[1].x = -0.1736482;
					  tmpvar_6[1].y = 0.9848077;
					  tmpvar_2.zw = (((tmpvar_6 * tmpvar_4.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = normalize(tmpvar_4);
					  highp vec3 dir_8;
					  dir_8.xz = tmpvar_3.xz;
					  highp vec3 sunColor_9;
					  highp vec3 samplePoint_10;
					  highp float scaledLength_11;
					  highp float startOffset_12;
					  dir_8.y = max (0.0, tmpvar_3.y);
					  highp vec3 tmpvar_13;
					  tmpvar_13.xz = vec2(0.0, 0.0);
					  highp float tmpvar_14;
					  tmpvar_14 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_13.y = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (dir_8, tmpvar_13) / tmpvar_14));
					  startOffset_12 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_15 * (0.459 + (tmpvar_15 * 
					      (3.83 + (tmpvar_15 * (-6.8 + (tmpvar_15 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_16;
					  tmpvar_16 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_8.y) * dir_8.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_8.y)) / 2.0);
					  scaledLength_11 = (tmpvar_16 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (dir_8 * tmpvar_16);
					  samplePoint_10 = (tmpvar_13 + (tmpvar_17 * 0.5));
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_19));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_9 = (exp((
					    -((startOffset_12 + (tmpvar_20 * (
					      (0.25 * exp((-0.00287 + (tmpvar_21 * 
					        (0.459 + (tmpvar_21 * (3.83 + (tmpvar_21 * 
					          (-6.8 + (tmpvar_21 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_22 * 
					        (0.459 + (tmpvar_22 * (3.83 + (tmpvar_22 * 
					          (-6.8 + (tmpvar_22 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_23)) * (tmpvar_20 * scaledLength_11));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_10, samplePoint_10));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_10) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_8, samplePoint_10) * tmpvar_25));
					  sunColor_9 = (sunColor_9 + (exp(
					    (-((startOffset_12 + (tmpvar_26 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_27 * (0.459 + (tmpvar_27 * (3.83 + 
					          (tmpvar_27 * (-6.8 + (tmpvar_27 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
					          (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_23)
					  ) * (tmpvar_26 * scaledLength_11)));
					  samplePoint_10 = (samplePoint_10 + tmpvar_17);
					  highp vec3 resultColor_29;
					  highp float tmpvar_30;
					  tmpvar_30 = dot (TOD_LocalSunDirection, tmpvar_3);
					  resultColor_29 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_30 * tmpvar_30))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_30))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_9) * TOD_kSun.w));
					  resultColor_29 = (resultColor_29 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_3, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_31;
					  tmpvar_31 = mix (resultColor_29, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_29 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32.w = 1.0;
					  tmpvar_32.xyz = pow ((tmpvar_31 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_1.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_7, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_1.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_3.y)
					   * tmpvar_3.y), 0.0, 1.0));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD0 = tmpvar_1;
					  xlv_TEXCOORD1 = tmpvar_2;
					  xlv_TEXCOORD2 = tmpvar_7;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_32.xyz;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 res_1;
					  mediump vec2 stepC_2;
					  mediump vec2 stepB_3;
					  mediump vec2 stepA_4;
					  mediump vec2 stepdir_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  highp vec2 tmpvar_7;
					  tmpvar_7 = xlv_TEXCOORD2.xz;
					  stepdir_5 = tmpvar_7;
					  lowp vec4 tmpvar_8;
					  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_9;
					  tmpvar_9 = tmpvar_8;
					  lowp vec4 tmpvar_10;
					  highp vec2 P_11;
					  P_11 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.1));
					  tmpvar_10 = texture2D (_MainTex, P_11);
					  mediump vec4 tmpvar_12;
					  tmpvar_12 = tmpvar_10;
					  lowp vec4 tmpvar_13;
					  highp vec2 P_14;
					  P_14 = (xlv_TEXCOORD1.xy + (stepdir_5 * 0.2));
					  tmpvar_13 = texture2D (_MainTex, P_14);
					  mediump vec4 tmpvar_15;
					  tmpvar_15 = tmpvar_13;
					  lowp vec4 tmpvar_16;
					  highp vec2 P_17;
					  P_17 = (xlv_TEXCOORD1.zw + (stepdir_5 * 0.3));
					  tmpvar_16 = texture2D (_MainTex, P_17);
					  mediump vec4 tmpvar_18;
					  tmpvar_18 = tmpvar_16;
					  mediump vec4 tmpvar_19;
					  tmpvar_19.x = tmpvar_9.x;
					  tmpvar_19.y = (tmpvar_9.y + tmpvar_12.y);
					  tmpvar_19.z = ((tmpvar_9.z + tmpvar_12.z) + tmpvar_15.z);
					  tmpvar_19.w = ((tmpvar_9.w + tmpvar_12.w) + (tmpvar_15.w + tmpvar_18.w));
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_9.x;
					  tmpvar_20.y = tmpvar_12.y;
					  tmpvar_20.z = tmpvar_15.z;
					  tmpvar_20.w = tmpvar_18.w;
					  density_6.y = dot (tmpvar_19, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_6.z = dot (tmpvar_20, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_21;
					  tmpvar_21 = vec2(TOD_CloudCoverage);
					  stepA_4 = tmpvar_21;
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_3 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2(TOD_CloudDensity);
					  stepC_2 = tmpvar_23;
					  mediump vec2 tmpvar_24;
					  tmpvar_24 = clamp (((density_6.yz - stepA_4) / (stepB_3 - stepA_4)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_24 * (tmpvar_24 * 
					    (3.0 - (2.0 * tmpvar_24))
					  )) + (clamp (
					    (density_6.yz - stepB_3)
					  , 0.0, 1.0) * stepC_2));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = TOD_CloudAttenuation;
					  tmpvar_25.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_25);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_1.w = density_6.x;
					  res_1.xyz = vec3((1.0 - density_6.y));
					  res_1 = (res_1 * xlv_TEXCOORD0);
					  highp float tmpvar_26;
					  tmpvar_26 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_1.xyz = (res_1.xyz + (tmpvar_26 * xlv_TEXCOORD4));
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					vec2 u_xlat18;
					float u_xlat19;
					int u_xlati19;
					float u_xlat24;
					float u_xlat25;
					float u_xlat26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat1.x = u_xlat0.y * 0.850000024 + 0.150000006;
					    u_xlat1.x = float(1.0) / u_xlat1.x;
					    u_xlat1.xz = u_xlat0.xz * u_xlat1.xx;
					    u_xlat1.y = 1.0;
					    u_xlat1.xyz = u_xlat1.xyz / TOD_CloudSize.xyz;
					    u_xlat2.xy = u_xlat1.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat18.x = dot(vec2(0.98480773, -0.173648179), u_xlat1.xz);
					    u_xlat18.y = dot(vec2(0.173648179, 0.98480773), u_xlat1.xz);
					    u_xlat2.xy = u_xlat18.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat2.xy + TOD_CloudWind.xz;
					    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat25 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat3.xy = vec2(u_xlat0.w * u_xlat0.w, u_xlat0.y * u_xlat0.y);
					    u_xlat26 = u_xlat3.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat19 = u_xlat0.w * u_xlat2.y;
					    u_xlat19 = u_xlat19 / u_xlat2.y;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat27 = u_xlat19 * 5.25 + -6.80000019;
					    u_xlat27 = u_xlat19 * u_xlat27 + 3.82999992;
					    u_xlat27 = u_xlat19 * u_xlat27 + 0.458999991;
					    u_xlat19 = u_xlat19 * u_xlat27 + -0.00286999997;
					    u_xlat19 = u_xlat19 * 1.44269502;
					    u_xlat19 = exp2(u_xlat19);
					    u_xlat3.x = u_xlat19 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat25 = u_xlat25 * u_xlat26;
					    u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat26);
					    u_xlat2.x = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat2.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat2.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat2.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat27 = sqrt(u_xlat27);
					        u_xlat28 = float(1.0) / u_xlat27;
					        u_xlat27 = (-u_xlat27) + TOD_kRadius.x;
					        u_xlat27 = u_xlat27 * TOD_kScale.z;
					        u_xlat27 = u_xlat27 * 1.44269502;
					        u_xlat27 = exp2(u_xlat27);
					        u_xlat29 = u_xlat25 * u_xlat27;
					        u_xlat30 = dot(u_xlat0.xwz, u_xlat5.xyz);
					        u_xlat7.x = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat7.x = (-u_xlat7.x) * u_xlat28 + 1.0;
					        u_xlat15 = u_xlat7.x * 5.25 + -6.80000019;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 3.82999992;
					        u_xlat15 = u_xlat7.x * u_xlat15 + 0.458999991;
					        u_xlat7.x = u_xlat7.x * u_xlat15 + -0.00286999997;
					        u_xlat7.x = u_xlat7.x * 1.44269502;
					        u_xlat7.x = exp2(u_xlat7.x);
					        u_xlat28 = (-u_xlat30) * u_xlat28 + 1.0;
					        u_xlat30 = u_xlat28 * 5.25 + -6.80000019;
					        u_xlat30 = u_xlat28 * u_xlat30 + 3.82999992;
					        u_xlat30 = u_xlat28 * u_xlat30 + 0.458999991;
					        u_xlat28 = u_xlat28 * u_xlat30 + -0.00286999997;
					        u_xlat28 = u_xlat28 * 1.44269502;
					        u_xlat28 = exp2(u_xlat28);
					        u_xlat28 = u_xlat28 * 0.25;
					        u_xlat28 = u_xlat7.x * 0.25 + (-u_xlat28);
					        u_xlat27 = u_xlat27 * u_xlat28;
					        u_xlat27 = u_xlat3.x * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat0.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat24 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat25 = u_xlat24 * u_xlat24 + 1.0;
					    u_xlat25 = u_xlat25 * TOD_kBetaMie.x;
					    u_xlat24 = TOD_kBetaMie.z * u_xlat24 + TOD_kBetaMie.y;
					    u_xlat24 = log2(u_xlat24);
					    u_xlat24 = u_xlat24 * 1.5;
					    u_xlat24 = exp2(u_xlat24);
					    u_xlat24 = u_xlat25 / u_xlat24;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat2.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD4.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.x = TOD_LocalSunDirection.y * 4.0 + 1.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    u_xlat8.x = dot(u_xlat1.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat8.x = u_xlat8.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
					#else
					    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
					#endif
					    u_xlat0.x = u_xlat8.x * u_xlat0.x;
					    u_xlat8.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat2.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat0.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat3.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
					#else
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat0.x * TOD_CloudOpacity;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat0.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = tmpvar_4;
					  highp vec2 tmpvar_6;
					  tmpvar_6.x = TOD_CloudAttenuation;
					  tmpvar_6.y = TOD_CloudDensity;
					  density_3.yz = ((tmpvar_5.xx - TOD_CloudCoverage) * tmpvar_6);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_2.w = density_3.x;
					  res_2.xyz = vec3((1.0 - density_3.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_7.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = tmpvar_4;
					  highp vec2 tmpvar_6;
					  tmpvar_6.x = TOD_CloudAttenuation;
					  tmpvar_6.y = TOD_CloudDensity;
					  density_3.yz = ((tmpvar_5.xx - TOD_CloudCoverage) * tmpvar_6);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_2.w = density_3.x;
					  res_2.xyz = vec3((1.0 - density_3.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_7.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec3 density_3;
					  density_3.x = 0.0;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = tmpvar_4;
					  highp vec2 tmpvar_6;
					  tmpvar_6.x = TOD_CloudAttenuation;
					  tmpvar_6.y = TOD_CloudDensity;
					  density_3.yz = ((tmpvar_5.xx - TOD_CloudCoverage) * tmpvar_6);
					  density_3.x = clamp (density_3.z, 0.0, 1.0);
					  res_2.w = density_3.x;
					  res_2.xyz = vec3((1.0 - density_3.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_7.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp float u_xlat10_2;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat3 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp float u_xlat10_2;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat3 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					lowp float u_xlat10_0;
					mediump vec4 u_xlat16_1;
					lowp float u_xlat10_2;
					float u_xlat3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat0.x = u_xlat10_0 + (-TOD_CloudCoverage);
					    u_xlat3 = u_xlat0.x * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat3;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_8;
					  tmpvar_8 = tmpvar_7;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_10;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_11;
					  mediump vec2 tmpvar_12;
					  tmpvar_12 = clamp (((tmpvar_8.xx - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_12 * (tmpvar_12 * 
					    (3.0 - (2.0 * tmpvar_12))
					  )) + (clamp (
					    (tmpvar_8.xx - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_13);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_2.w = density_6.x;
					  res_2.xyz = vec3((1.0 - density_6.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_14 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_15.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_8;
					  tmpvar_8 = tmpvar_7;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_10;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_11;
					  mediump vec2 tmpvar_12;
					  tmpvar_12 = clamp (((tmpvar_8.xx - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_12 * (tmpvar_12 * 
					    (3.0 - (2.0 * tmpvar_12))
					  )) + (clamp (
					    (tmpvar_8.xx - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_13);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_2.w = density_6.x;
					  res_2.xyz = vec3((1.0 - density_6.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_14 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_15.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec3 density_6;
					  density_6.x = 0.0;
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_8;
					  tmpvar_8 = tmpvar_7;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_9;
					  highp vec2 tmpvar_10;
					  tmpvar_10 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_10;
					  highp vec2 tmpvar_11;
					  tmpvar_11 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_11;
					  mediump vec2 tmpvar_12;
					  tmpvar_12 = clamp (((tmpvar_8.xx - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_6.yz = ((tmpvar_12 * (tmpvar_12 * 
					    (3.0 - (2.0 * tmpvar_12))
					  )) + (clamp (
					    (tmpvar_8.xx - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_6.x = clamp (density_6.z, 0.0, 1.0);
					  highp vec2 tmpvar_13;
					  tmpvar_13.x = TOD_CloudAttenuation;
					  tmpvar_13.y = TOD_CloudSaturation;
					  density_6.yz = (density_6.yz * tmpvar_13);
					  density_6.yz = (1.0 - exp2(-(density_6.yz)));
					  res_2.w = density_6.x;
					  res_2.xyz = vec3((1.0 - density_6.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_14;
					  tmpvar_14 = clamp (((1.0 - density_6.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_14 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_15;
					  tmpvar_15 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_15.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					lowp float u_xlat10_15;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat3.x = u_xlat16_1.y * u_xlat3.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_15 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_15) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat3.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					lowp float u_xlat10_15;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat3.x = u_xlat16_1.y * u_xlat3.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_15 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_15) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat3.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					mediump vec3 u_xlat16_1;
					mediump vec2 u_xlat16_2;
					vec3 u_xlat3;
					lowp float u_xlat10_4;
					mediump float u_xlat16_5;
					mediump float u_xlat16_9;
					lowp float u_xlat10_15;
					void main()
					{
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD1.xy).x;
					    u_xlat16_1.x = (-u_xlat0.x) + u_xlat10_4;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
					#else
					    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
					#endif
					    u_xlat16_5 = u_xlat10_4 + (-TOD_CloudCoverage);
					    u_xlat16_1.x = u_xlat16_1.x * TOD_CloudDensity;
					    u_xlat16_9 = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_5 = u_xlat16_9 * u_xlat16_5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
					#else
					    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
					#endif
					    u_xlat16_9 = u_xlat16_5 * -2.0 + 3.0;
					    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
					    u_xlat16_9 = u_xlat16_9 * u_xlat16_5 + u_xlat16_1.x;
					    u_xlat16_2.x = u_xlat16_9 * TOD_CloudAttenuation;
					    u_xlat16_2.y = u_xlat16_9 * TOD_CloudSaturation;
					    u_xlat16_1.z = u_xlat16_9;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.z = min(max(u_xlat16_1.z, 0.0), 1.0);
					#else
					    u_xlat16_1.z = clamp(u_xlat16_1.z, 0.0, 1.0);
					#endif
					    u_xlat16_2.xy = exp2((-u_xlat16_2.xy));
					    u_xlat16_2.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat16_1.xy = (-u_xlat16_2.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_1.xxxz * vs_TEXCOORD0;
					    u_xlat3.x = (-TOD_Fogginess) + 1.0;
					    u_xlat3.x = u_xlat16_1.y * u_xlat3.x;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
					#else
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					#endif
					    u_xlat3.xyz = u_xlat3.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_15 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_15) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat3.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepdir_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  highp vec2 tmpvar_5;
					  tmpvar_5 = xlv_TEXCOORD2.xz;
					  stepdir_3 = tmpvar_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  lowp vec4 tmpvar_8;
					  highp vec2 P_9;
					  P_9 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.1));
					  tmpvar_8 = texture2D (_MainTex, P_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_8;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.xy + (stepdir_3 * 0.2));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.3));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_7.x;
					  tmpvar_17.y = (tmpvar_7.y + tmpvar_10.y);
					  tmpvar_17.z = ((tmpvar_7.z + tmpvar_10.z) + tmpvar_13.z);
					  tmpvar_17.w = ((tmpvar_7.w + tmpvar_10.w) + (tmpvar_13.w + tmpvar_16.w));
					  mediump vec4 tmpvar_18;
					  tmpvar_18.x = tmpvar_7.x;
					  tmpvar_18.y = tmpvar_10.y;
					  tmpvar_18.z = tmpvar_13.z;
					  tmpvar_18.w = tmpvar_16.w;
					  density_4.y = dot (tmpvar_17, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_4.z = dot (tmpvar_18, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_19;
					  tmpvar_19.x = TOD_CloudAttenuation;
					  tmpvar_19.y = TOD_CloudDensity;
					  density_4.yz = ((density_4.yz - TOD_CloudCoverage) * tmpvar_19);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  res_2.w = density_4.x;
					  res_2.xyz = vec3((1.0 - density_4.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_20.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepdir_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  highp vec2 tmpvar_5;
					  tmpvar_5 = xlv_TEXCOORD2.xz;
					  stepdir_3 = tmpvar_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  lowp vec4 tmpvar_8;
					  highp vec2 P_9;
					  P_9 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.1));
					  tmpvar_8 = texture2D (_MainTex, P_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_8;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.xy + (stepdir_3 * 0.2));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.3));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_7.x;
					  tmpvar_17.y = (tmpvar_7.y + tmpvar_10.y);
					  tmpvar_17.z = ((tmpvar_7.z + tmpvar_10.z) + tmpvar_13.z);
					  tmpvar_17.w = ((tmpvar_7.w + tmpvar_10.w) + (tmpvar_13.w + tmpvar_16.w));
					  mediump vec4 tmpvar_18;
					  tmpvar_18.x = tmpvar_7.x;
					  tmpvar_18.y = tmpvar_10.y;
					  tmpvar_18.z = tmpvar_13.z;
					  tmpvar_18.w = tmpvar_16.w;
					  density_4.y = dot (tmpvar_17, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_4.z = dot (tmpvar_18, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_19;
					  tmpvar_19.x = TOD_CloudAttenuation;
					  tmpvar_19.y = TOD_CloudDensity;
					  density_4.yz = ((density_4.yz - TOD_CloudCoverage) * tmpvar_19);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  res_2.w = density_4.x;
					  res_2.xyz = vec3((1.0 - density_4.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_20.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepdir_3;
					  mediump vec3 density_4;
					  density_4.x = 0.0;
					  highp vec2 tmpvar_5;
					  tmpvar_5 = xlv_TEXCOORD2.xz;
					  stepdir_3 = tmpvar_5;
					  lowp vec4 tmpvar_6;
					  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_7;
					  tmpvar_7 = tmpvar_6;
					  lowp vec4 tmpvar_8;
					  highp vec2 P_9;
					  P_9 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.1));
					  tmpvar_8 = texture2D (_MainTex, P_9);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_8;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.xy + (stepdir_3 * 0.2));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.zw + (stepdir_3 * 0.3));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  mediump vec4 tmpvar_17;
					  tmpvar_17.x = tmpvar_7.x;
					  tmpvar_17.y = (tmpvar_7.y + tmpvar_10.y);
					  tmpvar_17.z = ((tmpvar_7.z + tmpvar_10.z) + tmpvar_13.z);
					  tmpvar_17.w = ((tmpvar_7.w + tmpvar_10.w) + (tmpvar_13.w + tmpvar_16.w));
					  mediump vec4 tmpvar_18;
					  tmpvar_18.x = tmpvar_7.x;
					  tmpvar_18.y = tmpvar_10.y;
					  tmpvar_18.z = tmpvar_13.z;
					  tmpvar_18.w = tmpvar_16.w;
					  density_4.y = dot (tmpvar_17, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_4.z = dot (tmpvar_18, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_19;
					  tmpvar_19.x = TOD_CloudAttenuation;
					  tmpvar_19.y = TOD_CloudDensity;
					  density_4.yz = ((density_4.yz - TOD_CloudCoverage) * tmpvar_19);
					  density_4.x = clamp (density_4.z, 0.0, 1.0);
					  res_2.w = density_4.x;
					  res_2.xyz = vec3((1.0 - density_4.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_20;
					  tmpvar_20 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_20.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2.x = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = u_xlat10_2.xxx * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2.x = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = u_xlat10_2.xxx * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					mediump vec4 u_xlat16_1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					float u_xlat5;
					lowp vec2 u_xlat10_11;
					mediump float u_xlat16_18;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_11.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_11.x + u_xlat16_4.y, u_xlat10_11.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_11.x;
					    u_xlat16_18 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_18;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat5 = u_xlat0.y * TOD_CloudDensity;
					    u_xlat16_1.xyz = (-u_xlat0.xxx) * vec3(vec3(TOD_CloudAttenuation, TOD_CloudAttenuation, TOD_CloudAttenuation)) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_1.w = u_xlat5;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
					#else
					    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
					#endif
					    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0;
					    u_xlat10_2.x = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = u_xlat10_2.xxx * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec2 stepdir_6;
					  mediump vec3 density_7;
					  density_7.x = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = xlv_TEXCOORD2.xz;
					  stepdir_6 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_9;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.1));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.xy + (stepdir_6 * 0.2));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.3));
					  tmpvar_17 = texture2D (_MainTex, P_18);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_17;
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_10.x;
					  tmpvar_20.y = (tmpvar_10.y + tmpvar_13.y);
					  tmpvar_20.z = ((tmpvar_10.z + tmpvar_13.z) + tmpvar_16.z);
					  tmpvar_20.w = ((tmpvar_10.w + tmpvar_13.w) + (tmpvar_16.w + tmpvar_19.w));
					  mediump vec4 tmpvar_21;
					  tmpvar_21.x = tmpvar_10.x;
					  tmpvar_21.y = tmpvar_13.y;
					  tmpvar_21.z = tmpvar_16.z;
					  tmpvar_21.w = tmpvar_19.w;
					  density_7.y = dot (tmpvar_20, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_7.z = dot (tmpvar_21, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_23;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_24;
					  mediump vec2 tmpvar_25;
					  tmpvar_25 = clamp (((density_7.yz - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_7.yz = ((tmpvar_25 * (tmpvar_25 * 
					    (3.0 - (2.0 * tmpvar_25))
					  )) + (clamp (
					    (density_7.yz - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_7.x = clamp (density_7.z, 0.0, 1.0);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = TOD_CloudAttenuation;
					  tmpvar_26.y = TOD_CloudSaturation;
					  density_7.yz = (density_7.yz * tmpvar_26);
					  density_7.yz = (1.0 - exp2(-(density_7.yz)));
					  res_2.w = density_7.x;
					  res_2.xyz = vec3((1.0 - density_7.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_27;
					  tmpvar_27 = clamp (((1.0 - density_7.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_27 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_28.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec2 stepdir_6;
					  mediump vec3 density_7;
					  density_7.x = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = xlv_TEXCOORD2.xz;
					  stepdir_6 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_9;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.1));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.xy + (stepdir_6 * 0.2));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.3));
					  tmpvar_17 = texture2D (_MainTex, P_18);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_17;
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_10.x;
					  tmpvar_20.y = (tmpvar_10.y + tmpvar_13.y);
					  tmpvar_20.z = ((tmpvar_10.z + tmpvar_13.z) + tmpvar_16.z);
					  tmpvar_20.w = ((tmpvar_10.w + tmpvar_13.w) + (tmpvar_16.w + tmpvar_19.w));
					  mediump vec4 tmpvar_21;
					  tmpvar_21.x = tmpvar_10.x;
					  tmpvar_21.y = tmpvar_13.y;
					  tmpvar_21.z = tmpvar_16.z;
					  tmpvar_21.w = tmpvar_19.w;
					  density_7.y = dot (tmpvar_20, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_7.z = dot (tmpvar_21, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_23;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_24;
					  mediump vec2 tmpvar_25;
					  tmpvar_25 = clamp (((density_7.yz - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_7.yz = ((tmpvar_25 * (tmpvar_25 * 
					    (3.0 - (2.0 * tmpvar_25))
					  )) + (clamp (
					    (density_7.yz - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_7.x = clamp (density_7.z, 0.0, 1.0);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = TOD_CloudAttenuation;
					  tmpvar_26.y = TOD_CloudSaturation;
					  density_7.yz = (density_7.yz * tmpvar_26);
					  density_7.yz = (1.0 - exp2(-(density_7.yz)));
					  res_2.w = density_7.x;
					  res_2.xyz = vec3((1.0 - density_7.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_27;
					  tmpvar_27 = clamp (((1.0 - density_7.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_27 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_28.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
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
					uniform highp vec3 TOD_CloudOffset;
					uniform highp vec3 TOD_CloudWind;
					uniform highp vec3 TOD_CloudSize;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_4;
					  tmpvar_4 = normalize(_glesVertex.xyz);
					  highp vec3 tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6.y = 1.0;
					  tmpvar_6.xz = (tmpvar_4.xz * vec2((1.0/(mix (0.15, 1.0, tmpvar_4.y)))));
					  tmpvar_5 = (tmpvar_6 / TOD_CloudSize);
					  tmpvar_3.xy = ((tmpvar_5.xz + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  mat2 tmpvar_7;
					  tmpvar_7[0].x = 0.9848077;
					  tmpvar_7[0].y = 0.1736482;
					  tmpvar_7[1].x = -0.1736482;
					  tmpvar_7[1].y = 0.9848077;
					  tmpvar_3.zw = (((tmpvar_7 * tmpvar_5.xz) + TOD_CloudOffset.xz) + TOD_CloudWind.xz);
					  highp vec4 o_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_10;
					  tmpvar_10.x = tmpvar_9.x;
					  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
					  o_8.xy = (tmpvar_10 + tmpvar_9.w);
					  o_8.zw = tmpvar_1.zw;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize(tmpvar_5);
					  highp vec3 dir_12;
					  dir_12.xz = tmpvar_4.xz;
					  highp vec3 sunColor_13;
					  highp vec3 samplePoint_14;
					  highp float scaledLength_15;
					  highp float startOffset_16;
					  dir_12.y = max (0.0, tmpvar_4.y);
					  highp vec3 tmpvar_17;
					  tmpvar_17.xz = vec2(0.0, 0.0);
					  highp float tmpvar_18;
					  tmpvar_18 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_17.y = tmpvar_18;
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0 - (dot (dir_12, tmpvar_17) / tmpvar_18));
					  startOffset_16 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_19 * (0.459 + (tmpvar_19 * 
					      (3.83 + (tmpvar_19 * (-6.8 + (tmpvar_19 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_20;
					  tmpvar_20 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_12.y) * dir_12.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_12.y)) / 2.0);
					  scaledLength_15 = (tmpvar_20 * (TOD_kScale.x * TOD_CloudScattering));
					  highp vec3 tmpvar_21;
					  tmpvar_21 = (dir_12 * tmpvar_20);
					  samplePoint_14 = (tmpvar_17 + (tmpvar_21 * 0.5));
					  highp float tmpvar_22;
					  tmpvar_22 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0/(tmpvar_22));
					  highp float tmpvar_24;
					  tmpvar_24 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_22)));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_23));
					  highp float tmpvar_26;
					  tmpvar_26 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_23));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_13 = (exp((
					    -((startOffset_16 + (tmpvar_24 * (
					      (0.25 * exp((-0.00287 + (tmpvar_25 * 
					        (0.459 + (tmpvar_25 * (3.83 + (tmpvar_25 * 
					          (-6.8 + (tmpvar_25 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_26 * 
					        (0.459 + (tmpvar_26 * (3.83 + (tmpvar_26 * 
					          (-6.8 + (tmpvar_26 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_27)) * (tmpvar_24 * scaledLength_15));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp float tmpvar_28;
					  tmpvar_28 = sqrt(dot (samplePoint_14, samplePoint_14));
					  highp float tmpvar_29;
					  tmpvar_29 = (1.0/(tmpvar_28));
					  highp float tmpvar_30;
					  tmpvar_30 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_28)));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_14) * tmpvar_29));
					  highp float tmpvar_32;
					  tmpvar_32 = (1.0 - (dot (dir_12, samplePoint_14) * tmpvar_29));
					  sunColor_13 = (sunColor_13 + (exp(
					    (-((startOffset_16 + (tmpvar_30 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
					          (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_32 * (0.459 + (tmpvar_32 * (3.83 + 
					          (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_27)
					  ) * (tmpvar_30 * scaledLength_15)));
					  samplePoint_14 = (samplePoint_14 + tmpvar_21);
					  highp vec3 resultColor_33;
					  highp float tmpvar_34;
					  tmpvar_34 = dot (TOD_LocalSunDirection, tmpvar_4);
					  resultColor_33 = (((TOD_kBetaMie.x * 
					    (1.0 + (tmpvar_34 * tmpvar_34))
					  ) / pow (
					    (TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_34))
					  , 1.5)) * ((TOD_SunSkyColor * sunColor_13) * TOD_kSun.w));
					  resultColor_33 = (resultColor_33 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_4, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_35;
					  tmpvar_35 = mix (resultColor_33, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_33 = tmpvar_35;
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = pow ((tmpvar_35 * TOD_Brightness), vec3(TOD_Contrast));
					  tmpvar_2.xyz = mix (mix (TOD_MoonCloudColor, (TOD_CloudBrightness * TOD_SunCloudColor), vec3((
					    clamp ((1.0 + (4.0 * TOD_LocalSunDirection.y)), 0.0, 1.0)
					   * 
					    clamp ((dot (tmpvar_11, TOD_LocalSunDirection) + 1.25), 0.0, 1.0)
					  ))), (TOD_CloudBrightness * TOD_FogColor), vec3(TOD_Fogginess));
					  tmpvar_2.w = (TOD_CloudOpacity * clamp ((
					    (500.0 * tmpvar_4.y)
					   * tmpvar_4.y), 0.0, 1.0));
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = tmpvar_2;
					  xlv_TEXCOORD1 = tmpvar_3;
					  xlv_TEXCOORD2 = tmpvar_11;
					  xlv_TEXCOORD3 = TOD_LocalSunDirection;
					  xlv_TEXCOORD4 = tmpvar_36.xyz;
					  xlv_TEXCOORD5 = (((o_8.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_CloudCoverage;
					uniform highp float TOD_CloudSharpness;
					uniform highp float TOD_CloudDensity;
					uniform highp float TOD_CloudAttenuation;
					uniform highp float TOD_CloudSaturation;
					uniform sampler2D _MainTex;
					uniform sampler2D _DitheringTexture;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD4;
					varying highp vec2 xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec4 color_1;
					  mediump vec4 res_2;
					  mediump vec2 stepC_3;
					  mediump vec2 stepB_4;
					  mediump vec2 stepA_5;
					  mediump vec2 stepdir_6;
					  mediump vec3 density_7;
					  density_7.x = 0.0;
					  highp vec2 tmpvar_8;
					  tmpvar_8 = xlv_TEXCOORD2.xz;
					  stepdir_6 = tmpvar_8;
					  lowp vec4 tmpvar_9;
					  tmpvar_9 = texture2D (_MainTex, xlv_TEXCOORD1.xy);
					  mediump vec4 tmpvar_10;
					  tmpvar_10 = tmpvar_9;
					  lowp vec4 tmpvar_11;
					  highp vec2 P_12;
					  P_12 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.1));
					  tmpvar_11 = texture2D (_MainTex, P_12);
					  mediump vec4 tmpvar_13;
					  tmpvar_13 = tmpvar_11;
					  lowp vec4 tmpvar_14;
					  highp vec2 P_15;
					  P_15 = (xlv_TEXCOORD1.xy + (stepdir_6 * 0.2));
					  tmpvar_14 = texture2D (_MainTex, P_15);
					  mediump vec4 tmpvar_16;
					  tmpvar_16 = tmpvar_14;
					  lowp vec4 tmpvar_17;
					  highp vec2 P_18;
					  P_18 = (xlv_TEXCOORD1.zw + (stepdir_6 * 0.3));
					  tmpvar_17 = texture2D (_MainTex, P_18);
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = tmpvar_17;
					  mediump vec4 tmpvar_20;
					  tmpvar_20.x = tmpvar_10.x;
					  tmpvar_20.y = (tmpvar_10.y + tmpvar_13.y);
					  tmpvar_20.z = ((tmpvar_10.z + tmpvar_13.z) + tmpvar_16.z);
					  tmpvar_20.w = ((tmpvar_10.w + tmpvar_13.w) + (tmpvar_16.w + tmpvar_19.w));
					  mediump vec4 tmpvar_21;
					  tmpvar_21.x = tmpvar_10.x;
					  tmpvar_21.y = tmpvar_13.y;
					  tmpvar_21.z = tmpvar_16.z;
					  tmpvar_21.w = tmpvar_19.w;
					  density_7.y = dot (tmpvar_20, vec4(0.5, 0.125, 0.04166667, 0.015625));
					  density_7.z = dot (tmpvar_21, vec4(0.5, 0.25, 0.125, 0.0625));
					  highp vec2 tmpvar_22;
					  tmpvar_22 = vec2(TOD_CloudCoverage);
					  stepA_5 = tmpvar_22;
					  highp vec2 tmpvar_23;
					  tmpvar_23 = vec2((TOD_CloudCoverage + TOD_CloudSharpness));
					  stepB_4 = tmpvar_23;
					  highp vec2 tmpvar_24;
					  tmpvar_24 = vec2(TOD_CloudDensity);
					  stepC_3 = tmpvar_24;
					  mediump vec2 tmpvar_25;
					  tmpvar_25 = clamp (((density_7.yz - stepA_5) / (stepB_4 - stepA_5)), 0.0, 1.0);
					  density_7.yz = ((tmpvar_25 * (tmpvar_25 * 
					    (3.0 - (2.0 * tmpvar_25))
					  )) + (clamp (
					    (density_7.yz - stepB_4)
					  , 0.0, 1.0) * stepC_3));
					  density_7.x = clamp (density_7.z, 0.0, 1.0);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = TOD_CloudAttenuation;
					  tmpvar_26.y = TOD_CloudSaturation;
					  density_7.yz = (density_7.yz * tmpvar_26);
					  density_7.yz = (1.0 - exp2(-(density_7.yz)));
					  res_2.w = density_7.x;
					  res_2.xyz = vec3((1.0 - density_7.y));
					  res_2 = (res_2 * xlv_TEXCOORD0);
					  highp float tmpvar_27;
					  tmpvar_27 = clamp (((1.0 - density_7.z) * (1.0 - TOD_Fogginess)), 0.0, 1.0);
					  res_2.xyz = (res_2.xyz + (tmpvar_27 * xlv_TEXCOORD4));
					  color_1.w = res_2.w;
					  lowp vec4 tmpvar_28;
					  tmpvar_28 = texture2D (_DitheringTexture, xlv_TEXCOORD5);
					  color_1.xyz = (res_2.xyz + (tmpvar_28.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					lowp float u_xlat10_19;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_19 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_19) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat1.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					lowp float u_xlat10_19;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_19 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_19) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat1.xyz;
					    SV_Target0 = u_xlat0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
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
					uniform 	vec3 TOD_CloudOffset;
					uniform 	vec3 TOD_CloudWind;
					uniform 	vec3 TOD_CloudSize;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					out highp vec2 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat22;
					int u_xlati22;
					float u_xlat28;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat34;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4glstate_matrix_mvp[1];
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat2.x = u_xlat1.y * 0.850000024 + 0.150000006;
					    u_xlat2.x = float(1.0) / u_xlat2.x;
					    u_xlat2.xz = u_xlat1.xz * u_xlat2.xx;
					    u_xlat2.y = 1.0;
					    u_xlat2.xyz = u_xlat2.xyz / TOD_CloudSize.xyz;
					    u_xlat3.xy = u_xlat2.xz + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.xy = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat21.x = dot(vec2(0.98480773, -0.173648179), u_xlat2.xz);
					    u_xlat21.y = dot(vec2(0.173648179, 0.98480773), u_xlat2.xz);
					    u_xlat3.xy = u_xlat21.xy + TOD_CloudOffset.xz;
					    vs_TEXCOORD1.zw = u_xlat3.xy + TOD_CloudWind.xz;
					    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat29 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat3.w = u_xlat29 * 0.5;
					    u_xlat3.xy = u_xlat3.zz + u_xlat3.xw;
					    u_xlat3.xy = u_xlat3.xy / u_xlat0.ww;
					    u_xlat3.xy = u_xlat3.xy * _ScreenParams.xy;
					    vs_TEXCOORD5.xy = u_xlat3.xy * vec2(0.125, 0.125);
					    u_xlat29 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat2.xyz = vec3(u_xlat29) * u_xlat2.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat29 = TOD_CloudScattering * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat4.xy = vec2(u_xlat1.w * u_xlat1.w, u_xlat1.y * u_xlat1.y);
					    u_xlat30 = u_xlat4.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat30 = u_xlat30 + (-TOD_kRadius.y);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat30;
					    u_xlat4.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat4.x = u_xlat4.x * 1.44269502;
					    u_xlat4.x = exp2(u_xlat4.x);
					    u_xlat22 = u_xlat1.w * u_xlat3.y;
					    u_xlat22 = u_xlat22 / u_xlat3.y;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat31 = u_xlat22 * 5.25 + -6.80000019;
					    u_xlat31 = u_xlat22 * u_xlat31 + 3.82999992;
					    u_xlat31 = u_xlat22 * u_xlat31 + 0.458999991;
					    u_xlat22 = u_xlat22 * u_xlat31 + -0.00286999997;
					    u_xlat22 = u_xlat22 * 1.44269502;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat4.x = u_xlat22 * u_xlat4.x;
					    u_xlat30 = u_xlat30 * 0.5;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat30);
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat5.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat5.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat6.xyz = u_xlat3.xyz;
					    u_xlat7.x = float(0.0);
					    u_xlat7.y = float(0.0);
					    u_xlat7.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat29 * u_xlat31;
					        u_xlat34 = dot(u_xlat1.xwz, u_xlat6.xyz);
					        u_xlat8.x = dot(TOD_LocalSunDirection.xyz, u_xlat6.xyz);
					        u_xlat8.x = (-u_xlat8.x) * u_xlat32 + 1.0;
					        u_xlat17 = u_xlat8.x * 5.25 + -6.80000019;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 3.82999992;
					        u_xlat17 = u_xlat8.x * u_xlat17 + 0.458999991;
					        u_xlat8.x = u_xlat8.x * u_xlat17 + -0.00286999997;
					        u_xlat8.x = u_xlat8.x * 1.44269502;
					        u_xlat8.x = exp2(u_xlat8.x);
					        u_xlat32 = (-u_xlat34) * u_xlat32 + 1.0;
					        u_xlat34 = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat34 = u_xlat32 * u_xlat34 + 3.82999992;
					        u_xlat34 = u_xlat32 * u_xlat34 + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat34 + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat8.x * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat4.x * 0.25 + u_xlat31;
					        u_xlat8.xyz = u_xlat5.xyz * (-vec3(u_xlat31));
					        u_xlat8.xyz = u_xlat8.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat8.xyz = exp2(u_xlat8.xyz);
					        u_xlat7.xyz = u_xlat8.xyz * vec3(u_xlat33) + u_xlat7.xyz;
					        u_xlat6.xyz = u_xlat1.xwz * vec3(u_xlat30) + u_xlat6.xyz;
					    }
					    u_xlat3.xyz = u_xlat7.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * TOD_kSun.www;
					    u_xlat28 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat29 = u_xlat28 * u_xlat28 + 1.0;
					    u_xlat29 = u_xlat29 * TOD_kBetaMie.x;
					    u_xlat28 = TOD_kBetaMie.z * u_xlat28 + TOD_kBetaMie.y;
					    u_xlat28 = log2(u_xlat28);
					    u_xlat28 = u_xlat28 * 1.5;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat29 / u_xlat28;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * TOD_MoonHaloColor.xyz;
					    u_xlat1.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat3.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
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
					    u_xlat10.x = dot(u_xlat2.xyz, TOD_LocalSunDirection.xyz);
					    u_xlat10.x = u_xlat10.x + 1.25;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
					#else
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					#endif
					    u_xlat1.x = u_xlat10.x * u_xlat1.x;
					    u_xlat10.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_SunCloudColor.xyz + (-TOD_MoonCloudColor.xyz);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10.xyz + TOD_MoonCloudColor.xyz;
					    u_xlat3.xyz = vec3(vec3(TOD_CloudBrightness, TOD_CloudBrightness, TOD_CloudBrightness)) * TOD_FogColor.xyz + (-u_xlat1.xyz);
					    vs_TEXCOORD0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat1.x = u_xlat4.y * 500.0;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    vs_TEXCOORD0.w = u_xlat1.x * TOD_CloudOpacity;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = TOD_LocalSunDirection.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_CloudCoverage;
					uniform 	float TOD_CloudSharpness;
					uniform 	float TOD_CloudDensity;
					uniform 	float TOD_CloudAttenuation;
					uniform 	float TOD_CloudSaturation;
					uniform lowp sampler2D _MainTex;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec4 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD4;
					in highp vec2 vs_TEXCOORD5;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					lowp vec3 u_xlat10_2;
					vec4 u_xlat3;
					mediump vec3 u_xlat16_4;
					mediump vec2 u_xlat16_5;
					lowp vec2 u_xlat10_13;
					mediump vec2 u_xlat16_16;
					lowp float u_xlat10_19;
					mediump float u_xlat16_21;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xz * vec2(0.300000012, 0.300000012) + vs_TEXCOORD1.zw;
					    u_xlat0.w = texture(_MainTex, u_xlat0.xy).w;
					    u_xlat1 = vs_TEXCOORD2.xzxz * vec4(0.100000001, 0.100000001, 0.200000003, 0.200000003) + vs_TEXCOORD1.zwxy;
					    u_xlat10_13.xy = texture(_MainTex, u_xlat1.zw).zw;
					    u_xlat10_2.xyz = texture(_MainTex, u_xlat1.xy).yzw;
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat16_4.xyz = vec3(u_xlat10_2.x + u_xlat3.y, u_xlat10_2.y + u_xlat3.z, u_xlat10_2.z + u_xlat3.w);
					    u_xlat0.y = u_xlat10_2.x;
					    u_xlat16_4.yz = vec2(u_xlat10_13.x + u_xlat16_4.y, u_xlat10_13.y + u_xlat16_4.z);
					    u_xlat0.z = u_xlat10_13.x;
					    u_xlat16_21 = u_xlat0.w + u_xlat16_4.z;
					    u_xlat3.yz = u_xlat16_4.xy;
					    u_xlat3.w = u_xlat16_21;
					    u_xlat16_4.x = dot(u_xlat3, vec4(0.5, 0.125, 0.0416666679, 0.015625));
					    u_xlat0.x = u_xlat3.x;
					    u_xlat16_4.y = dot(u_xlat0, vec4(0.5, 0.25, 0.125, 0.0625));
					    u_xlat0.x = TOD_CloudSharpness + TOD_CloudCoverage;
					    u_xlat16_16.xy = (-u_xlat0.xx) + u_xlat16_4.xy;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_16.xy = min(max(u_xlat16_16.xy, 0.0), 1.0);
					#else
					    u_xlat16_16.xy = clamp(u_xlat16_16.xy, 0.0, 1.0);
					#endif
					    u_xlat16_4.xy = u_xlat16_4.xy + (-vec2(TOD_CloudCoverage));
					    u_xlat16_16.xy = u_xlat16_16.xy * vec2(vec2(TOD_CloudDensity, TOD_CloudDensity));
					    u_xlat16_5.x = float(1.0) / TOD_CloudSharpness;
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_5.xx;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
					#else
					    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = u_xlat16_4.xy * vec2(-2.0, -2.0) + vec2(3.0, 3.0);
					    u_xlat16_4.xy = u_xlat16_4.xy * u_xlat16_4.xy;
					    u_xlat16_4.xz = u_xlat16_5.xy * u_xlat16_4.xy + u_xlat16_16.xy;
					    u_xlat16_5.x = u_xlat16_4.x * TOD_CloudAttenuation;
					    u_xlat16_5.y = u_xlat16_4.z * TOD_CloudSaturation;
					    u_xlat16_4.z = u_xlat16_4.z;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat16_4.z = min(max(u_xlat16_4.z, 0.0), 1.0);
					#else
					    u_xlat16_4.z = clamp(u_xlat16_4.z, 0.0, 1.0);
					#endif
					    u_xlat16_5.xy = exp2((-u_xlat16_5.xy));
					    u_xlat16_5.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat16_4.xy = (-u_xlat16_5.xy) + vec2(1.0, 1.0);
					    u_xlat0 = u_xlat16_4.xxxz * vs_TEXCOORD0;
					    u_xlat1.x = (-TOD_Fogginess) + 1.0;
					    u_xlat1.x = u_xlat1.x * u_xlat16_4.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
					#else
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					#endif
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD4.xyz + u_xlat0.xyz;
					    u_xlat10_19 = texture(_DitheringTexture, vs_TEXCOORD5.xy).w;
					    u_xlat0.xyz = vec3(u_xlat10_19) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat1.xyz;
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
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_CLOUDS_BUMPED" "TOD_CLOUDS_DENSITY" }
					"!!GLES3"
}
}
 }
}
Fallback Off
}