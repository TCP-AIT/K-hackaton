# commit log

## 2024.07.26 (1.0.0)
- uploaded ver 1.0.0
   
## 2024.07.29 (2.0.0, 김은주)
- main.dart [app bar, bottom navigation bar 완]
- widgets > bar_widgets.dart [app bar, bottom nav bar 파일 분리 완]
- theme.dart [색깔, 폰트, 아이콘 파일 경로 완]
- screens > [스크린 페이지들 파일 생성만 완(페이지 컨트롤 경로 지정을 위함)]

  **theme.dart 사용법**
  - 색깔을 쓸 때, Colors(0xff~~)로 적지 말고 AppColors.mainColor 와 같이 적는다.
    
    ```
    backgroundColor: AppColors.white,
    unselectedItemColor: AppColors.black,
    selectedItemColor: AppColors.mainColor,
    ```
    
  - 텍스트를 쓸 때, Text(style:TextStyle(~), ~)로 적지 말고 TextBlack(string, size, color=AppColors.black)과 같이 적는다.
    
    ```
    TextBlack(string: 'ICE-D', size: 32),
    TextMedium(string: '배고프다',size: 20)
    ```

## 2024.07.30 (2.0.1, 류승우)
- 

## 2024.08.04 (2.0.1, 김은주)
- alcohol_timer_page 중 alcohol_timer_form 부분을 99% 완성함.
- 기존 figma 디자인 그대로 가되 마신 양 부분을 병, 잔 등의 단위 말고 ml 단위로 직접 입력할 수 있게 수정함. -> cal_alcohol 알코올 계산 부분 코드의 편의성 + 만일 사용자가 직접 ml를 입력하고 싶을 때 form 부분 ui가 바뀌어야 하기에 (ml로 입력하고 싶다, 라는 걸 입력 받기도 현 ui에서는 애매해짐) 그냥 사용자가 마신 양을 ml 단위로 입력하도록 바꿈.
- 추후 추가 보완할 사항은 아래와 같음.
    **alcohol_timer_form**
    - [ ] _drinks 선택에 따라 _defaultAlcohol이 initial value에 보이게
    - [ ] errorMsg 띄우는 건 버튼 눌렀을 때에만 보이게
    **alcohol_timer_form_field**
    - [ ] local save 기능을 활용하여 성별과 몸무게는 기존에 저장된 값으로 initial value가 보이게
    - [ ] FormFieldDropDown text vertical center