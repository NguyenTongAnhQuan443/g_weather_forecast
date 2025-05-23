# GOLDEN OWL SOLUTIONS - TEST Intern
## Project Structure

```
lib/
│
├── core/                  
│   ├── constants/         # Hằng số (API key, base URL, colors...)
│   ├── theme/             # Định nghĩa theme, font, app style
│   ├── utils/             # Tiện ích dùng chung (date, string...)
│   └── base/              # Base class (BaseViewModel, ...)
│
├── data/
│   ├── models/            # Định nghĩa model (Weather, User, Forecast, ...)
│   ├── datasources/       
│   │   ├── remote/        # Gọi API (WeatherApiService, AuthService...)
│   │   └── local/         # Lưu local (SharedPreferences, History...)
│   └── repositories/      # Repository pattern (WeatherRepository, UserRepository...)
│
├── domain/                # Tầng này có thể dùng nếu muốn clean arch sâu hơn
│   ├── entities/
│   └── usecases/          # GetWeather, RegisterEmail...
│
├── view/
│   ├── screens/           # Mỗi màn hình là 1 folder riêng
│   │   ├── home/          # Trang chính (search, display weather, forecast)
│   │   ├── auth/          # Đăng ký email, xác thực
│   │   ├── history/       # Hiển thị lịch sử tìm kiếm
│   │   └── splash/        # Logo intro, loading
│   └── widgets/           # Các widget dùng chung (WeatherCard, SearchBar, ...)
│
├── viewmodels/            # Các ViewModel (Home, Auth, History...)
│   ├── home_viewmodel.dart
│   ├── auth_viewmodel.dart
│   └── history_viewmodel.dart
│
├── services/              # Service dùng chung (API, Email, Storage, Notification...)
│   ├── api_service.dart
│   ├── email_service.dart
│   └── storage_service.dart
│
├── main.dart              # Entry point
├── injection.dart         # Inject các service, repository, viewmodel (get_it)
└── app.dart               # Widget MaterialApp, set up theme/font/provider
```
### Home Screen - Web Screen
![mobile_home_screen.png](assets%2Fdemo%2Fmobile_home_screen.png)
![web_home_srceen.png](assets%2Fdemo%2Fweb_home_srceen.png)