
DealOneDir()
{
  ls -al $1/*.h > /dev/null
  if [ $? -ne 0 ]
  then 
    echo "ERROR found *.h in $1"
  else
    echo " In " "$1" "dir: "
    for mysourcefile in $1/*.h
    do
      echo "  " `basename $mysourcefile`
      sed -e 's/
//g' -e 's/	/    /g' $mysourcefile > /tmp/temp.h
      mv /tmp/temp.h $mysourcefile
    done
  fi

  ls -al $1/*.cpp > /dev/null
  if [ $? -ne 0 ]
  then 
    echo "ERROR found *.cpp in $1"
  else
    ## echo " In " "$1" "dir: "
    for mysourcefile in $1/*.cpp
    do
      echo "  " `basename $mysourcefile`
      sed -e 's/
//g' -e 's/	/    /g' $mysourcefile > /tmp/temp.cpp
      mv /tmp/temp.cpp $mysourcefile
    done
  fi

}

DealOneDir ./

