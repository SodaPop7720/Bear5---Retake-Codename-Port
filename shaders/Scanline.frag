#pragma header

#define PI 3.17

uniform float scanLineCount;

vec2 uvCurve(vec2 uv){
	uv=(uv-0.5)*2.0;
	uv.x*=1.0+pow(abs(uv.y)/3.0,2.0);
	uv.y*=1.0+pow(abs(uv.x)/3.5,2.0);
	uv/=1.2;
	uv=(uv/2.0)+0.5;
	return uv;
}

void main(){
    vec2 curve=uvCurve(openfl_TextureCoordv);
	vec4 color=flixel_texture2D(bitmap, curve);

	float s=sin(curve.y*scanLineCount*PI*2.0);
	s=(s*0.5+0.5)*0.9+0.1;

	vec4 scanLine=vec4(vec3(pow(s,0.25)),1.0);

	gl_FragColor=color*scanLine;
}