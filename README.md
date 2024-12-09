# code_challenge

Code Challenge project (please use the dev branch).

## Getting Started

This Flutter application demonstrates the use of the MVVM (Model-View-ViewModel) architecture pattern along with the Repository pattern to implement a dropdown selection for countries and states. This structure helps maintain a clean and manageable codebase by separating concerns and ensuring scalability.

## Table of Contents

<!-- toc -->
- Architecture (MVVM with Bloc)
    - Presentation (View) Layer 
    - ViewModel (Business logic) Layer
    - Repository Layer
    - Model Layer
- Running the App
- Testing
<!-- tocstop -->

## Architecture
The application is divided into four main layers: Presentation, ViewModel, Repository, and Model. This structure helps maintain a clean and manageable codebase by separating concerns.

## Presentation Layer
This layer includes the UI components and widgets that users interact with. The main components of the presentation layer in this application are:

   - Main Entry Point: The main.dart file serves as the entry point of the application.
   - ChallengeApp: The main widget that sets up the home screen.
   - CountryStateDropdownView: This widget contains the dropdowns for selecting a country and a state.

## ViewModel Layer
This layer manages the state of the application and contains the business logic. The ViewModel layer includes:

   - Events: Actions that can be performed (e.g., LoadCountries, CountrySelected, StateSelected).
   - State: Represents the state of the UI (e.g., CountryStatesState).
   - ViewModel: Contains the logic to handle events and update the state (CountryStateViewModel).

## Repository Layer
The repository layer, with the CountryRepository at its heart, manages data interactions. Integrating our API service partner here enables future enhancements like offline mode and new data source integration.

## Model Layer
This layer includes the data models used in the application. The main models are Country and States.

## Running the App

To run the app, follow these steps:

  1. Clone the repository: git clone https://github.com/yourusername/challenge_app.git 
  2. Install dependencies: flutter pub get
  3. Run the app:  flutter run

## Testing

To run the tests, use the following command:

 1 flutter test

## To-Do:

Robustness:
  - Thorough error handling
  - Offline mode support
  - Permission handling
  - Enhancements:
  - Evaluate state management libraries (Provider, Riverpod, etc.)
  - App theming and dark mode support
  - Multi-language support

## Conclusion

This documentation provides an overview of the architecture and chosen approach for the Challenge App. By following the MVVM architecture and repository pattern, we achieve a clean separation of concerns, enhanced testability, and reusability of components. The detailed structure and steps provided here should help in understanding and maintaining the application efficiently.

  
