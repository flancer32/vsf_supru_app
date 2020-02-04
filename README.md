# vsf_supru_app

Main project to deploy VueStoreFront based application for 'supplz.ru'.




## Deployment

```
$ git clone git@github.com:flancer32/vsf_supru_app.git
$ cd vsf_supru_app
$ cp cfg.init.sh cfg.local.sh
$ nano cfg.local.sh
...
$ g

```


## Mage2VSF data replication

```
$ bash ./apps/mage2vuestorefront/replicate_msk.sh
```

Better use `cron` to replicate data:
```
54 18 * * * /bin/bash /home/alexg/vsf/vsf_supru_app/apps/mage2vuestorefront/replicate_msk.sh > /home/alexg/replicate_msk.cron.log
```


## Start/stop applications
To start or to stop all 3 apps (`front`, `api`, `o2m`):
```
$ ./bin/start.sh
$ ./bin/stop.sh
```

## View logs

```
$ ls -lh ./var/log/
total 15M
-rw-rw-r-- 1 alex alex 945K feb  3 11:39 api.log
-rw-rw-r-- 1 alex alex  14M feb  3 11:40 front.log
-rw-rw-r-- 1 alex alex 1,2K feb  3 11:39 o2m.log
```