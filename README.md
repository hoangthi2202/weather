# weather

## Overview

- I built this application base on VIPER pattern and apply clean architecture.
- By using some other patterns (DI, Repository, Observable), the app will more clean, easy to write unit test, maintain later.

## Design patterns

- VIPER
- DI
- Repository
- Observer
- Delegation

## Folder structure

- PresentationLayer: Presenter, view, view controller, interactor, wireframe. This layer depends on DomainLayer.
- DomainLayer: usecases, domain objects, repository interfaces. This layer no dependencies to other layers.
- DataLayer: repository implementations, data source, entities. This layer depends on DomainLayer.
- DI: use Swinject framework to implement DI pattern.
- Utilities: define WLog to manage application's log.

## Frameworks

- Apple's framework: Combine
- Third party frameworks: 
        Swinject (use for DI) through SPM
        SDWebImage for cache image

## Required steps in order to get the application run on local computer

- Need the internet connection to install SPM and load data from server.

## 4. Outputs checklist

- [x] Design app's architecture: VIPER
- [x] UI should be looks like in attachment
- [x] UnitTests
- [x] Acceptance Tests
- [x] Exception handling
- [x] Caching handling
- [x] Accessibility for Disability Supports: VoiceOver, Scaling Text
- [x] Entity relationship diagram for the database and solution diagrams for the components, infrastructure design if any

## Functions

- [x] The application is a simple iOS application which is written by Swift.
- [x] The application is able to retrieve the weather information from OpenWeatherMaps API.
- [x] The application is able to allow user to input the searching term.
- [x] The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.
- [x] The application is able to render the searched results as a list of weather items.
- [x] The application is able to support caching mechanism so as to prevent the app from generating a bunch of API requests.
- [x] The application is able to manage caching mechanism & lifecycle.
- [x] The application is able to load the weather icons remotely and displayed on every weather item at the right-hand-side.
- [x] The application is able to handle failures.
- [x] The application is able to support the disability to scale large text for who can't see the text clearly.
- [x] The application is able to support the disability to read out the text using VoiceOver controls.

## Requirements

- iOS 13+
- Xcode 13.2+
