NUM_GPUS=2
. ../../set_env_vars.sh
set_env_vars 70 0

python ../../pascal_voc.py
python train_center_net.py --gpus $GPUS -j 30 --dataset voc --dtype $DTYPE \
     --batch-size 32 --log-interval 10 --epochs $NUM_EPOCHS $USE_AMP --lr-decay-epoch 45,60 \
     --lr 0.000125 --wd 1e-5 --momentum 0.9 --wh-weight 0.1 --warmup-epochs $WARM_EPOCHS \
     --val-interval 5  --network resnet18_v1b_dcnv2 --flip-validation



