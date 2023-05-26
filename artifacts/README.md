
# Reproduction Steps


## Setup
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



## Training and Evaluation

You need to set the `MODEL_DIR` and `SEED` environment variables for each run.
```bash
# inside the container
export MODEL_DIR=model-save-dir-3
export SEED=1400 # I've trained on 1313 and 1314 

. ./artifacts/train_and_eval.sh
```