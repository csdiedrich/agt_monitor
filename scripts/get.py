import docker

client = docker.from_env()

count = client.info()
print(count['ContainersRunning'])
