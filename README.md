# T-POO-700-NAN_9

## TIME MANAGER

A comprehensive time management solution with web and mobile applications.

## Overview

TimeManager helps organizations track working hours and manage employee time efficiently through:

- Web application for desktop users
- Mobile application using Apache Cordova
- REST API backend built with Elixir/Phoenix

## Live Demo

Access the application at: [TimeManager Web App](https://timemanager-webapp-latest.onrender.com)

## Components

### Technology Stack

- 🔧 Backend: Elixir/Phoenix
- 🎨 Web Frontend: Vue.js
- 📱 Mobile: Apache Cordova
- 🗄️ Database: PostgreSQL
- 🔐 Authentication: JWT

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

1. Navigate to `timemanager-webapp`
2. Install Apache Cordova globally: `npm install -g cordova`
3. Install project dependencies: `npm install -D axios`
4. Ensure you have a functional Android emulator running
5. Add platforms:
   - `cordova platform add android`
6. Build the application:
   - `cordova build android`
7. Run on devices/emulators:
   - `npm run cordova-dev`

## Features

- ✨ User authentication and authorization
- ⏰ Clock in/out tracking
- 📊 Working time management
- 👥 Team organization
- 🔄 Real-time updates
- 📈 Reports and analytics in charts
- 🌐 Cross-platform accessibility


## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add some amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Create Pull Request
6. Ensure all tests pass
7. Update documentation if needed
8. Follow the existing code style
9. Add unit tests for new features
10. Wait for review and address feedback
11. Keep your PR up to date with main branch