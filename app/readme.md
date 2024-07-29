# commit log

## 2024.07.26 (1.0.0)
- uploaded ver 1.0.0
   
## 2024.07.29 (2.0.0)
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
    
  - 텍스트를 쓸 때, Text(style:TextStyle(~~), ~~)로 적지 말고 TextBlack(string, size, color=AppColors.black)과 같이 적는다.
    
    `TextBlack(string: 'ICE-D', size: 32)`
  
