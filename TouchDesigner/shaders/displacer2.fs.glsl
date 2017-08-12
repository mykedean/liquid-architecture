// Liquid Architecture
// Displacer Fragment Shader
// TOP shader for displacing paticles along one axis

uniform vec3 uShiftDir;
uniform vec3 uSliceDir;
uniform float uDelta;
uniform float uReset;
uniform float uThreshold;

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
        // to make it sweep from outside the model bounds
        float x = dot(initialPos, uSliceDir) + 8.0;
        float edge = uThreshold * 8.0;
        // return 1 if x > edge, else 0
        float step = step(edge, x);
        vec3 vel = texture(sTD2DInputs[1], vUV.st).rgb;
        vec3 noise = texture(sTD2DInputs[3], vUV.st).rgb;
        vel -= uShiftDir * abs(noise.x*140.0) * uDelta;
        vel += noise * 0.001 * uDelta;
        pos += vel * uDelta;

        vel = mix(vel, vec3(0.0), step);
        pos = mix(pos, initialPos, step);

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
