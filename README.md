# Blog Microservices Application

A microservices-based blog application with posts, comments, moderation, and real-time updates.

## Services

- **Posts Service** (Port 4000) - Manages blog posts
- **Comments Service** (Port 4001) - Manages comments
- **Query Service** (Port 4002) - Aggregates data for frontend
- **Moderation Service** (Port 4003) - Moderates comments
- **Event Bus** (Port 4005) - Handles inter-service communication
- **Client** (Port 3000) - React frontend

## Quick Start

### Local Development
```bash
# Start each service in separate terminals
cd posts && npm install && npm start
cd comments && npm install && npm start
cd query && npm install && npm start
cd moderation && npm install && npm start
cd event-bus && npm install && npm start
cd client && npm install && npm start
```

### Docker Compose
```bash
docker-compose up --build -d
```

## Architecture

The application uses an event-driven architecture where services communicate through the event bus.