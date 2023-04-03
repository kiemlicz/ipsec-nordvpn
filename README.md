NordVPN StrongSwan config

```
docker build --build-arg USERNAME=username --build-arg PASSWORD=password --build-arg SERVER=server -t nordswan .
docker run -it --privileged --name nordvpn strongswan
```

Have some VICI plugin to upload and run or attach with `docker exec -it nordvpn bash` and:  
1. Load the config `swanctl --load-all`  
2. Run the tunnel `swanctl -i nordvpn -c nordvpn`

NordVPN server selector: https://nordvpn.com/servers/tools/
