
if [ ! -e "MAMP_MAMP_PRO_3.2.1.pkg" ]; then
    wget http://downloads9.mamp.info/MAMP-PRO/releases/3.2.1/MAMP_MAMP_PRO_3.2.1.pkg
fi

if [ ! -e "MAMP_MAMP_PRO_3.2.1.pkg" ]; then
    cecho "Could not download MAMP";
    exit 1;
fi

if [ -e "MAMP_MAMP_PRO_3.2.1.pkg" ]; then
    SHA="`sha1sum MAMP_MAMP_PRO_3.2.1.pkg | cut -d " " -f 1`";
    if [ "$SHA" != "46df4d77528a7552a911925cb2373da751da46d7" ]; then
        cecho "MAMP sha1 does not match!";
        exit 1;
    fi;
fi;

sudo installer -package MAMP_MAMP_PRO_3.2.1.pkg  -target "/"

