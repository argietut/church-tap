# Church Tap - Mobile Application

**Church Tap** is a mobile application designed to manage church appointments and event schedules for **Magatos UCCP Church**. It simplifies the process of organizing church activities and communicating them to members, ensuring that all important updates and events are easily accessible.

## Features

### For Church Members:
- **Manage Appointments**: Create, edit, cancel, and view church appointments.
- **Locate Outreach Churches**: Find the locations of outreach churches within the app.
- **View Events**: Access the latest church events and schedules.
- **Profile Management**: Manage personal account settings and log out securely.

### For Church Admin:
- **Approve or Decline Appointments**: Manage appointment requests from church members.
- **Event Management**: Create, edit, update, and view church event details.
- **Set Available Dates**: Schedule or block out available dates for appointments.
- **Calendar View**: Check all appointments and events in a structured calendar view.

## System Architecture

The application uses the **Model-View-Presenter (MVP)** architectural pattern, incorporating a cloud-based backend with **Firebase Firestore** for data management, ensuring smooth performance and real-time updates across devices.

## Tech Stack
- **Flutter**: A cross-platform UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase Firestore**: A NoSQL cloud database for storing and syncing data in real time.
- **Google Maps API**: Integrated for locating outreach churches.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/church-tap.git
   
2. Navigate to the project directory:
   ```bash
   cd church-tap

3. Install dependencies:
   ```bash
   flutter pub get

4. Set up Firebase:
- Create a Firebase project and add Android/iOS apps.
- Download and place google-services.json (for Android) or GoogleService-Info.plist (for iOS) in the respective directories.

5. Run the app on your emulator or device:
    ```bash
   flutter run
