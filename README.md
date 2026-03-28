# 🚀 Flutter Character App (Offline-First with Riverpod)

A clean, scalable Flutter application demonstrating **modern architecture**, **state management with Riverpod**, and **offline-first caching using Hive**.

This project was built as part of a technical assessment to showcase production-level Flutter development practices.

---

## ✨ Features

* ✅ Fetch characters from API (Rick & Morty API)
* ✅ Clean Architecture (Data / Domain / Presentation)
* ✅ State Management using Riverpod
* ✅ Offline-first caching using Hive
* ✅ Detail page using cached data (no duplicate API calls)
* ✅ Local editing support (persisted offline)
* ✅ Reactive UI updates using provider invalidation
* ✅ Modular and scalable project structure

---

## 🧱 Architecture

This project follows **Clean Architecture principles**:

```
lib/
│
├── core/
│   └── api_client.dart
│
├── features/
│   └── character/
│       ├── data/
│       │   ├── model/
│       │   ├── remote/
│       │   ├── local/
│       │   └── repository/
│       │
│       ├── domain/
│       │   └── character.dart
│       │
│       └── presentation/
│           ├── pages/
│           └── providers/
```

---

## 🔄 Data Flow

```
API → Repository → Cache (Hive) → UI
                  ↓
              Offline Mode
```

* Repository handles:

  * API fetching
  * Local caching
  * Offline fallback
* UI only interacts with providers (no direct data access)

---

## 📦 Tech Stack

* Flutter
* Riverpod (State Management)
* Hive (Local Storage)
* HTTP (API calls)

---

## 🧠 Key Concepts Implemented

### 🔹 Offline-First Approach

* API data is cached locally using Hive
* App falls back to cached data when offline

### 🔹 Single Source of Truth

* Local database (Hive) acts as the primary data source after fetch

### 🔹 Separation of Concerns

* UI, business logic, and data handling are fully separated

### 🔹 Immutable State Handling

* `copyWith()` used for safe updates

---

## ✏️ Editing Feature

* Users can edit character data locally
* Changes are persisted in Hive
* UI updates instantly using Riverpod invalidation

---

## ▶️ Getting Started

### 1. Clone the repository

```
git clone https://github.com/your-username/your-repo.git
cd your-repo
```

### 2. Install dependencies

```
flutter pub get
```

### 3. Run the app

```
flutter run
```

---

## 📡 API Used

* Rick and Morty API
  https://rickandmortyapi.com/

---

## 🧪 Future Improvements

* Pagination with caching
* Favorites system
* Search & filtering
* Form validation & dropdown inputs
* Sync local edits with server

---

## 🎯 Interview Highlights

This project demonstrates:

* Clean architecture in Flutter
* Advanced state management using Riverpod
* Offline-first design patterns
* Scalable and maintainable code structure
* Real-world app development practices

---

## 👨‍💻 Author

**Kamruzzaman Shaown**

---

## 📌 Notes

This project focuses on architecture and data flow rather than UI complexity.
However, UI components are structured for easy scalability.

---
