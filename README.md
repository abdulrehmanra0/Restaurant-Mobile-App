# 🍽️ Restaurant Mobile App - Flutter

A beautifully designed Flutter-based restaurant mobile application developed as part of a technical task. The app features a sleek UI, Firebase authentication, a persistent cart, advanced product search, and a clean, maintainable codebase.

![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.x-blue.svg)


## 🚀 Features

- **Splash Screen**: Animated with a modern shimmer effect.
- **Firebase Authentication**: Secure email/password login and signup.
- **Persistent Sessions**: Maintains login state using `shared_preferences`.
- **Dashboard**: Dynamic home screen built with `CustomScrollView` and Slivers.
- **Product Detail Page**: Stylish detail screen with a draggable sheet UI.
- **Cart System**:
  - Add/remove products.
  - Cart persists after app restart.
  - Flicker-free quantity updates.
- **Product Search**: Full-text product search with real-time filtering.
- **Clean Architecture**: Clear separation of concerns (UI, Services, Models).

---

## 📸 Screenshots

### 🧾 Menu Screen
![Menu Screen](https://github.com/abdulrehmanra0/Restaurant-Mobile-App/blob/main/menu.jpg?raw=true)

### 🔍 Search Screen
![Search Screen](https://github.com/abdulrehmanra0/Restaurant-Mobile-App/blob/main/serachpage.jpg?raw=true)

### 📦 Order Detail Screen
![Order Detail](https://github.com/abdulrehmanra0/Restaurant-Mobile-App/blob/main/orderdetails.jpg?raw=true)

---

## 🛠️ Tech Stack & Architecture

- **Framework**: Flutter
- **Language**: Dart
- **Authentication**: Firebase Authentication
- **Local Storage**: `shared_preferences`
- **Architecture**: Clean Architecture

### 📂 Project Structure
lib/
├── constants # Asset paths and constants
├── data # Sample/mock data
├── models # Data classes (Product, CartItem)
├── screens # UI Screens (Login, Home, Cart, etc.)
├── services # Firebase auth, cart logic
└── widgets # Reusable UI components


---

## ▶️ Getting Started

### ✅ Prerequisites

- Flutter SDK (3.0.0 or higher)
- A Firebase Project (Configured)

---

### 🔧 Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/abdulrehmanra0/Restaurant-Mobile-App.git
   cd Restaurant-Mobile-App


## ⚙️ Firebase Configuration

Make sure you have FlutterFire CLI installed:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
