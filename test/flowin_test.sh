#!/bin/bash
# Test availability and very basic content of flowing application routes.


if [ -z "$1" ]; then
    echo "usage: $0 HOSTNAME:PORT"
    echo "       $0 HOSTNAME"
    exit 1;
fi

echo "*** Flowing acceptance tests ***"
return_value=0

# Is the site available ?
curl -s $1/ &> /dev/null
if [ 0 == $? ]; then
    echo -e "#A01 Connecting to server. [ ok ]"
else
    echo -e "#A01 Connecting to server. [ FAILED ] (" $? ")" 
    exit 2
fi

# Does the site present the 'Flowin' page (content check)
curl -s $1/ |grep -i flowin &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C01 Receiving flowin root page. [ ok ]"
else
    echo -e "#C01 Receiving flowin root page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/about' page
curl -s $1/about |grep -i about &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C02 Receiving flowin about page. [ ok ]"
else
    echo -e "#C02 Receiving flowin about page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/hotspots' page
curl -s $1/hotspots |grep -i hotspots &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C03 Receiving hotspots page. [ ok ]"
else
    echo -e "#C03 Receiving hotspots page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/hotspots/' page
curl -s $1/hotspots/ |grep -i hotspots &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C04 Receiving hotspots root page. [ ok ]"
else
    echo -e "#C04 Receiving hotspots root page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/hotspots/map' page
curl -s $1/hotspots/map |grep -i OpenStreetMap &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C05 Receiving hotspots/map page. [ ok ]"
else
    echo -e "#C05 Receiving hotspots/map page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/hotspots/list' page
curl -s $1/hotspots/list |grep -i hotspots &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C06 Receiving hotspots/list page. [ ok ]"
else
    echo -e "#C06 Receiving hotspots/list page. [ FAILED ] (" $? ")"
    return_value=1
fi

# Does the site present the '/hotspots/new' page
curl -s $1/hotspots/new |grep -i Latitude &> /dev/null
if [ 0 == $? ]; then
    echo -e "#C07 Receiving hotspots/new page. [ ok ]"
else
    echo -e "#C07 Receiving hotspots/new page. [ FAILED ] (" $? ")"
    return_value=1
fi

exit $return_value