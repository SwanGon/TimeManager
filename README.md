# T-POO-700-NAN_9

## TIME MANAGER
A comprehensive time management solution with web and mobile applications.

## Overview

TimeManager helps organizations track working hours and manage employee time efficiently through:
- Web application for desktop users
- Mobile application using Apache Cordova
- REST API backend built with Elixir/Phoenix

## Live Demo
Access the application at: https://timemanager-webapp-latest.onrender.com

## Components

### Backend API
- Built with Elixir and Phoenix Framework
- RESTful architecture
- JWT authentication
- Role-based access control

### Web Application
- Modern responsive interface
- Real-time clock in/out
- Working time visualization
- Team management features

### Mobile Application
- Cross-platform (iOS/Android)
- Built with Apache Cordova
- Hybrid mobile application
- Shares web codebase
- Native device features integration

## Installation

### Backend API
1. Install Elixir from [official website](https://elixir-lang.org/install.html)
2. Install Phoenix Framework following the [installation guide](https://hexdocs.pm/phoenix/installation.html)
3. Clone the repository
4. Navigate to `timemanager-api`
5. Run `mix deps.get`
6. Configure database in `config/dev.exs`
7. Run `mix ecto.setup`
8. Start server with `mix phx.server`

### Web Application
1. Navigate to `timemanager-webapp`
2. Run `npm install`
3. Configure API endpoint in environment files
4. Start development server with `npm run dev`

### Mobile Application (Cordova)
1. Install Apache Cordova globally: `npm install -g cordova`
2. Navigate to `timemanager-mobile`
3. Add platforms:
   - `cordova platform add ios`
   - `cordova platform add android`
4. Build the application:
   - `cordova build ios`
   - `cordova build android`
5. Run on devices/emulators:
   - `cordova run ios`
   - `cordova run android`

## Features

- User authentication and authorization
- Clock in/out tracking
- Working time management
- Team organization
- Real-time updates
- Reports and analytics in charts
- Cross-platform accessibility

## Technology Stack

- Backend: Elixir/Phoenix
- Web Frontend: Vue.js
- Mobile: Apache Cordova
- Database: PostgreSQL
- Authentication: JWT


## Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request