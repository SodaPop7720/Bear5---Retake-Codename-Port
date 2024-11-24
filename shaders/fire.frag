[gd_resource type="ShaderMaterial" load_steps=5 format=2]

[ext_resource path="res://assets/images/BEAR/bgs/finale/fireMask.jpg" type="Texture" id=1]

[sub_resource type="Shader" id=7]
code = "shader_type canvas_item;

uniform sampler2D mask;
uniform sampler2D pallete;
uniform float cutoff;

void fragment(){
	float tex1=texture(TEXTURE,UV+(TIME*vec2(-0.05,-0.6))).r;
	float tex2=texture(TEXTURE,UV+(TIME*vec2(0.12,-0.4))).r;
	float energy=tex1*tex2-(cutoff*UV.y);
	vec4 color=texture(pallete,vec2(energy));
	COLOR=color;
	
}"

[sub_resource type="Gradient" id=8]
resource_local_to_scene = true
offsets = PoolRealArray( 0, 0.00404858, 0.0931174, 0.206478, 0.481781, 0.91498, 1 )
colors = PoolColorArray( 0, 0, 0, 0, 0, 0, 0, 0.761905, 1, 0, 0, 0.909524, 1, 0.744141, 0, 1, 1, 0.632813, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1 )

[sub_resource type="GradientTexture" id=9]
gradient = SubResource( 8 )

[resource]
resource_local_to_scene = true
shader = SubResource( 7 )
shader_param/cutoff = 0.3
shader_param/mask = ExtResource( 1 )
shader_param/pallete = SubResource( 9 )
