# Traefik v3.1 gateway for syncthing

A Traefik v3.1 docker-compose file with dashboard and header-renaming plugin 
needed by syncthing discosrv to properly function.

## Getting started
* Create `env.sh` and modify to your needs
```
cp env.sh_example env.sh
```
* Deploy stack to your server
```
bash deployToServer.sh
```
* Check results
  * https://yourbasedomain.com
  * https://sys.yourbasedomain.com
