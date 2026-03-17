# shader_study

This is a project that covers multiple shaders using GLSL in Flutter.

---
- [Creating Custom Shaders in Flutter: A Step-by-Step Guide](https://medium.com/flutter-community/creating-custom-shaders-in-flutter-a-step-by-step-guide-49ec86bec20d)

# 기초 개념
### Shader
3D 씬을 랜더링할 때, 적절한 수준의 조도와 색상을 계산하는 컴퓨터 프로그램이자 그 과정

### GLSL
Shader가 사용하는 언어.
- GLSL = OpenGL Shading Language
- High-level language. GPU를 프로그래밍하기 위함.
- 커스텀 Visual Effects & rendering에 사용.
- C와 유사
- 리얼타임 환경에서 동작하도록 설계됨. (비디오 게임, 애니메이션)

### Shader는 랜더링 어느 타이밍에 적용되는 건가?
(추후 작성)

---
# Flutter에 적용하기
1. 공통으로 사용 가능한 GLSL 코드를 작성합니다.
    - 아니면 [shadertoy](https://www.shadertoy.com/) 에서 가져와도 됩니다.
2. 가져온 코드를 아래와 같이 수정합니다.
    - flutter runtime import (`runtime_effect.glsl`)
    - 4개의 parameter 추가 (`uSize`, `iTime`, `iResolution`, `fragColor`)
        - `uSize` : Flutter에서 전달받은 상수값. 랜더링할 Object의 크기.
        - `iTime` : Flutter에서 전달받은 상수값. 셰이더 시작 이후 경과한 시간.
          (shader에서 visual effects를 애니메이션할 때 사용)
        - `iResolution` : 화면 해상도. 랜더링되는 객체의 크기/위치 조정에 사용.
        - `fragColor` : 랜더링된 객체의 최종 색상.
          (이 값은 CPU로 전달되고, 이후 화면에 표시될 때 사용함.)
    - `main` 함수를 선언하고, 안에 2줄의 코드를 최상단에 넣습니다.
```c
#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;
vec2 iResolution;

out vec4 fragColor;

void main(void) {
	iResolution = uSize;
	vec2 fragCoord = FlutterFragCoord();
	// fragCoord.y = uSize.y - fragCoord.y;
	
	// 기존 코드 삽입
}
```
3. 위에서 만든 `.frag` 확장자의 파일을 `pubspec.yaml`에 선언합니다.
```yaml
flutter:
	shaders:
		- shaders/shader.frag
```
4. `CustomPainter`를 상속받은 `ShaderPainter`를 이용해 dart 코드를 작성합니다.
```dart
class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  ShaderPainter(FragmentShader fragmentShader, this.time)
      : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);
    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
```
5. `.frag` 파일을 읽고, 이를 Shader로 실행할 `StatefulWidget`을 작성합니다.
```dart
class ShaderHomePage extends StatefulWidget {
  const ShaderHomePage({super.key});

  @override
  State<ShaderHomePage> createState() => _ShaderHomePageState();
}

class _ShaderHomePageState extends State<ShaderHomePage> {
  late Timer timer;
  double delta = 0;
  FragmentShader? shader;

  void loadMyShader() async {
    var program = await FragmentProgram.fromAsset('shaders/shader.frag');
    shader = program.fragmentShader();
    setState(() {
      // trigger a repaint
    });

    timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        delta += 1 / 60;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadMyShader();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shader == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return CustomPaint(painter: ShaderPainter(shader!, delta));
    }
  }
}
```