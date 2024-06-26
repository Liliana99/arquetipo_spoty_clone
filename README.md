# Marialijideveloper Flutter App Archetype

## Table of Contents

- [Features](#features)
- [Installation & Configuration](#installation)
  - [Quick Start](#quick-start)
- [Tips](#tips)

## <a name="features"></a>Features

- Flutter
- translations
- Bloc
- Login + Home with button menu component
- User service
- Authentication bloc for autologin
- Test (Unit test)- Coverage Test


  ![](res/images/covertest.png)
  
  ![](res/images/spoty_clone.png)
  
## <a name="installation"></a>Installation & Configuration

### <a name="quick-start"></a>Quick Start

```bash

# Clone the repo --depth 1 removes all but one .git commit history
git clone --depth 1 repoURL

# Change directory
cd arquetipo-flutter_bloc

# Install project dependencies
pub get

# Launch flutter
flutter pub run build_runner build
flutter run
```

# Environments
for dev: flutter run --dart-define=ENVIRONMENT=DEV or flutter run
for prod: flutter run --dart-define=ENVIRONMENT=PROD

## <a name="tips"></a>Tips

###If you want to watch the coverage report install:

**Installing in Linux:**

sudo apt-get update -qq -y
sudo apt-get install lcov -y

**Installing in Mac:**

brew install lcov

**Installing in Windows:**
https://stackoverflow.com/questions/62184806/how-to-view-code-coverage-as-html-in-windows/62185248#62185248

Run tests, generate coverage files and convert to HTML

flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

###Respect the message convention for the commits:
http://karma-runner.github.io/6.1/dev/git-commit-msg.html

## <a name="information"></a>Information
https://www.marialijideveloper.com/
