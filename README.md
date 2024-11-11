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

<p align="center"> 
<img src="https://github.com/user-attachments/assets/5a856bd3-0616-4236-9d5f-2b2ba2fd128d">
</p>



## Events
The **Events** section allows users to browse a wide variety of events in Poland, fetched in real-time from the **Ticketmaster API**. The list refreshes automatically with a pull-to-refresh feature, ensuring users have access to the latest updates. Infinite scrolling with pagination prevents excessive data usage by loading only what’s needed at a time. Users can also select a **sort** option if desired, which is managed through API parameters for efficient data handling.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/8f12a2a0-e913-43d2-8693-97fe5fe0a078" width="310" height="660">
<img src="https://github.com/user-attachments/assets/c2f436cd-99a8-4529-8a6a-71f5faf171de" width="310" height="660">
<img src="https://github.com/user-attachments/assets/b76d1051-ff23-4c4c-978b-8051525f1cd2" width="310" height="660">
</p>



## Event Details
Selecting an event displays a detailed view with key information in a clean, user-friendly layout. A "Buy Tickets" button directs users to the **Ticketmaster** website for easy ticket purchases. The view handles missing data gracefully, and error handling ensures that any issues are communicated clearly to the user.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/f9982b0f-c270-4b5e-9765-608a97b02127" width="310" height="660">
<img src="https://github.com/user-attachments/assets/d53c2c9b-fac5-49d7-a321-5d1767753cdf" width="310" height="660">
<img src="https://github.com/user-attachments/assets/d650ef41-f617-4d98-bf8d-d7296d10898c" width="310" height="660">
</p>




## User Interface
The app’s UI is designed to adapt easily to different screen sizes and is fully compatible with both **light and dark mode**, providing a consistent and aesthetically pleasing experience across devices. While loading data, a **skeleton loading** animation enhances the user experience. **Reusable UI components** are implemented to avoid redundancy and improve maintainability.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/859994e0-e39d-477f-94f9-b23f4393297e" width="310" height="660">
<img src="https://github.com/user-attachments/assets/f8d68635-94b7-48b4-b513-c1f4fa76a113" width="310" height="660">
</p>



## Splash Screen
Upon launching, the app displays a splash screen.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/c854a324-6fa1-4923-9d46-985f161b4beb" width="310" height="660">
<img src="https://github.com/user-attachments/assets/54cff131-f0ad-4b1d-b868-764445baf9e7" width="310" height="660">
</p>



## Unit Tests
The app is carefully unit tested using **XCTest** to ensure the reliability of models and network calls, ensuring confidence in its functionality and stability.

<p align="center"> 
<img src="https://github.com/user-attachments/assets/ccc672fd-2fcb-49f3-99d1-58fd1f268363">
</p>

