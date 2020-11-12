# altMoodle

[Current Progress/Roadmap](https://github.com/phibr0/altMoodle/projects/1)

altMoodle is a alternative mobile Client for the Moodle and Logineo LMS. It's specially designed for ease of use and simplicity. 

## Installation

For now you need to build the App by yourself. You can choose between the branches `main` and `dev`. `dev` gives you the latest features, but might be unstable.


Once the App is stable (enough) i will publish it on Google Play and maybe even in the App Store.

For building the App you will need to install the Flutter SDK. After that clone the Repository and run the following command:

```zsh
flutter build apk
```

## Usage

On the first launch the App will open a prompt in which you will have to type in the URL of the Moodle Instance, your username and your password. Everything (including your credentials) will be stored **on device**, but everything is encrypted using AES256.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
