<h1 align="center">Ticketmaster</h1>
<h3 align="center">Mobile iOS App for discovering events with the Ticketmaster API</h3>

This iOS app enables users to discover and explore events in Poland with detailed information, real-time updates, and a seamless user experience. Built using modern iOS development techniques, it uses **async/await** for smooth asynchronous operations and follows the **MVVM** architecture to maintain a clean, modular codebase. The user interface is designed to adapt beautifully to various screen sizes and supports both **light and dark mode** for a consistent experience across devices. Additionally, a **skeleton loading** effect enhances the user experience while data is loading. The app includes error handling and a splash screen for a perfect user experience. The app requires iOS 16 or later and includes extensive unit tests to ensure stability and prevent regressions. The code follows clean code principles, avoiding repetition and using best programming practices.

## Table of Contents 
- [Technologies and Libraries](#used-technologies-libraries-and-important-links)
- [Configuration](#configuration)
- [Events](#events)
- [Event Details](#event-details)
- [User Interface](#user-interface)
- [Splash Screen](#splash-screen)
- [Unit Tests](#unit-tests)

## Used Technologies, Libraries, and Important Links
- **[Swift](https://www.swift.org/documentation/)**  
- **[SwiftUI](https://developer.apple.com/tutorials/swiftui)**  
- **[XCTest](https://developer.apple.com/documentation/xctest/)**  
- **[User Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines)**  
- **[Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)**  
- **[Ticketmaster API](https://developer.ticketmaster.com/products-and-docs/apis/discovery-api/v2/)**

## Configuration
To check how the app works after cloning this repo, simply navigate to the `NetworkKey` file *(Ticketmaster/Network/NetworkKey.swift)* and paste your API key.

![image](https://github.com/user-attachments/assets/5a856bd3-0616-4236-9d5f-2b2ba2fd128d)



## Events
The **Events** section allows users to browse a wide variety of events in Poland, fetched in real-time from the **Ticketmaster API**. The list refreshes automatically with a pull-to-refresh feature, ensuring users have access to the latest updates. Infinite scrolling with pagination prevents excessive data usage by loading only what’s needed at a time. Users can also select a **sort** option if desired, which is managed through API parameters for efficient data handling.




## Event Details
Selecting an event displays a detailed view with key information in a clean, user-friendly layout. A "Buy Tickets" button directs users to the **Ticketmaster** website for easy ticket purchases. The view handles missing data gracefully, and error handling ensures that any issues are communicated clearly to the user.




## User Interface
The app’s UI is designed to adapt easily to different screen sizes and is fully compatible with both **light and dark mode**, providing a consistent and aesthetically pleasing experience across devices. While loading data, a **skeleton loading** animation enhances the user experience. **Reusable UI components** are implemented to avoid redundancy and improve maintainability.




## Splash Screen
Upon launching, the app displays a splash screen.




## Unit Tests
The app is carefully unit tested using **XCTest** to ensure the reliability of models and network calls, ensuring confidence in its functionality and stability.

![image](https://github.com/user-attachments/assets/ccc672fd-2fcb-49f3-99d1-58fd1f268363)


