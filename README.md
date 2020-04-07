# HALP!!!
![HALP!!!](https://media3.giphy.com/media/zLBQYkwGGQdJC/giphy.gif?cid=5a38a5a26b4924cbc1f61182b3015727d0166665babfd876&rid=giphy.gif)

## Configuration
Use the environment file sample to create your own. Most likely you can just copy it verbatim.

## Starting
From a terminal, run

```
docker-compose up 
```

Once running, you can view the site by visiting [http://127.0.0.1:32733](http://127.0.0.1:32733)

## Customisation

### Mounting Additional Directories/Files
This can be done in the docker compose yaml file.

### Environment
Changes to the environment need to be made in the Dockerfile and this should then be tagged as an appropriate image name for the project in the docker compose yaml file.
