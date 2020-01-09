# vsf_supru_app

Main project to deploy VueStoreFront based application for 'supplz.ru'.

## Deployment

```
$ git clone git@github.com:flancer32/vsf_supru_app.git
$ cd vsf_supru_app
$ cp cfg.init.sh cfg.local.sh
$ nano cfg.local.sh
...
$ bash ./bin/deploy/all.sh
```

## Mage2VSF data replication

```
$ bash ./apps/mage2vuestorefront/replicate_msk.sh
```

Better use `cron` to replicate data:
```
54 18 * * * /bin/bash /home/alexg/vsf/vsf_supru_app/apps/mage2vuestorefront/replicate_msk.sh > /home/alexg/replicate_msk.cron.log
```