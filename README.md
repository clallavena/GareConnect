# gare_connect

Connect the "Gare"s of France

## Contribute
### To contribute and/or run the project in local

First create a account (free), you'll have to ask it here: https://numerique.sncf.com/startup/api/token-developpeur/.

Then create an '.env' file to your project, either in lib or in root folder of the project.
Here you can put and key/value for your API key and your password, PLEASE CHECK IT IS NOT IN YOUR COMMIT FILE.

By default, the KEY associate to those is defined in the `api_constants.dart` as API_USERNAME and API_PASSWORD.
Feel free to change it as you prefer but don't forget to change it also in the constants file also. Make sure you don't push it neither.

You'll have to change also the path (if necessary) in the 'assets' part of the `pubspec.yaml`

The project use https://pub.dev/packages/flutter_dotenv to manage env file in the project. Check documentation for more information.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
