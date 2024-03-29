# Devops
You need:
- `.env.prod` for production environment
- `.env.dev` for development environment
- `.env.test` for testing environment

To execute environments:
- Production: `docker compose -f ./prod.yml up --build`
- Development: `docker compose -f ./dev.yml up --build`
- Testing: `docker compose -f ./test.yml up --build`
