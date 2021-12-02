NUM_GPUS=4
. ../../set_env_vars.sh
set_env_vars 50 0 float32

python ../../mscoco.py
python ../../pascal_voc.py

CUDA_VISIBLE_DEVICES=$GPUS
# First finetuning COCO dataset pretrained model on augmented set
# If you would like to train from scratch on COCO, please see deeplab_resnet101_coco.sh
python ../train.py --dataset pascal_aug --model-zoo deeplab_resnet152_coco --aux \
	  --epochs $NUM_EPOCHS --warmup-epochs $WARM_EPOCHS --dtype $DTYPE $USE_AMP \
    --lr 0.001 --syncbn --ngpus $NUM_GPUS --checkname res152
# Finetuning on original set
python ../train.py --dataset pascal_voc --model deeplab --aux --backbone resnet152 \
	  --epochs $NUM_EPOCHS --warmup-epochs $WARM_EPOCHS --dtype $DTYPE $USE_AMP \
    --lr 0.0001 --syncbn --ngpus $NUM_GPUS --checkname res152 --resume runs/pascal_aug/deeplab/res101/checkpoint.params






