// link : https://www.shadertoy.com/view/NfjGDz

#include <flutter/runtime_effect.glsl>

#ifdef GL_ES
precision highp float;
#endif

#define PI 3.14159265359

// Flutter
uniform vec2 uSize;
uniform float iTime;
vec2 iResolution;
out vec4 fragColor;

mat2 rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

vec3 path(float z) {
    float baseRadius = 0.1;
    float radiusVar = 2.0 * sin(z * 0.08 + iTime * 0.5);
    float radius = baseRadius + radiusVar;
    float frequency = 0.1;
    return vec3(
    radius * cos(z * frequency),
    -radius * sin(z * frequency),
    z
    );
}

vec3 palette(float t) {
    vec3 a = vec3(0.3, 0.2, 0.4);
    vec3 b = vec3(0.8, 0.4, 0.6);
    vec3 c = vec3(1.0, 1.2, 1.4);
    vec3 d = vec3(0.2, 0.5, 0.8);
    return a + b * cos(6.28318 * (c * t + d));
}

float flower(vec3 p) {
    float r = length(p.xy);
    float a = atan(p.y, p.x);
    float petalCount = 4.0;
    float petals = sin(a * petalCount + p.z * 0.8) * 0.2;
    float baseR = 5.0;
    return r - (baseR + petals);
}

float ring(vec3 p) {
    float r = length(p.xy);
    float wave = sin(r * 8.0 + p.z * 2.0) * 0.05;
    return abs(r - 2.0) - 3.0 + wave;
}

float mapDist(vec3 p) {
    vec3 c = path(p.z);
    p.xy -= c.xy;
    p.xy *= rot(p.z * 0.2);

    float d1 = flower(p);
    float d2 = ring(p);

    return min(d1, d2) * 0.9;
}

vec3 calcGlow(vec3 p) {
    vec3 c = path(p.z);
    p.xy -= c.xy;
    p.xy *= rot(p.z * 0.2);

    float d2 = ring(p);
    float g2 = exp(-abs(d2) * 4.0);
    vec3 ringCol = palette(p.z * 0.05 + iTime * 0.05);

    return ringCol * g2 * 0.1;
}

vec3 getNormal(vec3 p) {
    float h = 0.01;
    vec2 k = vec2(1, -1);
    return normalize(
    k.xyy * mapDist(p + k.xyy * h) +
    k.yyx * mapDist(p + k.yyx * h) +
    k.yxy * mapDist(p + k.yxy * h) +
    k.xxx * mapDist(p + k.xxx * h)
    );
}

void main(void) {
    iResolution = uSize;
    vec2 fragCoord = FlutterFragCoord();
    fragCoord.y = uSize.y - fragCoord.y;

    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    float time = iTime * 20.0;

    vec3 ro = path(time);
    vec3 target = path(time + 8.0);

    vec3 forward = normalize(target - ro);
    vec3 right = normalize(vec3(forward.z, 0.0, -forward.x));
    vec3 up = cross(right, forward);

    vec3 rd = normalize(forward + uv.x * right + uv.y * up);

    float t = 0.0;
    float d;
    vec3 pSurf;
    const int MAX_STEPS = 100;
    const float MAX_DIST = 200.0;
    float tMax = MAX_DIST;
    bool hit = false;

    for (int i = 0; i < MAX_STEPS; i++) {
        pSurf = ro + rd * t;
        d = mapDist(pSurf);
        if (abs(d) < 0.0005) {
            hit = true;
            tMax = t;
            break;
        }
        if (t > MAX_DIST) break;
        t += d;
    }
    if (!hit) {
        tMax = t;
        pSurf = ro + rd * tMax;
    }

    const int SAMPLE_COUNT = 80;
    float stepSize = tMax / float(SAMPLE_COUNT);
    vec3 col = vec3(0.0);
    vec3 glowAccum = vec3(0.0);

    for (int i = 0; i < SAMPLE_COUNT; i++) {
        float tSample = (float(i) + 0.5) * stepSize;
        vec3 pSample = ro + rd * tSample;
        vec3 g = calcGlow(pSample);
        glowAccum += g;
        col += glowAccum * 0.25;
    }

    vec3 n = getNormal(pSurf);
    float diff = max(dot(n, -rd), 0.0);
    vec3 base = palette(pSurf.z * 0.05) * diff;

    vec3 refDir = reflect(rd, n);
    float fres = pow(1.0 - max(dot(n, -rd), 0.0), 2.0);
    base += vec3(0.8, 0.3, 0.6) * fres * 0.8;

    vec3 finalColor = base + col * 1.2;

    finalColor.r *= 1.2;
    finalColor.b *= 0.8;

    float gray = dot(finalColor, vec3(0.299, 0.587, 0.114));
    float saturationFactor = 0.5;
    finalColor = mix(vec3(gray), finalColor, saturationFactor);

    finalColor = pow(finalColor, vec3(0.85));

    fragColor = vec4(finalColor, 1.0);
}