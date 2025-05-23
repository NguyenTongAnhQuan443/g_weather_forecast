# GOLDEN OWL SOLUTIONS - TEST Intern
## Nguyễn Tống Anh Quân - Email: ntanhquan.sly@gmail.com
## 0) Demo
Hosting URL: https://g-weather-forecast-17f9c.web.app
App APK: [weather_app_demo.apk](weather_app_demo.apk)

## 1) Project Structure

```
lib/
├── bloc/
│   └── weather/
│       ├── weather_bloc.dart
│       ├── weather_event.dart
│       └── weather_state.dart
├── core/
│   ├── config/
│   │   └── api_config.dart
│   └── constants/
│       └── app_styles.dart
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── email_prefs.dart
│   │   │   └── weather_history_service.dart
│   │   └── remote/
│   │       ├── weather_api_service.dart
│   │       └── weather_subscription_api.dart
│   ├── models/
│   │   ├── forecast_day_model.dart
│   │   └── weather_model.dart
│   └── repositories/
│       └── weather_repository.dart
├── view/
│   └── main.dart


```
### 2) Introduce
```
🌦️ Weather App – Flutter Multi-platform Application

Weather App is a modern, cross-platform (mobile & web) Flutter application designed to provide users with comprehensive weather information for any city or their current location.
It features a clean, user-friendly, and responsive interface, ensuring a smooth experience on all devices.

Key Features:

1. Search Weather by City or Current Location
    - Users can enter a city name or use GPS to get weather information for their current position.
    - Displays detailed data: temperature, weather status, wind speed, humidity, and more.

2. Multi-day Weather Forecast
    - View 4-day weather forecasts with individual cards for each day.
    - The forecast layout automatically adapts for both wide (desktop/web) and narrow (mobile) screens.

3. Responsive Design
    - The app automatically adjusts its layout for a consistent, visually appealing experience on any screen size, whether mobile or desktop.

4. Subscribe to Daily Weather Email Notifications
    - Users can enter their email and allow location access to subscribe for daily weather updates delivered every morning at 7 AM.
    - The system sends a confirmation email immediately after successful registration.
    - Users can unsubscribe anytime directly from the app.

5. Local Storage of Subscribed Email
    - The subscribed email is saved locally (using SharedPreferences). Whenever the subscription dialog is opened, the previous email is auto-filled for convenience.

6. Friendly Welcome Notification
    - Upon launching the app, users receive a welcoming notification in English, wishing them a great experience with the app.

7. Weather Search History Management
    - Users can view their search history for weather data during the current day.

8. Intuitive Interface and Smooth Effects
    - Loading indicators, real-time email validation via regex, and clear error messages ensure a seamless user experience.

Technologies Used:

- Flutter: Main framework for multi-platform UI development.
- Dart: Programming language for Flutter.
- Firebase Cloud Messaging / flutter_local_notifications: For push/welcome notifications.
- Geolocator, Geocoding: For GPS and location-to-city name conversion.
- http: For connecting to weather and email subscription APIs.
- SharedPreferences: For local storage.
- Spring Boot (backend): Handles email delivery, stores email/location data, and provides APIs for the app.

Slogan:
“Weather App – Bringing accurate weather and convenient information to every moment of your day!”

```
### 3) Description
```
- Search for a city or country and display weather information:
    - Show the weather includes temperature, wind speed, humidity... for present day.
    - Show forecast 4 days later and more (load more).
- Save temporary weather information history and allow display again during the day.
- There is a function to register and unsubscribe to receive daily weather forecast information via email address. Email confirmation is required.
- Deploy the Flutter Web App to go live. (Firebase Hosting)
- Responsive design (look good on all devices: desktops, tablets & mobile phones).
- Smooth animations

```
```
Language: Flutter
Fonts (optional): https://fonts.google.com/specimen/Rubik?query=Rubik
Store data: Shared Preferences
OOP programming for object-oriented languages
Form validation: True
State management: Bloc

```
### 3) Home Screen - Web Screen
![web_home_srceen.png](assets%2Fdemo%2Fweb_home_srceen.png)
![mobile_home_screen.png](assets%2Fdemo%2Fmobile_home_screen.png)
