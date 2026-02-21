# App
zatím jedu jen čistě dle gtp, uvidíme zda mě to někam dostane lol

## First run 
po první runu
```sh
sudo systemctl start docker;
docker-compose down -v;
docker-compose up --build;
```
mám první chybu v error.log

### First run Oprava
doplněny importy(ani nevím jaké a jestli jsou správně)

## Second run 
po druhém runu
```sh
sudo systemctl start docker;
docker-compose down -v;
docker-compose up --build;
```
mám druhou chybu v error2.log

### Second run Oprava
Nainstaloval jsem maven
```sh
sudo apt install maven
```
spustil jsem build lokálně pro ověření
```sh
mvn clean package -DskipTests
```
**BUILD SUCCESS** - tak uvidíme

ještě jsem rozjel gitignore jak jsme udělali build a pak git refresh:
```sh
 1645  touch .gitignore
 1646  git status
 1647  git rm -r --cached .
 1648  git add .
 1649  git commit -m "refresh gitignore"
 1650  clear
```

Fixnul jsem docker file:
```Dockerfile
COPY --from=build /app/target/demo-0.0.1.jar app.jar
# -->
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
```

## Third run
Vše vypadá ok, o projektu vím tak málo, že jsem se zeptal chatgpt jak to ověřím zda se to o co jsem tak pracně usiloval povedlo xd

```diff
+ Frontend – otevři v prohlížeči:

+ http://localhost:3000

+ Mělo by se objevit UI s MUI tabulkou a třemi uživateli z init SQL.

+ Backend API – můžeš otestovat přímo přes curl nebo prohlížeč:

+ http://localhost:3000/api/users

+ Vrátí JSON s uživateli. Pokud backend běží na portu 8080, ale frontend je přesměrován přes Nginx, použij frontend proxy (Vite nebo Nginx) → localhost:3000.

+ Kontrola kontejnerů

+ docker ps

+ Měly by běžet: demo-db, demo-backend, demo-frontend.

+ Z logu se tedy dá říct, že problém s JAR je vyřešen a aplikace by měla být funkční.
```