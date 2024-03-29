
//
//  wave vertex shader --
//      alters the z position of the vertices
//          using sin wave over time

#version 120

#define SQRT_2 1.41421356237
#define HALF_SQRT_2 0.707106781186548

// variables
varying vec2 texCoordVarying;   // shared texture coords

// from ofApp
uniform float time;             // eg. ofGetElapsedTimef()
uniform float depth;            // scale the waves

void main()
{
    
    // save vertex texture coords
    texCoordVarying = gl_MultiTexCoord0.xy;
    
    // get vertex position
    vec4 pos = gl_Vertex;   // vec4 = x,y,z (and w...)
    
    
    // manipulate depth based on sin wave
    //  wave travels along x

    float dist  = length(vec2(.5f,.5f) - texCoordVarying);
    float distN = dist / HALF_SQRT_2;
    float t     = time * 12.;
    float amp   = 0.1f * pow(1.-distN,2.) * 2.;
    
    float ripple = sin(t - dist * 15.) * amp;
    float drop   = 1.;//sin(t * .01);//1. - fract(t /  * .01);
    
    pos.x += ripple * drop;
    pos.z += ripple * drop;
    pos.y += ripple * drop;
    
    // set vertex screen position
    gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * pos;
    
}
