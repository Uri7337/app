# Projekt – aktuální kontext

## Cíl

Vytvořit jednoduchou demo aplikaci běžící v Dockeru se standardní třívrstvou architekturou:

* Frontend: React + MUI (Vite build)
* Backend: Java Spring Boot (REST API)
* Databáze: PostgreSQL

Aplikace po spuštění automaticky naplní databázi testovacími daty a frontend je zobrazí v tabulce.

---

## Architektura

3 kontejnery orchestruje docker-compose:

* db – PostgreSQL databáze
* backend – Spring Boot REST API
* frontend – statický React build servírovaný Nginxem

Komunikace:
Frontend → HTTP → Backend → JDBC → PostgreSQL

Docker network používá service DNS názvy (např. `backend`, `db`), nikoliv `localhost`.

---

## Databáze

Použit PostgreSQL 16 image.

Při prvním vytvoření datového volume se spustí init skript:

* vytvoření tabulky `users`
* vložení testovacích záznamů

Mechanismus: `/docker-entrypoint-initdb.d/init.sql`

Důležité chování:

* init script se provede pouze při prvním vytvoření volume
* pro reset dat je nutné: `docker compose down -v`

Pro zajištění readiness je použit healthcheck (`pg_isready`), aby backend nestartoval dříve než DB přijímá spojení.

---

## Backend (Spring Boot)

Stack:

* Spring Web
* Spring Data JPA
* PostgreSQL driver
* Lombok

Konfigurace:

* připojení přes environment variables z docker-compose
* Hibernate bez auto-DDL (schema spravuje SQL init)
* backend startuje až po healthy DB

Doménový model (plánovaný):

* Entity: User (id, name, email)
* Repository: JpaRepository
* Controller: `/api/users` GET vrací všechny uživatele

Docker:

* build z Dockerfile v `backend/`
* aplikace dostupná na portu 8080 uvnitř sítě jako `http://backend:8080`

---

## Frontend (React + MUI)

Frontend není vytvořen pomocí create-react-app (deprecated), ale pomocí Vite.

Funkce:

* při mountu zavolá `/api/users`
* data uloží do state
* vykreslí MUI tabulku

Stack:

* React 18
* Vite
* Axios
* Material UI

API konfigurace:

Backend URL není napevno v kódu — používá build-time proměnnou:

`VITE_API_URL=http://backend:8080`

Lokálně fallback:
`http://localhost:8080`

---

## Docker – frontend

Multi-stage build:

1. Node image → Vite build (`dist`)
2. Nginx → servíruje statický obsah

Mapování portů:
host `3000` → container `80`

Frontend komunikuje s backendem přes Docker DNS (`backend`), nikoliv localhost.

---

## Spuštění

První spuštění (nutné pro seed DB):

```sh
sudo systemctl start docker;
docker-compose down -v;
docker-compose up --build;
```

Po startu:

1. DB vytvoří schema + data
2. backend čeká na DB readiness
3. frontend načte data z API

URL: [http://localhost:3000](http://localhost:3000)

---

## Výsledek

Funkční minimální fullstack aplikace:

* deterministický seed databáze
* REST API
* React UI s MUI tabulkou
* izolace služeb v kontejnerech
* korektní pořadí startu kontejnerů
* backend URL konfigurovatelná build-time proměnnou
