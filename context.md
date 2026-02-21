# Projekt – aktuální kontext

## Cíl

Vytvořit jednoduchou demo aplikaci běžící v Dockeru se standardní třívrstvou architekturou:

* Frontend: React + MUI
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

---

## Databáze

Použit PostgreSQL 16 image.

Při prvním startu se spustí init skript:

* vytvoření tabulky `users`
* vložení testovacích záznamů

Mechanismus: `/docker-entrypoint-initdb.d/init.sql`

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

Doménový model:

* Entity: User (id, name, email)
* Repository: JpaRepository
* Controller: `/api/users` GET vrací všechny uživatele

Docker:

* multi-stage build (Maven → JRE image)
* výsledný artifact: fat jar

---

## Frontend (React + MUI)

Funkce:

* při mountu zavolá `/api/users`
* data uloží do state
* vykreslí MUI tabulku

Stack:

* React 18
* Axios
* Material UI

Docker:

* build Node image
* runtime Nginx
* port 3000 → 80

---

## Spuštění

`docker compose up --build`

Po startu:

* DB se inicializuje
* backend se připojí
* frontend načte data

URL: [http://localhost:3000](http://localhost:3000)

---

## Výsledek

Funkční minimální fullstack aplikace:

* seed databáze při startu
* REST API
* zobrazení dat ve frontend UI
* izolace služeb v kontejnerech
