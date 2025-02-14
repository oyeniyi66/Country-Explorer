# 📌 Country Explorer
### Mobile-Desktop Stage Two Task

## 📝 Task Brief
This project is part of the *Mobile-Desktop Stage Two Task* for HNG Internship.  
The objective is to build a *Flutter mobile application* that allows users to:  
✅ View a list of countries fetched from an API  
✅ See detailed information about a selected country  
✅ Customize the app theme (light/dark mode)  
✅ Deploy the app to *Appetize.io* for online access

---

## 🌍 Features

### ✅ Country List
- Fetches and displays a list of countries from a *REST API*.
- Countries are presented in a *scrollable list*.
- *Alphabetical Grouping:* Countries are grouped alphabetically with headers for each letter.
- Includes a *search bar* to filter countries by name.

### ✅ Country Details
When a country is selected, the app displays additional details, including:
- *Name*
- *State/Provinces* (if available)
- *Flag (image)*
- *Population*
- *Capital city*
- *Current President* (if available)
- *Continent*
- *Country code*

### ✅ Advanced Filtering
Users can filter countries based on:
- *Continent*
- *Time Zone*
- *Language Spoken*

### ✅ Theme Customization
- A *toggle button* allows users to switch between *light and dark themes*.
- Theme changes apply to the entire app, including backgrounds, text, and UI components.

### ✅ Deployment to Appetize.io
- The app is deployed on *Appetize.io*, allowing users to test it online.

---

## 📱 UI Design
The app design is based on the *provided Figma reference*.

### 🏠 Home Screen
- Displays a *list of countries* fetched from the API.
- Includes a *search bar* for filtering by name.
- A *filter button* to refine results based on continent, time zone, or language.
- A *toggle button* for switching between light and dark themes.

### 📌 Country Details Screen
- Displays selected *country details* (name, flag, capital, country code, etc.).
- Shows a list of *states/provinces* if applicable.
- A *"Back" button* to return to the home screen.

---

## 🚀 Installation & Setup

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/oyeniyi66/country-explorer.git
cd country-explorer
