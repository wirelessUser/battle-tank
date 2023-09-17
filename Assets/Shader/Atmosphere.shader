Shader "Time of Day/Atmosphere" {
Properties {
 _DitheringTexture ("Dithering Lookup Texture (A)", 2D) = "black" { }
}
SubShader { 
 Tags { "QUEUE"="Background+50" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background+50" "IGNOREPROJECTOR"="true" "RenderType"="Background" }
  ZWrite Off
  Blend One One
  GpuProgramID 46726
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_29;
					  color_29 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = sqrt(color_29);
					  color_29 = tmpvar_30;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
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
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_29;
					  color_29 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = sqrt(color_29);
					  color_29 = tmpvar_30;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
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
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_29;
					  color_29 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = sqrt(color_29);
					  color_29 = tmpvar_30;
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_30;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
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
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
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
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_8;
					  color_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(color_8);
					  color_8 = tmpvar_9;
					  gl_FragData[0] = tmpvar_9;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_8;
					  color_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(color_8);
					  color_8 = tmpvar_9;
					  gl_FragData[0] = tmpvar_9;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_8;
					  color_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(color_8);
					  color_8 = tmpvar_9;
					  gl_FragData[0] = tmpvar_9;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = sqrt(u_xlat0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = sqrt(u_xlat0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = sqrt(u_xlat0);
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
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_30;
					  color_30 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = sqrt(color_30);
					  color_30 = tmpvar_31;
					  highp vec4 o_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = tmpvar_33.x;
					  tmpvar_34.y = (tmpvar_33.y * _ProjectionParams.x);
					  o_32.xy = (tmpvar_34 + tmpvar_33.w);
					  o_32.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_32.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_31;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
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
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_30;
					  color_30 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = sqrt(color_30);
					  color_30 = tmpvar_31;
					  highp vec4 o_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = tmpvar_33.x;
					  tmpvar_34.y = (tmpvar_33.y * _ProjectionParams.x);
					  o_32.xy = (tmpvar_34 + tmpvar_33.w);
					  o_32.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_32.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_31;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
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
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_30;
					  color_30 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = sqrt(color_30);
					  color_30 = tmpvar_31;
					  highp vec4 o_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_34;
					  tmpvar_34.x = tmpvar_33.x;
					  tmpvar_34.y = (tmpvar_33.y * _ProjectionParams.x);
					  o_32.xy = (tmpvar_34 + tmpvar_33.w);
					  o_32.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_32.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_31;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
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
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat1);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
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
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat1);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
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
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    u_xlat1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    vs_TEXCOORD1 = sqrt(u_xlat1);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  highp vec4 tmpvar_10;
					  tmpvar_10 = sqrt(color_9);
					  color_9 = tmpvar_10;
					  color_1.w = tmpvar_10.w;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_10.xyz + (tmpvar_11.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  highp vec4 tmpvar_10;
					  tmpvar_10 = sqrt(color_9);
					  color_9 = tmpvar_10;
					  color_1.w = tmpvar_10.w;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_10.xyz + (tmpvar_11.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  highp vec4 tmpvar_10;
					  tmpvar_10 = sqrt(color_9);
					  color_9 = tmpvar_10;
					  color_1.w = tmpvar_10.w;
					  lowp vec4 tmpvar_11;
					  tmpvar_11 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_10.xyz + (tmpvar_11.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = sqrt(u_xlat0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = sqrt(u_xlat0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = sqrt(u_xlat0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
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
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_28)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    vs_TEXCOORD1 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    vs_TEXCOORD1 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    vs_TEXCOORD1 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_7)));
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    SV_Target0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    SV_Target0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    SV_Target0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_29)));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    vs_TEXCOORD1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    vs_TEXCOORD1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.w = 1.0;
					    u_xlat1 = u_xlat1 * (-vec4(TOD_Brightness));
					    u_xlat1 = exp2(u_xlat1);
					    vs_TEXCOORD1 = (-u_xlat1) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  color_1.w = color_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (color_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  color_1.w = color_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (color_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 color_9;
					  color_9 = (1.0 - exp2((
					    -(TOD_Brightness)
					   * tmpvar_8)));
					  color_1.w = color_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (color_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					lowp float u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.w = 1.0;
					    u_xlat0 = u_xlat0 * (-vec4(TOD_Brightness));
					    u_xlat0 = exp2(u_xlat0);
					    u_xlat0 = (-u_xlat0) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10_1 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_1) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = sqrt(tmpvar_28);
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = sqrt(tmpvar_28);
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = sqrt(tmpvar_28);
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = sqrt(tmpvar_7);
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = sqrt(tmpvar_7);
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_8;
					  tmpvar_8 = sqrt(tmpvar_7);
					  gl_FragData[0] = tmpvar_8;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.xyz = sqrt(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.xyz = sqrt(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.xyz = sqrt(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = sqrt(tmpvar_29);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = sqrt(tmpvar_29);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = sqrt(tmpvar_29);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat1.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat1.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    vs_TEXCOORD1.xyz = sqrt(u_xlat1.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(tmpvar_8);
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(tmpvar_8);
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9 = sqrt(tmpvar_8);
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_9.xyz + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = sqrt(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = sqrt(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = sqrt(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_28;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_28;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp vec3 resultColor_23;
					  highp float tmpvar_24;
					  tmpvar_24 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_25;
					  tmpvar_25 = (tmpvar_24 * tmpvar_24);
					  resultColor_23 = ((0.75 + (0.75 * tmpvar_25)) * ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz));
					  resultColor_23 = (resultColor_23 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_25))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_24)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_3)
					   * TOD_kSun.w)));
					  highp vec3 dir_26;
					  dir_26.xz = tmpvar_1.xz;
					  dir_26.y = max (0.0, tmpvar_1.y);
					  resultColor_23 = (resultColor_23 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_26.y)
					  )));
					  resultColor_23 = (resultColor_23 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_27;
					  tmpvar_27 = mix (resultColor_23, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_23 = tmpvar_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28.w = 1.0;
					  tmpvar_28.xyz = pow ((tmpvar_27 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = tmpvar_28;
					}
					
					
					#endif
					#ifdef FRAGMENT
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  gl_FragData[0] = xlv_TEXCOORD1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat21;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2.x = u_xlat2.x * 1.44269502;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2.x = u_xlat9 * u_xlat2.x;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2.x * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * TOD_kSun.www;
					    u_xlat22 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat23 = u_xlat22 * u_xlat22;
					    u_xlat23 = u_xlat23 * 0.75 + 0.75;
					    u_xlat3.x = u_xlat22 * u_xlat22 + 1.0;
					    u_xlat3.x = u_xlat3.x * TOD_kBetaMie.x;
					    u_xlat22 = TOD_kBetaMie.z * u_xlat22 + TOD_kBetaMie.y;
					    u_xlat22 = log2(u_xlat22);
					    u_xlat22 = u_xlat22 * 1.5;
					    u_xlat22 = exp2(u_xlat22);
					    u_xlat22 = u_xlat3.x / u_xlat22;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat22);
					    u_xlat1.xyz = vec3(u_xlat23) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat21 = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat1.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat21) + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat0.xyz);
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vs_TEXCOORD1;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_FragData[0] = tmpvar_7;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_FragData[0] = tmpvar_7;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(_glesVertex.xyz);
					  highp vec3 dir_2;
					  dir_2.xz = tmpvar_1.xz;
					  highp vec3 sunColor_3;
					  highp vec3 samplePoint_4;
					  highp float scaledLength_5;
					  highp float startOffset_6;
					  dir_2.y = max (0.0, tmpvar_1.y);
					  highp vec3 tmpvar_7;
					  tmpvar_7.xz = vec2(0.0, 0.0);
					  highp float tmpvar_8;
					  tmpvar_8 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_7.y = tmpvar_8;
					  highp float tmpvar_9;
					  tmpvar_9 = (1.0 - (dot (dir_2, tmpvar_7) / tmpvar_8));
					  startOffset_6 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_9 * (0.459 + (tmpvar_9 * 
					      (3.83 + (tmpvar_9 * (-6.8 + (tmpvar_9 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_10;
					  tmpvar_10 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_2.y) * dir_2.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_2.y)) / 2.0);
					  scaledLength_5 = (tmpvar_10 * TOD_kScale.x);
					  highp vec3 tmpvar_11;
					  tmpvar_11 = (dir_2 * tmpvar_10);
					  samplePoint_4 = (tmpvar_7 + (tmpvar_11 * 0.5));
					  highp float tmpvar_12;
					  tmpvar_12 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_13;
					  tmpvar_13 = (1.0/(tmpvar_12));
					  highp float tmpvar_14;
					  tmpvar_14 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_12)));
					  highp float tmpvar_15;
					  tmpvar_15 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_13));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_13));
					  highp vec3 tmpvar_17;
					  tmpvar_17 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_3 = (exp((
					    -((startOffset_6 + (tmpvar_14 * (
					      (0.25 * exp((-0.00287 + (tmpvar_15 * 
					        (0.459 + (tmpvar_15 * (3.83 + (tmpvar_15 * 
					          (-6.8 + (tmpvar_15 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_17)) * (tmpvar_14 * scaledLength_5));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  highp float tmpvar_18;
					  tmpvar_18 = sqrt(dot (samplePoint_4, samplePoint_4));
					  highp float tmpvar_19;
					  tmpvar_19 = (1.0/(tmpvar_18));
					  highp float tmpvar_20;
					  tmpvar_20 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_18)));
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_4) * tmpvar_19));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (dir_2, samplePoint_4) * tmpvar_19));
					  sunColor_3 = (sunColor_3 + (exp(
					    (-((startOffset_6 + (tmpvar_20 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
					          (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_17)
					  ) * (tmpvar_20 * scaledLength_5)));
					  samplePoint_4 = (samplePoint_4 + tmpvar_11);
					  gl_Position = (glstate_matrix_mvp * _glesVertex);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_3) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_1;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_2;
					  highp float tmpvar_3;
					  tmpvar_3 = dot (TOD_LocalSunDirection, tmpvar_1);
					  highp float tmpvar_4;
					  tmpvar_4 = (tmpvar_3 * tmpvar_3);
					  resultColor_2 = ((0.75 + (0.75 * tmpvar_4)) * xlv_TEXCOORD1);
					  resultColor_2 = (resultColor_2 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_4))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_3)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_5;
					  dir_5.xz = tmpvar_1.xz;
					  dir_5.y = max (0.0, tmpvar_1.y);
					  resultColor_2 = (resultColor_2 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_5.y)
					  )));
					  resultColor_2 = (resultColor_2 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_1, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_6;
					  tmpvar_6 = mix (resultColor_2, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_2 = tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = pow ((tmpvar_6 * TOD_Brightness), vec3(TOD_Contrast));
					  gl_FragData[0] = tmpvar_7;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    SV_Target0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    SV_Target0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat9;
					float u_xlat13;
					float u_xlat16;
					int u_xlati16;
					float u_xlat22;
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
					    u_xlat0.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * in_POSITION0.xyz;
					    u_xlat0.w = max(u_xlat0.y, 0.0);
					    u_xlat1.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat22 = u_xlat0.w * u_xlat0.w;
					    u_xlat22 = u_xlat22 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat22 = u_xlat22 + (-TOD_kRadius.y);
					    u_xlat22 = sqrt(u_xlat22);
					    u_xlat22 = (-TOD_kRadius.x) * u_xlat0.w + u_xlat22;
					    u_xlat2 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat2 = u_xlat2 * 1.44269502;
					    u_xlat2 = exp2(u_xlat2);
					    u_xlat9 = u_xlat0.w * u_xlat1.y;
					    u_xlat9 = u_xlat9 / u_xlat1.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat16 = u_xlat9 * 5.25 + -6.80000019;
					    u_xlat16 = u_xlat9 * u_xlat16 + 3.82999992;
					    u_xlat16 = u_xlat9 * u_xlat16 + 0.458999991;
					    u_xlat9 = u_xlat9 * u_xlat16 + -0.00286999997;
					    u_xlat9 = u_xlat9 * 1.44269502;
					    u_xlat9 = exp2(u_xlat9);
					    u_xlat2 = u_xlat9 * u_xlat2;
					    u_xlat22 = u_xlat22 * 0.5;
					    u_xlat9 = u_xlat22 * TOD_kScale.x;
					    u_xlat3.xyz = u_xlat0.xwz * vec3(u_xlat22);
					    u_xlat1.x = float(0.0);
					    u_xlat1.z = float(0.0);
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + u_xlat1.xyz;
					    u_xlat3.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat4.xyz = u_xlat1.xyz;
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
					        u_xlat25 = u_xlat9 * u_xlat23;
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
					        u_xlat23 = u_xlat2 * 0.25 + u_xlat23;
					        u_xlat6.xyz = u_xlat3.xyz * (-vec3(u_xlat23));
					        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat6.xyz = exp2(u_xlat6.xyz);
					        u_xlat5.xyz = u_xlat6.xyz * vec3(u_xlat25) + u_xlat5.xyz;
					        u_xlat4.xyz = u_xlat0.xwz * vec3(u_xlat22) + u_xlat4.xyz;
					    }
					    u_xlat1.xyz = u_xlat5.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat1.xyz * TOD_kSun.www;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    SV_Target0.xyz = exp2(u_xlat0.xyz);
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_29;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_29;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec3 resultColor_24;
					  highp float tmpvar_25;
					  tmpvar_25 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_26;
					  tmpvar_26 = (tmpvar_25 * tmpvar_25);
					  resultColor_24 = ((0.75 + (0.75 * tmpvar_26)) * ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz));
					  resultColor_24 = (resultColor_24 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_26))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_25)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_4)
					   * TOD_kSun.w)));
					  highp vec3 dir_27;
					  dir_27.xz = tmpvar_2.xz;
					  dir_27.y = max (0.0, tmpvar_2.y);
					  resultColor_24 = (resultColor_24 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_27.y)
					  )));
					  resultColor_24 = (resultColor_24 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_28;
					  tmpvar_28 = mix (resultColor_24, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_24 = tmpvar_28;
					  highp vec4 tmpvar_29;
					  tmpvar_29.w = 1.0;
					  tmpvar_29.xyz = pow ((tmpvar_28 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 o_30;
					  highp vec4 tmpvar_31;
					  tmpvar_31 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = tmpvar_31.x;
					  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
					  o_30.xy = (tmpvar_32 + tmpvar_31.w);
					  o_30.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_30.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = tmpvar_29;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 color_1;
					  color_1.w = xlv_TEXCOORD1.w;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (xlv_TEXCOORD1.xyz + (tmpvar_2.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat9;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3.x = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3.x = u_xlat3.x * 1.44269502;
					    u_xlat3.x = exp2(u_xlat3.x);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3.x = u_xlat11 * u_xlat3.x;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat26 = dot(TOD_LocalSunDirection.xyz, u_xlat1.xyz);
					    u_xlat27 = u_xlat26 * u_xlat26;
					    u_xlat27 = u_xlat27 * 0.75 + 0.75;
					    u_xlat4.x = u_xlat26 * u_xlat26 + 1.0;
					    u_xlat4.x = u_xlat4.x * TOD_kBetaMie.x;
					    u_xlat26 = TOD_kBetaMie.z * u_xlat26 + TOD_kBetaMie.y;
					    u_xlat26 = log2(u_xlat26);
					    u_xlat26 = u_xlat26 * 1.5;
					    u_xlat26 = exp2(u_xlat26);
					    u_xlat26 = u_xlat4.x / u_xlat26;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat25 = (-u_xlat1.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat25) + u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * TOD_MoonHaloPower;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat1.xyz = TOD_MoonHaloColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = (-u_xlat1.xyz) + TOD_FogColor.xyz;
					    u_xlat1.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(TOD_Brightness);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    vs_TEXCOORD1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat9 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat9 * 0.5;
					    u_xlat1.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat1.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat1.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD1.w = 1.0;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec4 vs_TEXCOORD1;
					layout(location = 0) out highp vec4 SV_Target0;
					lowp float u_xlat10_0;
					void main()
					{
					    u_xlat10_0 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_0) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + vs_TEXCOORD1.xyz;
					    SV_Target0.w = vs_TEXCOORD1.w;
					    return;
					}
					#endif"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_8;
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_8 + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_8;
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_8 + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					uniform highp vec4 _ProjectionParams;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp vec3 TOD_SunSkyColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec4 TOD_kSun;
					uniform highp vec4 TOD_k4PI;
					uniform highp vec4 TOD_kRadius;
					uniform highp vec4 TOD_kScale;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(_glesVertex.xyz);
					  highp vec3 dir_3;
					  dir_3.xz = tmpvar_2.xz;
					  highp vec3 sunColor_4;
					  highp vec3 samplePoint_5;
					  highp float scaledLength_6;
					  highp float startOffset_7;
					  dir_3.y = max (0.0, tmpvar_2.y);
					  highp vec3 tmpvar_8;
					  tmpvar_8.xz = vec2(0.0, 0.0);
					  highp float tmpvar_9;
					  tmpvar_9 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_8.y = tmpvar_9;
					  highp float tmpvar_10;
					  tmpvar_10 = (1.0 - (dot (dir_3, tmpvar_8) / tmpvar_9));
					  startOffset_7 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_10 * (0.459 + (tmpvar_10 * 
					      (3.83 + (tmpvar_10 * (-6.8 + (tmpvar_10 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_11;
					  tmpvar_11 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_3.y) * dir_3.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_3.y)) / 2.0);
					  scaledLength_6 = (tmpvar_11 * TOD_kScale.x);
					  highp vec3 tmpvar_12;
					  tmpvar_12 = (dir_3 * tmpvar_11);
					  samplePoint_5 = (tmpvar_8 + (tmpvar_12 * 0.5));
					  highp float tmpvar_13;
					  tmpvar_13 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_14;
					  tmpvar_14 = (1.0/(tmpvar_13));
					  highp float tmpvar_15;
					  tmpvar_15 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_13)));
					  highp float tmpvar_16;
					  tmpvar_16 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_14));
					  highp float tmpvar_17;
					  tmpvar_17 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_14));
					  highp vec3 tmpvar_18;
					  tmpvar_18 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_4 = (exp((
					    -((startOffset_7 + (tmpvar_15 * (
					      (0.25 * exp((-0.00287 + (tmpvar_16 * 
					        (0.459 + (tmpvar_16 * (3.83 + (tmpvar_16 * 
					          (-6.8 + (tmpvar_16 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_17 * 
					        (0.459 + (tmpvar_17 * (3.83 + (tmpvar_17 * 
					          (-6.8 + (tmpvar_17 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_18)) * (tmpvar_15 * scaledLength_6));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp float tmpvar_19;
					  tmpvar_19 = sqrt(dot (samplePoint_5, samplePoint_5));
					  highp float tmpvar_20;
					  tmpvar_20 = (1.0/(tmpvar_19));
					  highp float tmpvar_21;
					  tmpvar_21 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_19)));
					  highp float tmpvar_22;
					  tmpvar_22 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_5) * tmpvar_20));
					  highp float tmpvar_23;
					  tmpvar_23 = (1.0 - (dot (dir_3, samplePoint_5) * tmpvar_20));
					  sunColor_4 = (sunColor_4 + (exp(
					    (-((startOffset_7 + (tmpvar_21 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
					          (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_23 * (0.459 + (tmpvar_23 * (3.83 + 
					          (tmpvar_23 * (-6.8 + (tmpvar_23 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_18)
					  ) * (tmpvar_21 * scaledLength_6)));
					  samplePoint_5 = (samplePoint_5 + tmpvar_12);
					  highp vec4 o_24;
					  highp vec4 tmpvar_25;
					  tmpvar_25 = (tmpvar_1 * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = tmpvar_25.x;
					  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
					  o_24.xy = (tmpvar_26 + tmpvar_25.w);
					  o_24.zw = tmpvar_1.zw;
					  gl_Position = tmpvar_1;
					  xlv_TEXCOORD0 = (((o_24.xy / tmpvar_1.w) * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD1 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.xyz);
					  xlv_TEXCOORD2 = ((TOD_SunSkyColor * sunColor_4) * TOD_kSun.w);
					  xlv_TEXCOORD3 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec3 TOD_MoonSkyColor;
					uniform highp vec3 TOD_FogColor;
					uniform highp vec3 TOD_LocalSunDirection;
					uniform highp vec3 TOD_LocalMoonDirection;
					uniform highp float TOD_Contrast;
					uniform highp float TOD_Brightness;
					uniform highp float TOD_Fogginess;
					uniform highp float TOD_MoonHaloPower;
					uniform highp vec3 TOD_MoonHaloColor;
					uniform highp vec3 TOD_kBetaMie;
					uniform sampler2D _DitheringTexture;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec3 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					void main ()
					{
					  highp vec4 color_1;
					  highp vec3 tmpvar_2;
					  tmpvar_2 = normalize(xlv_TEXCOORD3);
					  highp vec3 resultColor_3;
					  highp float tmpvar_4;
					  tmpvar_4 = dot (TOD_LocalSunDirection, tmpvar_2);
					  highp float tmpvar_5;
					  tmpvar_5 = (tmpvar_4 * tmpvar_4);
					  resultColor_3 = ((0.75 + (0.75 * tmpvar_5)) * xlv_TEXCOORD1);
					  resultColor_3 = (resultColor_3 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_5))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_4)), 1.5)
					  ) * xlv_TEXCOORD2));
					  highp vec3 dir_6;
					  dir_6.xz = tmpvar_2.xz;
					  dir_6.y = max (0.0, tmpvar_2.y);
					  resultColor_3 = (resultColor_3 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_6.y)
					  )));
					  resultColor_3 = (resultColor_3 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_2, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_7;
					  tmpvar_7 = mix (resultColor_3, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_3 = tmpvar_7;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = pow ((tmpvar_7 * TOD_Brightness), vec3(TOD_Contrast));
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_8;
					  color_1.w = tmpvar_9.w;
					  lowp vec4 tmpvar_10;
					  tmpvar_10 = texture2D (_DitheringTexture, xlv_TEXCOORD0);
					  color_1.xyz = (tmpvar_8 + (tmpvar_10.w * 0.01538462));
					  gl_FragData[0] = color_1;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					uniform 	vec4 _ProjectionParams;
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec3 TOD_SunSkyColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec4 TOD_kSun;
					uniform 	vec4 TOD_k4PI;
					uniform 	vec4 TOD_kRadius;
					uniform 	vec4 TOD_kScale;
					in highp vec4 in_POSITION0;
					out highp vec2 vs_TEXCOORD0;
					out highp vec3 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					float u_xlat11;
					float u_xlat15;
					float u_xlat19;
					int u_xlati19;
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
					    u_xlat0 = hlslcc_mtx4glstate_matrix_mvp[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
					    u_xlat1.w = max(u_xlat1.y, 0.0);
					    u_xlat2.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat26 = u_xlat1.w * u_xlat1.w;
					    u_xlat26 = u_xlat26 * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat26 = u_xlat26 + (-TOD_kRadius.y);
					    u_xlat26 = sqrt(u_xlat26);
					    u_xlat26 = (-TOD_kRadius.x) * u_xlat1.w + u_xlat26;
					    u_xlat3 = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat3 = u_xlat3 * 1.44269502;
					    u_xlat3 = exp2(u_xlat3);
					    u_xlat11 = u_xlat1.w * u_xlat2.y;
					    u_xlat11 = u_xlat11 / u_xlat2.y;
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19 = u_xlat11 * 5.25 + -6.80000019;
					    u_xlat19 = u_xlat11 * u_xlat19 + 3.82999992;
					    u_xlat19 = u_xlat11 * u_xlat19 + 0.458999991;
					    u_xlat11 = u_xlat11 * u_xlat19 + -0.00286999997;
					    u_xlat11 = u_xlat11 * 1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat3 = u_xlat11 * u_xlat3;
					    u_xlat26 = u_xlat26 * 0.5;
					    u_xlat11 = u_xlat26 * TOD_kScale.x;
					    u_xlat4.xyz = u_xlat1.xwz * vec3(u_xlat26);
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
					        u_xlat29 = u_xlat11 * u_xlat27;
					        u_xlat30 = dot(u_xlat1.xwz, u_xlat5.xyz);
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
					        u_xlat27 = u_xlat3 * 0.25 + u_xlat27;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat27));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat29) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat1.xwz * vec3(u_xlat26) + u_xlat5.xyz;
					    }
					    u_xlat2.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * TOD_kSun.xyz;
					    vs_TEXCOORD2.xyz = u_xlat2.xyz * TOD_kSun.www;
					    u_xlat2.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat25 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.w = u_xlat25 * 0.5;
					    u_xlat2.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat2.xy = u_xlat2.xy / u_xlat0.ww;
					    u_xlat2.xy = u_xlat2.xy * _ScreenParams.xy;
					    vs_TEXCOORD0.xy = u_xlat2.xy * vec2(0.125, 0.125);
					    gl_Position = u_xlat0;
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec3 TOD_MoonSkyColor;
					uniform 	vec3 TOD_FogColor;
					uniform 	vec3 TOD_LocalSunDirection;
					uniform 	vec3 TOD_LocalMoonDirection;
					uniform 	float TOD_Contrast;
					uniform 	float TOD_Brightness;
					uniform 	float TOD_Fogginess;
					uniform 	float TOD_MoonHaloPower;
					uniform 	vec3 TOD_MoonHaloColor;
					uniform 	vec3 TOD_kBetaMie;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec3 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					layout(location = 0) out highp vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					lowp float u_xlat10_6;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
					    u_xlat6 = dot(TOD_LocalSunDirection.xyz, u_xlat0.xyz);
					    u_xlat1.x = TOD_kBetaMie.z * u_xlat6 + TOD_kBetaMie.y;
					    u_xlat1.x = log2(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * 1.5;
					    u_xlat1.x = exp2(u_xlat1.x);
					    u_xlat3 = u_xlat6 * u_xlat6 + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat6;
					    u_xlat6 = u_xlat6 * 0.75 + 0.75;
					    u_xlat3 = u_xlat3 * TOD_kBetaMie.x;
					    u_xlat1.x = u_xlat3 / u_xlat1.x;
					    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD2.xyz;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat0.xw = max(u_xlat0.xy, vec2(0.0, 0.0));
					    u_xlat0.x = log2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * TOD_MoonHaloPower;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat2.x = (-u_xlat0.w) * 0.75 + 1.0;
					    u_xlat2.xyz = TOD_MoonSkyColor.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = TOD_MoonHaloColor.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = (-u_xlat0.xyz) + TOD_FogColor.xyz;
					    u_xlat0.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(TOD_Brightness);
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat10_6 = texture(_DitheringTexture, vs_TEXCOORD0.xy).w;
					    SV_Target0.xyz = vec3(u_xlat10_6) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat0.xyz;
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
SubProgram "gles hw_tier01 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_SCATTERING_PER_PIXEL" }
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
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_SCATTERING_PER_PIXEL" }
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
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3"
}
SubProgram "gles hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" "TOD_SCATTERING_PER_PIXEL" }
					"!!GLES3"
}
}
 }
}
Fallback Off
}