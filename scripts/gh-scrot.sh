alias gh='DAY=$(date +%d); \
          MONTH=$(date +%m); \
          WDIR=$HOME/work/gh/$MONTH-$DAY; \
          if [ ! -d $WDIR ]; then \
            mkdir -p $WDIR; \
          fi; \
          cd $WDIR; \
          clear'


gh
echo $PWD
scrot
