#!/bin/bash
# 향수 최저가 — App Store 배포용 Xcode 프로젝트 생성
#
# 사용법:
#   ./build.sh                                  번들 ID com.taekyungkim.scentfinder, 빌드 번호 1
#   ./build.sh com.example.scentfinder          번들 ID 지정
#   BUILD_NUMBER=3 ./build.sh                   빌드 번호 지정 (App Store 에 다시 올릴 때마다 +1)
#   NO_OPEN=1 ./build.sh                        끝나고 Xcode 를 열지 않음
#
# 하는 일:
#   1) Apple 변환 도구로 Mac·iOS 앱 + Safari 확장 프로젝트 생성 (xcode/ScentFinder)
#   2) 설치용 앱 화면을 한/영 사용법 화면(app-shell/)으로 교체
#   3) 앱 아이콘을 1024px 불투명 원본(assets/AppIcon-1024.png)으로 교체
#   4) 버전(manifest.json)·빌드 번호, Mac 카테고리(쇼핑), 수출 규정(표준 암호화만) 설정
set -e
cd "$(dirname "$0")"

if ! xcrun --find safari-web-extension-converter >/dev/null 2>&1; then
  echo "Xcode가 필요합니다. App Store에서 Xcode 설치 후 한 번 실행해 주세요."
  exit 1
fi

BUNDLE_ID="${1:-com.taekyungkim.scentfinder}"
BUILD_NUMBER="${BUILD_NUMBER:-1}"
VERSION=$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' extension/manifest.json | head -1)
PROJ_DIR="xcode/ScentFinder"

if [ -d "$PROJ_DIR" ]; then
  echo "이미 $PROJ_DIR 가 있습니다. 새로 만들려면 먼저 지우세요:  rm -rf xcode"
  exit 1
fi

xcrun safari-web-extension-converter ./extension \
  --project-location ./xcode \
  --app-name "ScentFinder" \
  --bundle-identifier "$BUNDLE_ID" \
  --swift \
  --no-prompt \
  --no-open

SHARED="$PROJ_DIR/Shared (App)"
PBX="$PROJ_DIR/ScentFinder.xcodeproj/project.pbxproj"

# 2) 설치용 앱 화면
cp app-shell/Main.html "$SHARED/Resources/Base.lproj/Main.html"
cp app-shell/Style.css app-shell/Script.js app-shell/Icon.png "$SHARED/Resources/"
# 템플릿은 iOS 에서 스크롤을 막아둠 → 사용법 화면이 길어서 스크롤 허용
sed -i '' 's/scrollView.isScrollEnabled = false/scrollView.isScrollEnabled = true/' "$SHARED/ViewController.swift"

# 3) 앱 아이콘 (각 크기로 다시 만들어 덮어씀)
for f in "$SHARED/Assets.xcassets/AppIcon.appiconset/"*.png; do
  w=$(sips -g pixelWidth "$f" | awk '/pixelWidth/ {print $2}')
  sips -s format png -z "$w" "$w" assets/AppIcon-1024.png --out "$f" >/dev/null
done

# 4) 버전·빌드 번호
sed -i '' "s/MARKETING_VERSION = [^;]*;/MARKETING_VERSION = $VERSION;/g" "$PBX"
sed -i '' "s/CURRENT_PROJECT_VERSION = [^;]*;/CURRENT_PROJECT_VERSION = $BUILD_NUMBER;/g" "$PBX"
# Mac App Store 는 카테고리가 꼭 있어야 함. HTTPS 외 암호화를 쓰지 않으므로 수출 규정 질문 생략
sed -i '' "s/INFOPLIST_KEY_LSApplicationCategoryType = [^;]*;//g" "$PBX"
for plist in "$PROJ_DIR/macOS (App)/Info.plist" "$PROJ_DIR/iOS (App)/Info.plist"; do
  /usr/libexec/PlistBuddy -c "Delete :ITSAppUsesNonExemptEncryption" "$plist" 2>/dev/null || true
  /usr/libexec/PlistBuddy -c "Add :ITSAppUsesNonExemptEncryption bool false" "$plist"
done
/usr/libexec/PlistBuddy -c "Delete :LSApplicationCategoryType" "$PROJ_DIR/macOS (App)/Info.plist" 2>/dev/null || true
/usr/libexec/PlistBuddy -c "Add :LSApplicationCategoryType string public.app-category.shopping" "$PROJ_DIR/macOS (App)/Info.plist"

echo ""
echo "✅ 배포용 프로젝트 생성 완료"
echo "   번들 ID: $BUNDLE_ID   버전: $VERSION ($BUILD_NUMBER)"
echo "   다음 단계: Xcode 에서 4개 타깃의 Team 을 유료 개발자 팀으로 지정 → Product › Archive (docs/APP_STORE.md)"
[ -z "$NO_OPEN" ] && open "$PROJ_DIR/ScentFinder.xcodeproj" || true
