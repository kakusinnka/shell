#!/bin/bash
for FILE in tmp/*.py
  do
    echo $FILE
    oldDagIdLine=$(grep "^def " $FILE)
    echo $oldDagIdLine
    oldDagIdStr=${oldDagIdLine%:*}
    oldDagIdStr=${oldDagIdStr:4}
    echo $oldDagIdStr
    newDagIdStr=${oldDagIdStr%(*}"_sandbox()"
    echo $newDagIdStr
    sed -i "s/$oldDagIdStr/$newDagIdStr/" $FILE


    line=$(sed -n '/default_args/=' $FILE)
    ((line++))
    echo $line
    ownerStr="'owner': 'max',"
    echo $ownerStr
    sed -i "${line}i \    $ownerStr" $FILE

    extTrgLN=$(sed -n '/session\|external_dag_id\|trigger_dag_id/=' $FILE)
    echo $extTrgLN
    for line in ${extTrgLN[@]}; do
      echo $line
      sed -i "${line}s/\",/_sandbox\",/g" $FILE
      sed -i "${line}s/',/_sandbox',/g" $FILE
    done

    sed -i 's/\r//g' $FILE
    sed -i 's/$/\r/g' $FILE
done

