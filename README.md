# docker-jtl-shop-stack

Complete local development stack for JTL Shop 5.x with Xdebug, MariaDB, PhpMyAdmin using docker-compose.
I've used <https://github.com/neumanniTech/docker-jtl-shop-stack.git> as starting point.

Tested JTL Shop Version:

- 5.2.3

## Installation

First, clone this repository:

```sh
git clone https://github.com/sarmbruster/docker-jtl-shop-stack.git
```

### optional step: provide a backup of an existing shop

In my use case I wanted to habe a local dockerized development enviroment for an exisitng online shop. Therefore you habe to provide the following:

- a dump of the shop database in the `sql` subfolder, as a `.sql` or `.sql.gz` file(s)
- a copy of your exsting installation's docroot extracted to `shop.backup` folder 

### config file

Rename `.env.dist` to `.env`.

Set the values there to appropriate values.

### prepare the installation

There is a script that downloads the required JTL shop version and prepares its config. 
Also media files are copied from your existing setup.

```sh
./prepare.sh
```

### SSL certificates

On the host machine, install <https://github.com/FiloSottile/mkcert>.
Use `mkcert -install` to install the root cert to your local web browser as a one shot operation.
Use

```sh
cd ssl
mkcert -cert-file cert.pem -key-file cert-key.pem localhost 127.0.0.1 ::1
```

This creates certificate files for apache that are accepted by your web browser.

### start your stack

```sh
docker-compose up
```

You are done, you can visit your JTL Shop on the following URL: `http://localhost` .

**Info:** The DB Host must be `jtl-db`

PhpMyAdmin: `http://localhost:8080`

## How it works

To access the jtl-shop container run the following:

```bash
 docker-compose ps
               Name                             Command               State                                   Ports                                 
----------------------------------------------------------------------------------------------------------------------------------------------------
docker-jtl-shop-stack_jtl-db_1       docker-entrypoint.sh mariadbd    Up      0.0.0.0:3306->3306/tcp,:::3306->3306/tcp                              
docker-jtl-shop-stack_jtl-shop_1     docker-php-entrypoint apac ...   Up      0.0.0.0:443->443/tcp,:::443->443/tcp, 0.0.0.0:80->80/tcp,:::80->80/tcp
docker-jtl-shop-stack_phpmyadmin_1   /docker-entrypoint.sh apac ...   Up      0.0.0.0:8080->80/tcp,:::8080->80/tcp   

# to get a shell inside a container:
docker-compose exec jtl-shop /bin/bash
```
