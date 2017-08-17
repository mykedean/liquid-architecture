// Liquid Architecture
// Static (no motion) Fragment Shader
// TOP shader for interpolating values between initial and current

uniform float uDelta;
uniform float uReset;

layout(location = 0) out vec4 outPos;
layout(location = 1) out vec4 outVel;


void reset() {
	vec4 initialPos = texture(sTD2DInputs[2], vUV.st);
	outPos = initialPos;
	outVel = vec4(0.0);
}


void main()
{
	vec3 initialPos = texture(sTD2DInputs[2], vUV.st).rgb;
    vec3 pos = texture(sTD2DInputs[0], vUV.st).rgb;

    if (uReset == 0.0) {
        vec3 vel = texture(sTD2DInputs[1], vUV.st).rgb;

        vel = vel;
        pos = pos;

        outPos = vec4(pos, 1.0);
        outVel = vec4(vel, 1.0);
    } else if (uReset < 1.0) {
        outPos = vec4(pos, 1.0);
        outVel = vec4(0.0);
    } else {
        outPos = vec4(initialPos, 1.0);
        outVel = vec4(0.0);
    }
}