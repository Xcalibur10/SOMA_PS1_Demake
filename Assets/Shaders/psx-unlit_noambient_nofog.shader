﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "psx/unlit_noambient_nofog" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" "Queue" = "Background" }
		LOD 200
		ZWrite Off

		Pass{
		CGPROGRAM

#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

	struct v2f
	{
		fixed4 pos : SV_POSITION;
		half4 color : COLOR0;
		float2 uv_MainTex : TEXCOORD0;
		half3 normal : TEXCOORD1;
	}; 

	float4 _MainTex_ST;
	uniform half4 unity_FogStart;
	uniform half4 unity_FogEnd;

	v2f vert(appdata_full v)
	{
		v2f o;

		//Vertex snapping
		float4 snapToPixel = UnityObjectToClipPos(v.vertex);
		float4 vertex = snapToPixel;
		vertex.xyz = snapToPixel.xyz / snapToPixel.w;
		vertex.x = floor(160 * vertex.x) / 160;
		vertex.y = floor(120 * vertex.y) / 120;
		vertex.xyz *= snapToPixel.w;
		o.pos = vertex;

		//Vertex lighting 
		o.color = v.color;

		float distance = length(mul(UNITY_MATRIX_MV,v.vertex));

		//Affine Texture Mapping
		float4 affinePos = vertex;//vertex;				
		o.uv_MainTex = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.uv_MainTex *= distance + (vertex.w*(UNITY_LIGHTMODEL_AMBIENT.a * 8)) / distance / 2;
		o.normal = distance + (vertex.w*(UNITY_LIGHTMODEL_AMBIENT.a * 8)) / distance / 2;


		return o;
	}

	sampler2D _MainTex;

	float4 frag(v2f IN) : COLOR
	{
		half4 c = tex2D(_MainTex, IN.uv_MainTex / IN.normal.r)*IN.color;
		half4 color = c;
		return color;
	}
		ENDCG
	}
	}
}