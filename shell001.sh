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
done