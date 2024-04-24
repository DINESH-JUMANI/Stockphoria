# Stock Market App

## Introduction
Welcome to our Stock Market Application, built using the Flutter framework and Firebase services. This application provides users with real-time stock market data, portfolio management tools, and insightful analysis news to make informed investment decisions.
This application is designed for both casual investors and experienced traders. It offers a simple and intuitive user interface for tracking stock prices, viewing financial news, managing portfolios, and much more. The use of Flutter ensures a seamless cross-platform experience, while Firebase provides robust backend services for real-time updates, authentication, and data storage.

## Installation Guide

## Prerequisites
- Flutter SDK (Ensure it's installed and set up correctly)
- Firebase CLI
- A Google/Firebase account with a Firebase project setup
- A compatible IDE (e.g., Android Studio, Visual Studio Code)
## Setting Up Flutter Environment
1. Install Flutter SDK
    - Follow the official [Flutter Installation Guide](https://docs.flutter.dev/get-started/install/windows/mobile) to install Flutter on your system.
    - Ensure flutter command is in your system's PATH.
2. Check Flutter Setup
    - Open a terminal and run flutter doctor to check for any missing dependencies or setup issues.
    - Resolve any issues indicated by flutter doctor.
## Setting Up Firebase
1. Install Firebase CLI
    - Follow the Firebase CLI installation guide from [here](https://firebase.google.com/docs/cli#setup) to install and set up the Firebase CLI.
    - Run firebase login to log in to your Firebase account.
2. Configure Firebase Project
    - Ensure you have access to the Firebase project associated with this Flutter project.
    - Download the google-services.json file for Android (if applicable) from the Firebase Console (Project Settings > General > Your apps).
    - Download the GoogleService-Info.plist file for iOS (if applicable) from the same place.
## Cloning and Setting Up the Flutter Project
1. Clone the Repository
    - Clone the project's repository to your local system.
    - git clone https://github.com/DINESH-JUMANI/Stockphoria.git
2. Move Firebase Config Files
    - Place google-services.json in the android/app/ directory.
    - Place GoogleService-Info.plist in the ios/Runner/ directory.
3. Get Flutter Packages
    - Navigate to the root of the Flutter project.
    - Run flutter pub get to fetch all the required packages.
    ```base
    flutter pub get
    ```
## Running the Project
1. Running on Android
    - Connect an Android device or start an Android emulator.
    - Run flutter run to launch the project on the connected Android device/emulator.
2. Running on iOS
    - Ensure you have a macOS system with Xcode installed.
    - Open the ios/Runner.xcworkspace in Xcode to set up necessary configurations (e.g., signing, deployment target).
    - Connect an iOS device or start an iOS simulator.
     - Run flutter run to launch the project on the connected iOS device/simulator.
## Troubleshooting
- If you encounter issues, use flutter doctor and flutter run -v for verbose output.
- Check the console for Firebase-related errors or warnings.
- Refer to the Flutter Documentation and Firebase Documentation for additional guidance.
## Documentation
- All the Screenshots [here](https://drive.google.com/drive/folders/1uY5rBO21E2Zg1ddJOZ5JWijEK5xinjLu?usp=drive_link)
- Demo Video [here](https://drive.google.com/file/d/1-su9yaFUdFmhpjmPrDqoBub1ifLGS0cY/view?usp=drive_link)
- SRS Document [here]()
- Presentation [here](https://docs.google.com/presentation/d/1QvVZhqU2fujT4D0pQDXO9-JbWpWS8MJ2/edit?usp=drive_link&ouid=101255765293565024714&rtpof=true&sd=true)
