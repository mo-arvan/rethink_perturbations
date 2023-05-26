


```bash
cd rethink_perturbations

docker build -t rethink-rep:latest -f artifacts/dockerfile .

```


```bash

docker run -it --rm \
    --gpus all \
    --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 \
    -v $PWD:/workspace \
    rethink-rep:latest \
    bash

```