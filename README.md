# Weather App
Mobile Weather Application written in flutter dart, using API callings for forecast information, current time, sunset and sunrise time at a specific location.

Functionalities being used:

- Dependencies:
  - http: ^0.13.4 (for API request)
  - url_launcher: ^6.1.2 (used in CV tab)
  - cupertino_icons: ^1.0.2 
- API:
  -  https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0
      - returns a list of forecast information every three hours at some specific location
  -  https://api.sunrise-sunset.org/json?lat=23.1&lng=113.2&formatted=0 
      - returns sunset and sunrise times at a specific location
  -  http://ip-api.com/json/
      - returns current time at a specific location based on the ip of the user

Every tab background and future forecast icons are responsive with respect to the current time and forecast at the specific location. 

What would be next:
- Giving the user the possibility to add a new city
- Adding a more accurate forecast and more background possibilities (example: sunset image, sunrise image, etc.)
