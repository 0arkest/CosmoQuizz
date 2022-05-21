# CosmoQuizz
CosmoQuizz is a web app that provides kids with a controlled distraction (game) and motivates them to focus on their tests. We aim to help kids develop focus and emotional control, deal with frustration, and succeed in their academic goals.

Developed and supported by Robbie Cha and Wei Chen.

Project Status: MVP Demo

## About
### Product Vision
FOR kids who are having trouble paying attention, controlling impulsive behaviors, or being overly active WHO need to stay on track with their academic goals, CosmoQuizz is a web app THAT provides kids with a controlled distraction (game) and motivates them to focus on their tests UNLIKE other educational apps, OUR PRODUCT provides a pomodoro timer and evokes kids' learning interests by implementing mini-games during the tests.

### How to Run Locally
1. Clone repository
2. CD into cosmoquizz
3. Run command "flutter pub get"
4. Run command "flutter run -d chrome"

Flutter has to be installed on your computer.

### Technology Stack
* Frontend: Flutter/Dart
* Backend: Python
* Database: Firebase (noSQL)
* Platform: Multi-platform (mobile, web, desktop, and embedded devices)
* API Hosting: Heroku
* FrontEnd Hosting: Github Pages
* Game Engine: Flame

### Deployed Website
https://rchc44.github.io/cosmoquizz_web/#/

Known Issues:
1. Since Heroku set a limit on free access, pages that required API connections would load more slowly. Wait patiently.

~~2. As student, the timeout pop-out window still appears even if you have already submitted the quiz. Click anywhere outside the pop-out window to ignore the timeout message.~~ The bug that appeared in the recording has been fixed.
