#!/usr/bin/env bash

# start time in milliseconds
start=$(gdate +%s.%6N)

input="$(cat input1.txt)"

distance=0
list1=()
list2=()

i=0
for locationId in $input; do
    if [ $((i % 2)) -eq 0 ]; then
        list1+=($locationId)
    else
        list2+=($locationId)
    fi
    i=$((i + 1))
done

sortList1=($(for i in "${list1[@]}"; do echo $i; done | sort -n))
sortList2=($(for i in "${list2[@]}"; do echo $i; done | sort -n))

for i in "${!sortList1[@]}"; do
    a=${sortList1[$i]}
    b=${sortList2[$i]}

    if [ $((a - b)) -gt 0 ]; then
        distance=$((distance + a - b))
    else
        distance=$((distance + b - a))
    fi
done

# end time in milliseconds
end=$(gdate +%s.%6N)

echo $distance
echo "Execution time: $(echo "($end - $start) * 1000" | bc) ms"
