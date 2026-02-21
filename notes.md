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