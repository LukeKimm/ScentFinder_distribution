# App Store 출시 가이드

이 저장소(ScentFinder_distribution)로 Mac·아이폰 App Store에 올리는 순서입니다. 개발·테스트는 [ScentFinder](https://github.com/LukeKimm/ScentFinder) 저장소에서 하고, 출시할 버전만 이 저장소로 옮깁니다.

## 0. 준비물

| 항목 | 내용 |
|---|---|
| Apple Developer Program | 개인(Individual)으로 가입, 연 99 USD. 이름은 법적 실명(판매자명으로 표시됨), Apple ID 이중 인증 필수 → [가입](https://developer.apple.com/programs/enroll/) |
| 개인정보처리방침 URL | 이 저장소의 `PRIVACY.md`. **저장소가 공개(Public)여야** 심사자가 열 수 있음. 비공개로 둘 거면 같은 내용을 노션 공개 페이지 등에 올리고 그 주소를 사용 |
| 지원 URL | 저장소 Issues 주소 (공개 저장소일 때) 또는 개인정보처리방침과 같은 공개 페이지 |
| 스크린샷 | 아이폰 1179×2556(또는 1206×2622) 세로 1장 이상, Mac 2880×1800 등 16:10 1장 이상 (아래 4번) |

## 1. 프로젝트 만들기

```
git clone https://github.com/LukeKimm/ScentFinder_distribution.git
cd ScentFinder_distribution
chmod +x build.sh
./build.sh                    # 처음 올릴 때 (빌드 번호 1)
BUILD_NUMBER=2 ./build.sh     # 같은 버전을 다시 올릴 때는 빌드 번호를 올림
```

`build.sh`가 아래를 자동으로 해줍니다.
- Mac·iOS 앱과 Safari 확장 프로젝트 생성 (번들 ID `com.taekyungkim.scentfinder`)
- 설치용 앱 화면을 한/영 사용법 화면으로 교체 (심사 기준 4.4)
- 앱 아이콘을 1024px 불투명 원본으로 교체
- 버전(`extension/manifest.json`의 version)·빌드 번호, Mac 카테고리(쇼핑), 수출 규정(표준 암호화만) 설정

다시 만들 때는 `rm -rf xcode` 후 실행합니다.

## 2. 서명 (Xcode)

1. 파란 ScentFinder 프로젝트 아이콘 → TARGETS 4개(iOS 앱·확장, macOS 앱·확장)
2. 각각 Signing & Capabilities › Automatically manage signing 체크 › **Team = 유료 개발자 팀**(Personal Team 아님)
3. 번들 ID 오류가 나면 이미 누가 쓰는 ID → `rm -rf xcode` 후 `./build.sh com.다른이름.scentfinder`

## 3. App Store Connect에 앱 등록

[appstoreconnect.apple.com](https://appstoreconnect.apple.com) › 앱 › **+** › 신규 앱
- 플랫폼: **iOS**, **macOS** 둘 다 체크 (같은 번들 ID라 한 번 사면 둘 다 쓰는 Universal Purchase)
- 이름·기본 언어(한국어)·번들 ID·SKU(예: `scentfinder001`) 입력
- 앱 정보 › 카테고리 **쇼핑**(보조: 유틸리티), 연령 등급 설문 모두 "없음" → 4+
- 가격: 무료
- **앱 개인정보 보호** › "아니요, 이 앱에서 데이터를 수집하지 않습니다" › 게시
- 아래 5번의 문구를 각 버전 페이지(iOS, macOS)에 붙여넣기

## 4. 스크린샷

- 아이폰: 실제 아이폰(Dynamic Island 모델)에서 Safari 확장 검색 결과 화면을 캡처(측면 버튼+볼륨 업) → 1179×2556 또는 1206×2622
- Mac: 확장 검색 화면을 띄우고 창을 16:10에 맞춰 캡처 → 2880×1800(레티나) 또는 1440×900
- 추천 장면: ① 검색 결과와 최저가 카드 ② 종류 필터·용량·정렬 ③ 검색할 사이트 패널 ④ 영어 화면
- 실제 검색 결과를 쓰세요. 가격이 바뀌는 건 문제없지만, 꾸며낸 가격은 쓰지 마세요.

## 5. App Store 문구 (복사해서 사용)

**이름 (30자 이내)**
- 한국어: `향수 최저가 - 해외 향수 가격비교`
- English: `Scent Price Finder`

**부제 (30자 이내)**
- 한국어: `미국·영국 향수 할인몰 한 번에 검색`
- English: `Compare fragrance discounters`

**프로모션 문구**
- 한국어: `해외 향수 할인몰 30곳을 Safari에서 한 번에 검색하고 원화 기준 최저가를 바로 확인하세요.`
- English: `Search 30 fragrance discounters at once in Safari and see the lowest price in Korean won.`

**키워드 (100자 이내, 쉼표 구분, 브랜드·쇼핑몰 이름은 넣지 않음)**
- 한국어: `향수,가격비교,최저가,해외직구,니치향수,테스터,디캔트,샘플,할인,향수쇼핑`
- English: `fragrance,perfume,cologne,price,compare,discount,tester,decant,sample,niche`

**설명 (한국어)**
```
향수 최저가는 미국·영국·캐나다의 해외 향수 할인몰 30곳을 한 번에 검색해, 원화 기준 최저가 순으로 보여주는 Safari 확장 프로그램입니다.

주요 기능
• 해외 향수 할인몰 30곳 동시 검색, 직접 쇼핑몰 추가 가능
• 한글로 브랜드·향수 이름을 입력해도 영어로 자동 변환해서 검색
• 정품 박스 / 테스터 / 언박스 / 미니·샘플·디캔트 / 세트 구분 필터
• 용량별 비교, 원화 최저가·ml당 가격·사이트별 정렬
• 자동 환율 또는 직접 입력한 환율로 원화 환산
• 한국어 / English 화면
• 검색 진행 상황과 사이트별 결과를 한눈에 확인
• 결과를 누르면 해당 쇼핑몰에서 직접 구매

사용 방법
1. 설정 › 앱 › Safari › 확장 프로그램에서 '향수 최저가'를 켜고, 기타 웹사이트를 '허용'으로 바꿉니다. (Mac: Safari 설정 › 확장 프로그램)
2. Safari에서 확장 프로그램 아이콘을 누르고 브랜드와 향수 이름을 검색합니다. (한글·영문 모두 가능)

알아두세요
• 가격은 상품가 기준이며 배송비·관부가세는 포함하지 않습니다.
• 이 앱은 상품을 판매하지 않으며 각 쇼핑몰과 제휴 관계가 없습니다. 가격·재고는 쇼핑몰 사정에 따라 달라질 수 있으니 구매 전 쇼핑몰에서 확인하세요.
• 검색어와 설정은 기기 안에만 저장되며 어떤 개인정보도 수집하지 않습니다.
```

**Description (English)**
```
Scent Price Finder is a Safari extension that searches 30 fragrance discounters in the US, UK and Canada at once and sorts the results by the lowest price in Korean won.

Features
• Search 30 fragrance discounters at once, and add your own stores
• Type brand and fragrance names in Korean or English; Korean names are converted automatically
• Filters for boxed, tester, unboxed, mini/sample/decant and gift sets
• Compare by size; sort by lowest price, price per ml or store
• Live or manually entered exchange rates
• Korean and English interface
• See search progress and per-store results at a glance
• Tap a result to buy directly from that store

How to use
1. Turn on "Scent Price Finder" in Settings › Apps › Safari › Extensions and set Other Websites to "Allow". (Mac: Safari Settings › Extensions)
2. In Safari, open the extension and search by brand and fragrance name.

Good to know
• Prices are item prices only; shipping, duties and taxes are not included.
• This app sells nothing and is not affiliated with any store. Prices and stock can change, so confirm on the store's website before buying.
• Searches and settings stay on your device. No personal data is collected.
```

**심사 메모 (App Review Information › 메모)**
```
This app contains a Safari web extension. No login is required.

How to test:
1. iOS: Settings › Apps › Safari › Extensions › Scent Price Finder → On, Other Websites → Allow.
   macOS: Safari › Settings › Extensions → check Scent Price Finder, then Edit Websites → Allow.
2. In Safari, open the extension (iOS: menu left of the address bar › Extensions; macOS: toolbar icon) and search "Creed Aventus" or "Xerjoff Naxos".
3. Results from multiple stores appear with prices converted to KRW. Tapping a result opens that store's own product page.

The extension only reads public product listings from the stores' websites when the user searches. It does not modify pages, inject ads, or collect data. An optional setting ("Read blocked stores in a background tab", off by default) opens a store's search page in a background tab to read the prices shown and then closes it; it is described in the extension's Advanced settings.
Host permissions are limited to the listed stores and the exchange-rate API; a store added by the user requests permission for that site only.
```

**기타**: 저작권 `2026 Taekyung Kim` · 개인정보처리방침 URL `https://github.com/LukeKimm/ScentFinder_distribution/blob/main/PRIVACY.md`

## 6. 업로드와 심사 제출

1. Xcode 실행 대상 **ScentFinder (iOS)** › **Any iOS Device (arm64)** → Product › **Archive**
2. Organizer › Distribute App › **App Store Connect** › Upload
3. 실행 대상 **ScentFinder (macOS)** › **Any Mac** → Archive → 같은 방법으로 Upload
4. 10~30분 뒤 App Store Connect › TestFlight에 빌드가 보이면, 내부 테스터로 본인을 추가해 아이폰 TestFlight 앱으로 먼저 확인 (7일 재설치 없이 90일 사용)
5. iOS·macOS 버전 페이지 › 빌드 선택 › 심사 정보(연락처, 위 심사 메모) › **심사에 제출**

## 7. 업데이트

1. 개발 저장소(ScentFinder)에서 고치고 테스트
2. `extension/` 폴더를 이 저장소로 옮기고, 이 저장소의 배포용 변경(권한 목록, 숨은 탭 기본 끔, 사이트 추가 시 권한 요청)이 유지되는지 확인. 쇼핑몰을 추가했으면 `manifest.json`의 `host_permissions`에도 추가
3. `manifest.json`의 version 올리기 (예: 1.3.0 → 1.3.1)
4. `rm -rf xcode && ./build.sh` (서명 설정을 유지하려면 대신 `python3 tools/sync_xcode.py`로 새 파일만 등록) → Archive → Upload → App Store Connect에서 새 버전 추가 → 제출

## 8. 심사에서 걸릴 수 있는 부분

| 기준 | 내용 | 이 버전의 대응 |
|---|---|---|
| 4.4.2 | Safari 확장은 필요한 사이트에만 접근 | 쇼핑몰 30곳 + 환율 API만 요청, 직접 추가한 사이트는 그때 개별 요청 |
| 4.4 | 확장을 담은 앱엔 도움말·설정 화면 권장, 확장 설명 명시 | 설치용 앱을 사용법 화면으로 교체, 설명문에 확장임을 명시 |
| 5.2.2 | 제3자 콘텐츠 이용 | 공개된 상품명·가격만 표시하고 구매는 원 사이트로 연결. 거절되면 사유에 맞춰 수정 후 재제출 |
| 2.3 | 정확한 메타데이터 | 스크린샷은 실제 검색 결과 사용 |

거절되면 App Store Connect › 해결 센터의 메시지에 사유가 적혀 있습니다. 고친 뒤 빌드 번호를 올려 다시 제출하면 됩니다.
