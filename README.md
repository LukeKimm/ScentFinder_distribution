# 향수 최저가 · Scent Price Finder (배포판)

미국·영국·캐나다 해외 향수 할인몰 30곳을 Safari에서 한 번에 검색해 원화 기준 최저가 순으로 보여주는 Safari 확장의 **App Store 배포용** 저장소입니다.

- 개발·테스트: [LukeKimm/ScentFinder](https://github.com/LukeKimm/ScentFinder)
- 출시 순서와 App Store 문구: [docs/APP_STORE.md](docs/APP_STORE.md)
- 개인정보처리방침: [PRIVACY.md](PRIVACY.md)
- 변경 내역: [CHANGELOG.md](CHANGELOG.md)

## 개발판과 다른 점

| 항목 | 개발판 (ScentFinder) | 배포판 (이 저장소) |
|---|---|---|
| 사이트 접근 권한 | 모든 웹사이트 (`<all_urls>`) | 쇼핑몰 30곳 + 환율 API만. 직접 추가한 사이트는 추가할 때 그 사이트만 요청 |
| 숨은 탭 읽기 | 기본 켜짐 | 기본 꺼짐. 고급 설정이나 결과 화면의 버튼으로 켬 |
| 설치용 앱 화면 | Xcode 기본(영어) | 한/영 사용법 화면 (`app-shell/`) |
| 앱 아이콘 | 512px 둥근 아이콘 | 1024px 불투명 원본 (`assets/AppIcon-1024.png`) |
| Xcode 설정 | 기본값 | 버전·빌드 번호, Mac 카테고리(쇼핑), 수출 규정 자동 설정 |

## 빌드

Mac에 Xcode를 설치한 뒤:

```
git clone https://github.com/LukeKimm/ScentFinder_distribution.git
cd ScentFinder_distribution
chmod +x build.sh
./build.sh
```

Xcode에서 4개 타깃의 Team을 유료 개발자 팀으로 지정하고 Product › Archive로 올립니다. 자세한 순서는 [docs/APP_STORE.md](docs/APP_STORE.md)를 보세요.

## 구조

| 경로 | 역할 |
|---|---|
| `extension/` | Safari 웹 확장 (Manifest V3) |
| `extension/manifest.json` | 버전, 권한(쇼핑몰 도메인 목록) |
| `extension/stores.js` | 검색 대상 쇼핑몰. 추가하면 `manifest.json`의 `host_permissions`에도 추가 |
| `app-shell/` | 설치용 앱 화면 (Main.html, Style.css, Script.js, Icon.png) |
| `assets/AppIcon-1024.png` | 앱 아이콘 원본 |
| `build.sh` | Xcode 프로젝트 생성 + 배포용 설정 적용 |
| `docs/APP_STORE.md` | 출시 가이드, App Store 문구, 심사 메모 |
| `PRIVACY.md` | 개인정보처리방침 (App Store Connect에 이 주소 입력) |
