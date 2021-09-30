# TEST SERVICE
All test service run command
```sh
docker-compose up
```
- Influxdb 1.8.x
- Influxdb 2.x
- Mariadb-cluster 
- Mongodb-cluster 4.4.0
- Mqtt(mosquitto) 1.6.12
- Redis 6.0

## Influxdb 1.8.x

version = 1.8.3

index-version = tsi1

## Influxdb 2.x

version = 2.0.4

Web page is `localhost:8086`

## Mariadb-cluster

version = 10.1.38

[Percona Toolkit Install](https://www.percona.com/doc/percona-repo-config/installing.html)

## Mongodb-cluster

version = 4.4.0

replSet my-mongo

## Mqtt-mosquitto

version = 1.6.12

### Test

Test broker subscribe
```sh
mosquitto_sub -h localhost -t "sensor/temperature"
```

Test broker publish
```sh
mosquitto_pub -h localhost -t "sensor/temperature" -m 21
```

### Authentication

Create user
```sh
mosquitto_passwd -c /mosquitto/config/mosquitto.passwd user
```

Add user
```sh
mosquitto_passwd -b /mosquitto/config/mosquitto.passwd user password
```

Delete user
```sh
mosquitto_passwd -D /mosquitto/config/mosquitto.passwd user
```

## Redis

version = 6.0