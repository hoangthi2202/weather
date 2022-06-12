# weather
1. Design patterns
i built this app base on VIPER pattern and apply some other patterns (DI, Repository, Observable) to more clean, easy to write unit test, maintain later.

2. Folder structure & Frameworks
i built the structure with 3 layers (Presentation layer, Domain layer, Data layer)
Presentation layer: Presenter, view, view controller, interactor, wireframe, this layer depends on domain layer
Domain layer: usecase, domain objects, repository interfaces. This layer no dependencies to other layers.
Data layer: repository implementations, data source, entities. This layer depends on domain layer

Frameworks's Apple: Combine
Third party frameworks: 
        Swinject (use for DI) through SPM
        SDWebImage for cache image

3. Required steps in order to get the application run on local computer
Need the internet connection to install SPM and load data from server
4. Feature checklist
- Design app's architecture: VIPER
- UI should be looks like in attachment
UnitTests
Acceptance Tests
- Exception handling
- Caching handling
Accessibility for Disability Supports: VoiceOver, Scaling Text
- Entity
5. Requirements
- 1. The application is a simple iOS application which is written by Swift.
- 2. The application is able to retrieve the weather information from OpenWeatherMaps API.
- 3. The application is able to allow user to input the searching term.
- 4. The application is able to proceed searching with a condition of the search term length must be from 3 characters or above.
- 5. The application is able to render the searched results as a list of weather items.
- 6. The application is able to support caching mechanism so as to prevent the app from generating a bunch of API requests.
- 7. The application is able to manage caching mechanism & lifecycle.
8. The application is able to load the weather icons remotely and displayed on every weather item at the right-hand-side.
- 9. The application is able to handle failures.
10.The application is able to support the disability to scale large text for who can't see the text clearly.
11.The application is able to support the disability to read out the text using VoiceOver controls.
