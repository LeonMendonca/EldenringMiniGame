#/bin/bash

monster=$(($RANDOM%10))
#echo $monster

#Creating random minimized range for Samurai
RangeGen() {
case $monster in
  0)
    init=0
    end=$(($RANDOM%5+1))
    ;;
  1)
    init=$(($monster-1))
    end=$(($RANDOM%4+3))
    ;;
  8)
    init=$(( $(($RANDOM%3)) + 5 ))
    end=$(($monster+1))
    ;;
  9)
    init=$(( $(($RANDOM%3)) + 6))
    end=$(($monster))
    ;;
  *)
    init=$(( $monster - $(($RANDOM%2)) ))
    end=$(( $(($RANDOM%3)) + $monster ))
esac

#echo $init $end
}

#Battle Description
BattleDesc() {
 myarray=("$@")
 for x in "${myarray[@]}";
 do
  sleep 2
  echo "$x"
 done
}

#Win Loss
WinLoss() {
 #$1 battle result 1-win 0-loss
 #$2 player type
 case $1 in
 1)
    if [[ "$2" == samurai ]]; then
     SamuraiWinArray=(
      "In a distant land, the renowned samurai, YOU, confronted a monstrous demon terrorizing a village."
      "The battle was fierce, but You, The samurai, exploiting the monster's weakness, blinded it and struck it down."
      "The villagers cheered his victory, and You became a legendary hero, proving that courage and resourcefulness could conquer any foe."
      "YOU WIN!"
     )
     BattleDesc "${SamuraiWinArray[@]}"
    else
     ProphetWinArray=(
      "In a quiet village, a frail prophet that is YOU, who faced a fearsome monster"
      "While physically weak, YOU foresaw the monster's vulnerability to sunlight."
      "You rallied the villagers, and together they fought at dawn."
      "The monster, blinded by the light, was defeated, proving that courage and insight can overcome even the most daunting odds."
      "YOU WIN!"
     )
     BattleDesc "${ProphetWinArray[@]}"
    fi
   ;;
 0)
    if [[ "$2" == samurai ]]; then
     SamuraiLostArray=(
      "In a distant land, the renowned samurai, YOU, confronted a monstrous demon terrorizing a village."
      "The battle was fierce, but despite YOUR remarkable skill, the monster proved to be an unstoppable force"
      "Its sheer power overwhelmed YOU, though valiant, was defeated."
      "YOU LOST!"
     )
     BattleDesc "${SamuraiLostArray[@]}"
    else
     ProphetLostArray=(
      "In a tranquil village, a frail prophet YOU confronted the fearsome monster"
      "Despite YOUR wisdom, YOU couldn't foresee the monster's unpredictable nature."
      "The monster, with its incredible strength and cunning, overpowered YOU, the prophet and devastated the village."
      "the monster remained undefeated, leaving the village in ruins."
      "YOU LOST!"
     )
     BattleDesc "${ProphetLostArray[@]}"
    fi
   ;;
 esac
}

#Type Description and Loading
LoadingHash() {
  #$1 is used as argument
  hashVal=""
  for ((i=0;i<$1;i++))
  do
    hashVal+="#"
    echo $hashVal
    sleep 1
  done
}

TypeDesc() {
#$1 - playerType
#$2 - description
 echo -e "Welcome, $1!!\nYouve got a brave spirit, and surely defeat the monster"
 echo -e "\nLets see what your type says about you\n"

 LoadingHash 3

 echo
 echo "here, so you are $2. wow! fasinating"
 echo -e "\n"
}

#Monster vs Player function
MvsP() {
 #$1 is playerType
 rangeI=0
 rangeE=9
 if [[ $1 == samurai ]]; then
  rangeI=$init
  rangeE=$end
 fi
 echo -e "Be ready!\nThe monster would arrive at any moment!"
 #Random delay for monster to arrive 0-4
 LoadingHash $(($RANDOM%5))
 echo "Monster arrived, select number between ($rangeI,$rangeE)"
 while :
 do
  read estimateNum
  if [[ $estimateNum == $monster ]]; then
   #echo "You win!"
   WinLoss 1 $1
   break
  elif [[ $estimateNum < 0 || $estimateNum > 9 ]]; then
   echo "Invalid input"
   continue
  else
   #echo "You died!"
   WinLoss 0 $1
   break
  fi
 done
}

#Main eldinring program

echo -e "pick your type\n1 - samurai\n2 - prophet"
playerSamurai="samurai"
samuraiDesc="an elite class of Japanese warrior"

playerProphet="prophet"
prophetDesc="an individual who is regarded as being in contact with a divine being"

while :
do
read type
 case $type in
   1)
     if [[ $USER == root ]]; then
       playerType=$playerSamurai
       description=$samuraiDesc
       RangeGen
       break
     else
       echo -e "you dont seem to be a root user\nYouve been assigned Prophet"
       echo
       playerType=$playerProphet
       description=$prophetDesc
       break
     fi
     ;;
   2)
     playerType=$playerProphet
     description=$prophetDesc
     break
     ;;
   *)
     echo "Pls make a valid selection"
     continue
 esac
done
TypeDesc "$playerType" "$description"
MvsP $playerType
#echo $playerType
