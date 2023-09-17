Shader "Hidden/Time of Day/Scattering" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" { }
 _DitheringTexture ("Dithering Lookup Texture (A)", 2D) = "black" { }
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 57643
Program "vp" {
SubProgram "gles hw_tier01 " {
"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
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
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
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
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = sqrt(scattering_1);
					  scattering_1 = tmpvar_43;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_43.xyz);
					  } else {
					    highp vec3 tmpvar_44;
					    tmpvar_44 = mix (color_3.xyz, tmpvar_43.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_44;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = sqrt(scattering_1);
					  scattering_1 = tmpvar_43;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_43.xyz);
					  } else {
					    highp vec3 tmpvar_44;
					    tmpvar_44 = mix (color_3.xyz, tmpvar_43.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_44;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  mediump vec4 tmpvar_43;
					  tmpvar_43 = sqrt(scattering_1);
					  scattering_1 = tmpvar_43;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_43.xyz);
					  } else {
					    highp vec3 tmpvar_44;
					    tmpvar_44 = mix (color_3.xyz, tmpvar_43.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_44;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * (-vec3(TOD_Brightness));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = (-u_xlat11.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
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
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  highp vec4 tmpvar_41;
					  tmpvar_41 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_41);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  highp vec4 tmpvar_42;
					  tmpvar_42 = exp2((-(TOD_Brightness) * scattering_1));
					  scattering_1 = (1.0 - tmpvar_42);
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * (-vec3(TOD_Brightness));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10.xyz = (-u_xlat10.xyz) + vec3(1.0, 1.0, 1.0);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  mediump vec4 tmpvar_41;
					  tmpvar_41 = sqrt(scattering_1);
					  scattering_1 = tmpvar_41;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_41.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, tmpvar_41.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  mediump vec4 tmpvar_41;
					  tmpvar_41 = sqrt(scattering_1);
					  scattering_1 = tmpvar_41;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_41.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, tmpvar_41.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  mediump vec4 tmpvar_41;
					  tmpvar_41 = sqrt(scattering_1);
					  scattering_1 = tmpvar_41;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_41.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, tmpvar_41.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  mediump vec4 tmpvar_42;
					  tmpvar_42 = sqrt(scattering_1);
					  scattering_1 = tmpvar_42;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + tmpvar_42.xyz);
					  } else {
					    highp vec3 tmpvar_43;
					    tmpvar_43 = mix (color_3.xyz, tmpvar_42.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_43;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					mediump vec3 u_xlat16_2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					mediump vec3 u_xlat16_9;
					vec3 u_xlat11;
					bool u_xlatb11;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat17;
					vec2 u_xlat21;
					float u_xlat27;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					int u_xlati33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat11.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = u_xlat11.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb31 = !!(0.0<_Density.x);
					#else
					    u_xlatb31 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb12 = !!(0.00999999978<abs(u_xlat11.y));
					#else
					    u_xlatb12 = 0.00999999978<abs(u_xlat11.y);
					#endif
					    u_xlatb31 = u_xlatb31 && u_xlatb12;
					    u_xlat21.x = u_xlat11.y * _Density.x;
					    u_xlat12 = u_xlat21.x * -1.44269502;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat12 = (-u_xlat12) + 1.0;
					    u_xlat21.x = u_xlat12 / u_xlat21.x;
					    u_xlat21.x = u_xlat21.x * u_xlat11.x;
					    u_xlat11.x = (u_xlatb31) ? u_xlat21.x : u_xlat11.x;
					    u_xlat11.x = u_xlat11.x * _Density.z;
					    u_xlat11.x = min(u_xlat11.x, 10.0);
					    u_xlat11.x = u_xlat11.x * -1.44269502;
					    u_xlat11.x = exp2(u_xlat11.x);
					    u_xlat11.x = (-u_xlat11.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat11.x : u_xlat1;
					    u_xlat11.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat11.x = inversesqrt(u_xlat11.x);
					    u_xlat2.xyz = u_xlat11.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat11.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat21.x = u_xlat2.w * u_xlat2.w;
					    u_xlat21.x = u_xlat21.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat21.x = u_xlat21.x + (-TOD_kRadius.y);
					    u_xlat21.x = sqrt(u_xlat21.x);
					    u_xlat21.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat21.x;
					    u_xlat21.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat21.xy = u_xlat21.xy * vec2(0.5, 1.44269502);
					    u_xlat31 = exp2(u_xlat21.y);
					    u_xlat33 = u_xlat2.w * u_xlat3.y;
					    u_xlat33 = u_xlat33 / u_xlat3.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat4.x = u_xlat33 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat33 * u_xlat4.x + 0.458999991;
					    u_xlat33 = u_xlat33 * u_xlat4.x + -0.00286999997;
					    u_xlat33 = u_xlat33 * 1.44269502;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat33;
					    u_xlat11.x = u_xlat11.x * u_xlat21.x;
					    u_xlat4.xyz = u_xlat21.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat34 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat34 = sqrt(u_xlat34);
					        u_xlat35 = float(1.0) / u_xlat34;
					        u_xlat34 = (-u_xlat34) + TOD_kRadius.x;
					        u_xlat34 = u_xlat34 * TOD_kScale.z;
					        u_xlat34 = u_xlat34 * 1.44269502;
					        u_xlat34 = exp2(u_xlat34);
					        u_xlat36 = u_xlat11.x * u_xlat34;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat17 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat17 = (-u_xlat17) * u_xlat35 + 1.0;
					        u_xlat27 = u_xlat17 * 5.25 + -6.80000019;
					        u_xlat27 = u_xlat17 * u_xlat27 + 3.82999992;
					        u_xlat27 = u_xlat17 * u_xlat27 + 0.458999991;
					        u_xlat17 = u_xlat17 * u_xlat27 + -0.00286999997;
					        u_xlat17 = u_xlat17 * 1.44269502;
					        u_xlat17 = exp2(u_xlat17);
					        u_xlat35 = (-u_xlat7.x) * u_xlat35 + 1.0;
					        u_xlat7.x = u_xlat35 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat35 * u_xlat7.x + 0.458999991;
					        u_xlat35 = u_xlat35 * u_xlat7.x + -0.00286999997;
					        u_xlat35 = u_xlat35 * 1.44269502;
					        u_xlat35 = exp2(u_xlat35);
					        u_xlat35 = u_xlat35 * 0.25;
					        u_xlat35 = u_xlat17 * 0.25 + (-u_xlat35);
					        u_xlat34 = u_xlat34 * u_xlat35;
					        u_xlat34 = u_xlat31 * 0.25 + u_xlat34;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat34));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat36) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat21.xxx + u_xlat5.xyz;
					    }
					    u_xlat11.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat11.xyz * TOD_kSun.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * TOD_kSun.www;
					    u_xlat33 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat33 * u_xlat33;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat14 = u_xlat33 * u_xlat33 + 1.0;
					    u_xlat14 = u_xlat14 * TOD_kBetaMie.x;
					    u_xlat33 = TOD_kBetaMie.z * u_xlat33 + TOD_kBetaMie.y;
					    u_xlat33 = log2(u_xlat33);
					    u_xlat33 = u_xlat33 * 1.5;
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat33 = u_xlat14 / u_xlat33;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(u_xlat33);
					    u_xlat11.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat11.xyz;
					    u_xlat32 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat11.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat32) + u_xlat11.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat11.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat11.xyz;
					    u_xlat2.xyz = (-u_xlat11.xyz) + TOD_FogColor.xyz;
					    u_xlat11.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat11.xyz;
					    u_xlat11.xyz = u_xlat11.xyz * vec3(TOD_Brightness);
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat11.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat11.xyz;
					    u_xlat16_8.xyz = sqrt(u_xlat11.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(u_xlat1==1.0);
					#else
					    u_xlatb11 = u_xlat1==1.0;
					#endif
					    u_xlat16_9.xyz = u_xlat10_0.xyz + u_xlat16_8.xyz;
					    u_xlat16_2.xyz = (-u_xlat10_0.xyz) + u_xlat16_8.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat16_2.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb11)) ? u_xlat16_9.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_41;
					    tmpvar_41 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_41;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_41;
					    tmpvar_41 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_41;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_41;
					    tmpvar_41 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_41;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ScreenParams;
					uniform highp mat4 glstate_matrix_mvp;
					uniform highp mat4 TOD_World2Sky;
					uniform highp mat4 _FrustumCornersWS;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
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
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = TOD_World2Sky[0].xyz;
					  tmpvar_11[1] = TOD_World2Sky[1].xyz;
					  tmpvar_11[2] = TOD_World2Sky[2].xyz;
					  gl_Position = (glstate_matrix_mvp * tmpvar_3);
					  xlv_TEXCOORD0 = tmpvar_5;
					  xlv_TEXCOORD1 = tmpvar_6;
					  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScreenParams.xy) * 0.125);
					  xlv_TEXCOORD3 = tmpvar_10;
					  xlv_TEXCOORD4 = normalize((tmpvar_11 * tmpvar_10));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
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
					uniform sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform sampler2D _DitheringTexture;
					uniform highp vec4 _Density;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying highp vec2 xlv_TEXCOORD2;
					varying highp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec4 scattering_1;
					  highp float depth_2;
					  mediump vec4 color_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
					  color_3 = tmpvar_4;
					  highp float tmpvar_5;
					  tmpvar_5 = (1.0/(((_ZBufferParams.x * texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.y)));
					  depth_2 = tmpvar_5;
					  highp vec3 tmpvar_6;
					  tmpvar_6 = (tmpvar_5 * xlv_TEXCOORD3);
					  if ((tmpvar_5 != 1.0)) {
					    highp float fogIntensity_7;
					    highp float tmpvar_8;
					    tmpvar_8 = (sqrt(dot (tmpvar_6, tmpvar_6)) * _Density.y);
					    fogIntensity_7 = tmpvar_8;
					    bool tmpvar_9;
					    if ((_Density.x > 0.0)) {
					      highp float tmpvar_10;
					      tmpvar_10 = abs(tmpvar_6.y);
					      tmpvar_9 = (tmpvar_10 > 0.01);
					    } else {
					      tmpvar_9 = bool(0);
					    };
					    if (tmpvar_9) {
					      highp float tmpvar_11;
					      tmpvar_11 = (_Density.x * tmpvar_6.y);
					      fogIntensity_7 = (tmpvar_8 * ((1.0 - 
					        exp(-(tmpvar_11))
					      ) / tmpvar_11));
					    };
					    highp float tmpvar_12;
					    tmpvar_12 = min (10.0, (_Density.z * fogIntensity_7));
					    fogIntensity_7 = tmpvar_12;
					    depth_2 = (1.0 - exp(-(tmpvar_12)));
					  };
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize(xlv_TEXCOORD4);
					  highp vec3 dir_14;
					  dir_14.xz = tmpvar_13.xz;
					  highp vec3 sunColor_15;
					  highp vec3 samplePoint_16;
					  highp float scaledLength_17;
					  highp float startOffset_18;
					  dir_14.y = max (0.0, tmpvar_13.y);
					  highp vec3 tmpvar_19;
					  tmpvar_19.xz = vec2(0.0, 0.0);
					  highp float tmpvar_20;
					  tmpvar_20 = (TOD_kRadius.x + TOD_kScale.w);
					  tmpvar_19.y = tmpvar_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (1.0 - (dot (dir_14, tmpvar_19) / tmpvar_20));
					  startOffset_18 = (exp((TOD_kScale.z * 
					    -(TOD_kScale.w)
					  )) * (0.25 * exp(
					    (-0.00287 + (tmpvar_21 * (0.459 + (tmpvar_21 * 
					      (3.83 + (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25))))
					    ))))
					  )));
					  highp float tmpvar_22;
					  tmpvar_22 = ((sqrt(
					    ((TOD_kRadius.w + ((TOD_kRadius.y * dir_14.y) * dir_14.y)) - TOD_kRadius.y)
					  ) - (TOD_kRadius.x * dir_14.y)) / 2.0);
					  scaledLength_17 = (tmpvar_22 * (TOD_kScale.x * depth_2));
					  highp vec3 tmpvar_23;
					  tmpvar_23 = (dir_14 * tmpvar_22);
					  samplePoint_16 = (tmpvar_19 + (tmpvar_23 * 0.5));
					  highp float tmpvar_24;
					  tmpvar_24 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_25;
					  tmpvar_25 = (1.0/(tmpvar_24));
					  highp float tmpvar_26;
					  tmpvar_26 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_24)));
					  highp float tmpvar_27;
					  tmpvar_27 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_25));
					  highp float tmpvar_28;
					  tmpvar_28 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_25));
					  highp vec3 tmpvar_29;
					  tmpvar_29 = (TOD_k4PI.xyz + TOD_k4PI.w);
					  sunColor_15 = (exp((
					    -((startOffset_18 + (tmpvar_26 * (
					      (0.25 * exp((-0.00287 + (tmpvar_27 * 
					        (0.459 + (tmpvar_27 * (3.83 + (tmpvar_27 * 
					          (-6.8 + (tmpvar_27 * 5.25))
					        ))))
					      ))))
					     - 
					      (0.25 * exp((-0.00287 + (tmpvar_28 * 
					        (0.459 + (tmpvar_28 * (3.83 + (tmpvar_28 * 
					          (-6.8 + (tmpvar_28 * 5.25))
					        ))))
					      ))))
					    ))))
					   * tmpvar_29)) * (tmpvar_26 * scaledLength_17));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp float tmpvar_30;
					  tmpvar_30 = sqrt(dot (samplePoint_16, samplePoint_16));
					  highp float tmpvar_31;
					  tmpvar_31 = (1.0/(tmpvar_30));
					  highp float tmpvar_32;
					  tmpvar_32 = exp((TOD_kScale.z * (TOD_kRadius.x - tmpvar_30)));
					  highp float tmpvar_33;
					  tmpvar_33 = (1.0 - (dot (TOD_LocalSunDirection, samplePoint_16) * tmpvar_31));
					  highp float tmpvar_34;
					  tmpvar_34 = (1.0 - (dot (dir_14, samplePoint_16) * tmpvar_31));
					  sunColor_15 = (sunColor_15 + (exp(
					    (-((startOffset_18 + (tmpvar_32 * 
					      ((0.25 * exp((-0.00287 + 
					        (tmpvar_33 * (0.459 + (tmpvar_33 * (3.83 + 
					          (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25)))
					        ))))
					      ))) - (0.25 * exp((-0.00287 + 
					        (tmpvar_34 * (0.459 + (tmpvar_34 * (3.83 + 
					          (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25)))
					        ))))
					      ))))
					    ))) * tmpvar_29)
					  ) * (tmpvar_32 * scaledLength_17)));
					  samplePoint_16 = (samplePoint_16 + tmpvar_23);
					  highp vec3 resultColor_35;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (TOD_LocalSunDirection, tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = (tmpvar_36 * tmpvar_36);
					  resultColor_35 = ((0.75 + (0.75 * tmpvar_37)) * ((TOD_SunSkyColor * sunColor_15) * TOD_kSun.xyz));
					  resultColor_35 = (resultColor_35 + ((
					    (TOD_kBetaMie.x * (1.0 + tmpvar_37))
					   / 
					    pow ((TOD_kBetaMie.y + (TOD_kBetaMie.z * tmpvar_36)), 1.5)
					  ) * (
					    (TOD_SunSkyColor * sunColor_15)
					   * TOD_kSun.w)));
					  highp vec3 dir_38;
					  dir_38.xz = tmpvar_13.xz;
					  dir_38.y = max (0.0, tmpvar_13.y);
					  resultColor_35 = (resultColor_35 + (TOD_MoonSkyColor * (1.0 - 
					    (0.75 * dir_38.y)
					  )));
					  resultColor_35 = (resultColor_35 + (TOD_MoonHaloColor * pow (
					    max (0.0, dot (tmpvar_13, TOD_LocalMoonDirection))
					  , TOD_MoonHaloPower)));
					  highp vec3 tmpvar_39;
					  tmpvar_39 = mix (resultColor_35, TOD_FogColor, vec3(TOD_Fogginess));
					  resultColor_35 = tmpvar_39;
					  highp vec4 tmpvar_40;
					  tmpvar_40.w = 1.0;
					  tmpvar_40.xyz = pow ((tmpvar_39 * TOD_Brightness), vec3(TOD_Contrast));
					  scattering_1 = tmpvar_40;
					  lowp vec4 tmpvar_41;
					  tmpvar_41 = texture2D (_DitheringTexture, xlv_TEXCOORD2);
					  scattering_1.xyz = (scattering_1.xyz + (tmpvar_41.w * 0.01538462));
					  if ((depth_2 == 1.0)) {
					    color_3.xyz = (color_3.xyz + scattering_1.xyz);
					  } else {
					    highp vec3 tmpvar_42;
					    tmpvar_42 = mix (color_3.xyz, scattering_1.xyz, vec3(depth_2));
					    color_3.xyz = tmpvar_42;
					  };
					  gl_FragData[0] = color_3;
					}
					
					
					#endif"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
					    return;
					}
					#endif"
}
SubProgram "gles3 hw_tier03 " {
Keywords { "TOD_OUTPUT_DITHERING" "TOD_OUTPUT_LINEAR" "TOD_OUTPUT_HDR" }
					"!!GLES3
					#ifdef VERTEX
					#version 300 es
					vec4 ImmCB_0_0_0[4];
					uniform 	vec4 _ScreenParams;
					uniform 	vec4 hlslcc_mtx4glstate_matrix_mvp[4];
					uniform 	vec4 hlslcc_mtx4TOD_World2Sky[4];
					uniform 	vec4 hlslcc_mtx4_FrustumCornersWS[4];
					in highp vec4 in_POSITION0;
					in mediump vec2 in_TEXCOORD0;
					out highp vec2 vs_TEXCOORD0;
					highp  vec4 phase0_Output0_1;
					out highp vec2 vs_TEXCOORD1;
					out highp vec2 vs_TEXCOORD2;
					out highp vec3 vs_TEXCOORD3;
					out highp vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					int u_xlati0;
					vec3 u_xlat1;
					float u_xlat6;
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
					    u_xlat0.xy = in_TEXCOORD0.xy * _ScreenParams.xy;
					    vs_TEXCOORD2.xy = u_xlat0.xy * vec2(0.125, 0.125);
					    u_xlati0 = int(in_POSITION0.z);
					    u_xlat1.x = dot(hlslcc_mtx4_FrustumCornersWS[0], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.y = dot(hlslcc_mtx4_FrustumCornersWS[1], ImmCB_0_0_0[u_xlati0]);
					    u_xlat1.z = dot(hlslcc_mtx4_FrustumCornersWS[2], ImmCB_0_0_0[u_xlati0]);
					    vs_TEXCOORD3.xyz = u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4TOD_World2Sky[1].xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hlslcc_mtx4TOD_World2Sky[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD4.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					vs_TEXCOORD0 = phase0_Output0_1.xy;
					vs_TEXCOORD1 = phase0_Output0_1.zw;
					    return;
					}
					#endif
					#ifdef FRAGMENT
					#version 300 es
					precision highp int;
					uniform 	vec4 _ZBufferParams;
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
					uniform 	vec4 _Density;
					uniform lowp sampler2D _MainTex;
					uniform highp sampler2D _CameraDepthTexture;
					uniform lowp sampler2D _DitheringTexture;
					in highp vec2 vs_TEXCOORD0;
					in highp vec2 vs_TEXCOORD1;
					in highp vec2 vs_TEXCOORD2;
					in highp vec3 vs_TEXCOORD3;
					in highp vec3 vs_TEXCOORD4;
					layout(location = 0) out mediump vec4 SV_Target0;
					vec3 u_xlat0;
					lowp vec4 u_xlat10_0;
					float u_xlat1;
					vec4 u_xlat2;
					lowp float u_xlat10_2;
					bool u_xlatb2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					mediump vec3 u_xlat16_8;
					vec3 u_xlat10;
					float u_xlat11;
					bool u_xlatb11;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat19;
					float u_xlat25;
					float u_xlat28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat30;
					int u_xlati30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					float u_xlat33;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = texture(_CameraDepthTexture, vs_TEXCOORD1.xy).x;
					    u_xlat1 = _ZBufferParams.x * u_xlat1 + _ZBufferParams.y;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat10.xyz = vec3(u_xlat1) * vs_TEXCOORD3.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1!=1.0);
					#else
					    u_xlatb2 = u_xlat1!=1.0;
					#endif
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Density.y;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb28 = !!(0.0<_Density.x);
					#else
					    u_xlatb28 = 0.0<_Density.x;
					#endif
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb11 = !!(0.00999999978<abs(u_xlat10.y));
					#else
					    u_xlatb11 = 0.00999999978<abs(u_xlat10.y);
					#endif
					    u_xlatb28 = u_xlatb28 && u_xlatb11;
					    u_xlat19.x = u_xlat10.y * _Density.x;
					    u_xlat11 = u_xlat19.x * -1.44269502;
					    u_xlat11 = exp2(u_xlat11);
					    u_xlat11 = (-u_xlat11) + 1.0;
					    u_xlat19.x = u_xlat11 / u_xlat19.x;
					    u_xlat19.x = u_xlat19.x * u_xlat10.x;
					    u_xlat10.x = (u_xlatb28) ? u_xlat19.x : u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * _Density.z;
					    u_xlat10.x = min(u_xlat10.x, 10.0);
					    u_xlat10.x = u_xlat10.x * -1.44269502;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1 = (u_xlatb2) ? u_xlat10.x : u_xlat1;
					    u_xlat10.x = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * vs_TEXCOORD4.xyz;
					    u_xlat2.w = max(u_xlat2.y, 0.0);
					    u_xlat10.x = u_xlat1 * TOD_kScale.x;
					    u_xlat3.y = TOD_kRadius.x + TOD_kScale.w;
					    u_xlat19.x = u_xlat2.w * u_xlat2.w;
					    u_xlat19.x = u_xlat19.x * TOD_kRadius.y + TOD_kRadius.w;
					    u_xlat19.x = u_xlat19.x + (-TOD_kRadius.y);
					    u_xlat19.x = sqrt(u_xlat19.x);
					    u_xlat19.x = (-TOD_kRadius.x) * u_xlat2.w + u_xlat19.x;
					    u_xlat19.y = (-TOD_kScale.w) * TOD_kScale.z;
					    u_xlat19.xy = u_xlat19.xy * vec2(0.5, 1.44269502);
					    u_xlat28 = exp2(u_xlat19.y);
					    u_xlat30 = u_xlat2.w * u_xlat3.y;
					    u_xlat30 = u_xlat30 / u_xlat3.y;
					    u_xlat30 = (-u_xlat30) + 1.0;
					    u_xlat4.x = u_xlat30 * 5.25 + -6.80000019;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 3.82999992;
					    u_xlat4.x = u_xlat30 * u_xlat4.x + 0.458999991;
					    u_xlat30 = u_xlat30 * u_xlat4.x + -0.00286999997;
					    u_xlat30 = u_xlat30 * 1.44269502;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat28 = u_xlat28 * u_xlat30;
					    u_xlat10.x = u_xlat10.x * u_xlat19.x;
					    u_xlat4.xyz = u_xlat19.xxx * u_xlat2.xwz;
					    u_xlat3.x = float(0.0);
					    u_xlat3.z = float(0.0);
					    u_xlat3.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + u_xlat3.xyz;
					    u_xlat4.xyz = TOD_k4PI.www + TOD_k4PI.xyz;
					    u_xlat5.xyz = u_xlat3.xyz;
					    u_xlat6.x = float(0.0);
					    u_xlat6.y = float(0.0);
					    u_xlat6.z = float(0.0);
					    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<2 ; u_xlati_loop_1++)
					    {
					        u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat31 = sqrt(u_xlat31);
					        u_xlat32 = float(1.0) / u_xlat31;
					        u_xlat31 = (-u_xlat31) + TOD_kRadius.x;
					        u_xlat31 = u_xlat31 * TOD_kScale.z;
					        u_xlat31 = u_xlat31 * 1.44269502;
					        u_xlat31 = exp2(u_xlat31);
					        u_xlat33 = u_xlat10.x * u_xlat31;
					        u_xlat7.x = dot(u_xlat2.xwz, u_xlat5.xyz);
					        u_xlat16 = dot(TOD_LocalSunDirection.xyz, u_xlat5.xyz);
					        u_xlat16 = (-u_xlat16) * u_xlat32 + 1.0;
					        u_xlat25 = u_xlat16 * 5.25 + -6.80000019;
					        u_xlat25 = u_xlat16 * u_xlat25 + 3.82999992;
					        u_xlat25 = u_xlat16 * u_xlat25 + 0.458999991;
					        u_xlat16 = u_xlat16 * u_xlat25 + -0.00286999997;
					        u_xlat16 = u_xlat16 * 1.44269502;
					        u_xlat16 = exp2(u_xlat16);
					        u_xlat32 = (-u_xlat7.x) * u_xlat32 + 1.0;
					        u_xlat7.x = u_xlat32 * 5.25 + -6.80000019;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 3.82999992;
					        u_xlat7.x = u_xlat32 * u_xlat7.x + 0.458999991;
					        u_xlat32 = u_xlat32 * u_xlat7.x + -0.00286999997;
					        u_xlat32 = u_xlat32 * 1.44269502;
					        u_xlat32 = exp2(u_xlat32);
					        u_xlat32 = u_xlat32 * 0.25;
					        u_xlat32 = u_xlat16 * 0.25 + (-u_xlat32);
					        u_xlat31 = u_xlat31 * u_xlat32;
					        u_xlat31 = u_xlat28 * 0.25 + u_xlat31;
					        u_xlat7.xyz = u_xlat4.xyz * (-vec3(u_xlat31));
					        u_xlat7.xyz = u_xlat7.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					        u_xlat7.xyz = exp2(u_xlat7.xyz);
					        u_xlat6.xyz = u_xlat7.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					        u_xlat5.xyz = u_xlat2.xwz * u_xlat19.xxx + u_xlat5.xyz;
					    }
					    u_xlat10.xyz = u_xlat6.xyz * TOD_SunSkyColor.xyz;
					    u_xlat3.xyz = u_xlat10.xyz * TOD_kSun.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * TOD_kSun.www;
					    u_xlat30 = dot(TOD_LocalSunDirection.xyz, u_xlat2.xyz);
					    u_xlat4.x = u_xlat30 * u_xlat30;
					    u_xlat4.x = u_xlat4.x * 0.75 + 0.75;
					    u_xlat13 = u_xlat30 * u_xlat30 + 1.0;
					    u_xlat13 = u_xlat13 * TOD_kBetaMie.x;
					    u_xlat30 = TOD_kBetaMie.z * u_xlat30 + TOD_kBetaMie.y;
					    u_xlat30 = log2(u_xlat30);
					    u_xlat30 = u_xlat30 * 1.5;
					    u_xlat30 = exp2(u_xlat30);
					    u_xlat30 = u_xlat13 / u_xlat30;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(u_xlat30);
					    u_xlat10.xyz = u_xlat4.xxx * u_xlat3.xyz + u_xlat10.xyz;
					    u_xlat29 = (-u_xlat2.w) * 0.75 + 1.0;
					    u_xlat10.xyz = TOD_MoonSkyColor.xyz * vec3(u_xlat29) + u_xlat10.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, TOD_LocalMoonDirection.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat2.x = u_xlat2.x * TOD_MoonHaloPower;
					    u_xlat2.x = exp2(u_xlat2.x);
					    u_xlat10.xyz = TOD_MoonHaloColor.xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = (-u_xlat10.xyz) + TOD_FogColor.xyz;
					    u_xlat10.xyz = vec3(vec3(TOD_Fogginess, TOD_Fogginess, TOD_Fogginess)) * u_xlat2.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = u_xlat10.xyz * vec3(TOD_Brightness);
					    u_xlat10.xyz = log2(u_xlat10.xyz);
					    u_xlat10.xyz = u_xlat10.xyz * vec3(vec3(TOD_Contrast, TOD_Contrast, TOD_Contrast));
					    u_xlat10.xyz = exp2(u_xlat10.xyz);
					    u_xlat10_2 = texture(_DitheringTexture, vs_TEXCOORD2.xy).w;
					    u_xlat10.xyz = vec3(u_xlat10_2) * vec3(0.0153846154, 0.0153846154, 0.0153846154) + u_xlat10.xyz;
					#ifdef UNITY_ADRENO_ES3
					    u_xlatb2 = !!(u_xlat1==1.0);
					#else
					    u_xlatb2 = u_xlat1==1.0;
					#endif
					    u_xlat16_8.xyz = u_xlat10_0.xyz + u_xlat10.xyz;
					    u_xlat10.xyz = (-u_xlat10_0.xyz) + u_xlat10.xyz;
					    u_xlat0.xyz = vec3(u_xlat1) * u_xlat10.xyz + u_xlat10_0.xyz;
					    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_8.xyz : u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_0.w;
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
}
 }
}
Fallback Off
}