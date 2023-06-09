

#export MODEL_DIR=model-save-dir-2
#export SEED=1315 # MAKE SURE to update


CUDA_VISIBLE_DEVICES=0 python -u train.py     /dataset_bin     --arch transformer_iwslt_de_en --optimizer adam --adam-betas '(0.9, 0.98)'     --clip-norm 0.0 --lr 5e-4 --lr-scheduler inverse_sqrt --warmup-updates 4000     --dropout 0.3 --weight-decay 0.0001 --criterion label_smoothed_cross_entropy     --label-smoothing 0.1 --max-tokens 4096 --log-interval 100  --max-update 100000     --sampling-method worddrop_with_sim_enc_drop --enc-replace-rate 0.1 --dec-replace-rate 0.1 --decay-val 1000     --share-all-embeddings --keep-last-epochs 20 --seed $SEED --save-dir $MODEL_DIR

python scripts/average_checkpoints.py --inputs $MODEL_DIR --num-epoch-checkpoints 10 --output $MODEL_DIR/averaged.pt

python generate.py $IWSLT_DATA_BIN --path $MODEL_DIR/averaged.pt  --beam 5 --remove-bpe > $MODEL_DIR/generated.result

#
#python generate.py $IWSLT_DATA_BIN --path $MODEL_DIR/averaged.pt  --beam 5 --remove-bpe | grep '^H' | sed 's/^H\-//g' | sort -t ' ' -k1,1 -n | cut -f 3- > generated.result
#
#python generate.py $IWSLT_DATA_BIN --path model-save-dir-1/averaged.pt  --beam 5 --remove-bpe > generated.result
#
#/dataset/mosesdecoder/scripts/generic/multi-bleu.perl
#
#
#cat generated.result | /dataset/mosesdecoder/scripts/generic/multi-bleu.perl $IWSLT_DATA/test.en.tokenized
#
#cat $IWSLT_DATA/test.en | /dataset/mosesdecoder/scripts/tokenizer/detokenizer.perl -l en > $IWSLT_DATA/test.en.detokenized
#
#
#root@87aabc1ab24f:/workspace# history
#8  apt-get install libexpat1-dev
#2  cpan XML::Twig XML::Parser Sort::Naturally
#13  history
