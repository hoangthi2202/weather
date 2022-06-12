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
Exception handling
- Caching handling
Accessibility for Disability Supports: VoiceOver, Scaling Text
- Entity
