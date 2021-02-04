To build the image run

```
docker build -t esp8266 --build-arg USER_ID=`id -u` --build-arg=`id -g` .
```

To initialize a project

```
docker run -it --rm -v `pwd`:/opt/esp/src esp8266 init
```

To open a shell

```
docker run -it --rm -v `pwd`:/opt/esp/src esp8266 shell
```

To run a command in the container

```
docker run -it --rm -v `pwd`:/opt/esp/src esp8266 <command>
```
