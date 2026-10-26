//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 pixel;
uniform float alpha;

float round(float);
float signum;
float num2;

vec4 new_color;

void main()
{
    vec2 ts = vec2(pixel.z*(1./pixel.x),pixel.w*(1./pixel.y));
    vec2 coord = vec2(ts.x*round(v_vTexcoord.x/ts.x),ts.y*round(v_vTexcoord.y/ts.y));
    new_color = vec4(v_vColour.rgb,alpha);
    gl_FragColor = new_color * texture2D( gm_BaseTexture, coord );
}
float round(float num){
    signum = sign(num);
    num = abs(num);
    num2 = fract(num);
    num = floor(num);
    num2 = ceil((sign(num2-0.5)+1.0)*0.5);
    return (num+num2)*signum;

}

