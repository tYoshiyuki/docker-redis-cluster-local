# docker-redis-cluster-local
Redis Cluster を構築するための docker compose

## Feature
- Docker
- docker compose
- Redis

## Usage
```
docker-compose up -d
```

・port 7100 ～ 7105 で 各Redis Cluster が動作します。

```
redis-cli -p 7100 -c
127.0.0.1:7100> set TestKey 100
-> Redirected to slot [15013] located at 127.0.0.1:7102
OK
```
